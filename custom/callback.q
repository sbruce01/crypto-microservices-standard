// Logging on/off
.debug.logging:1b;

// Define book tables
book: ([]`s#time:"p"$();`g#sym:`$();bids:();bidsizes:();asks:();asksizes:());
lastBookBySymExch:([sym:`$();exchange:`$()]bidbook:();askbook:());

//////////////////// Define Functions for Book

bookbuilder:{[x;y]
    .debug.xy:(x;y);
    $[not y 0;x;
        $[
            `insert=y 4;
                x,enlist[y 1]! enlist y 2 3;
            `update=y 4;
                $[any (y 1) in key x;
                    [
                        //update size
                        a:.[x;(y 1;1);:;y 3];
                        //update price if the price col is not null
                        $[0n<>y 2;.[a;(y 1;0);:;y 2];a]
                    ];
                    x,enlist[y 1]! enlist y 2 3
                ];  
            `remove=y 4;
                $[any (y 1) in key x;
                    enlist[y 1] _ x;
                    x];
            x
        ]
    ]
    };

generateOrderbook:{[newOrder]
    books:update bidbook:bookbuilder\[@[lastBookBySymExch;(first sym; first exchange)]`bidbook;flip (side like "bid";orderID;price;size;action)],askbook:bookbuilder\[@[lastBookBySymExch;(first sym; first exchange)]`askbook;flip (side like "ask";orderID;price;size;action)] by sym, exchange from newOrder;
    lastBookBySymExch,:exec last bidbook,last askbook by sym, exchange from books;
    //generate the orderbook 
    books:select time,sym,exchange,bids:(value each bidbook)[;;0],bidsizes:(value each bidbook)[;;1],asks:(value each askbook)[;;0],asksizes:(value each askbook)[;;1] from books;
    books:update bids:desc each distinct each bids,bidsizes:{sum each x group y}'[bidsizes;bids] @' desc each distinct each bids,asks:asc each distinct each asks,asksizes:{sum each x group y}'[asksizes;asks] @' asc each distinct each asks from books

    };

///////////////////////////////////////////////

// Streams

ohlcv_stream: .qsp.read.fromCallback[`ohlcv]
  .qsp.window.tumbling[00:00:10; `time; .qsp.use ``sort!11b]
  .qsp.map[ { (`ohlcv;value flip 0!select open:first price, high:max price, low:min price, close:last price, volume:sum size by sym, exchange, time:(`date$time) + time.minute from x) }]
  .qsp.write.toProcess[.qsp.use `handle`target`spread!(`$raze ":",(.Q.opt[.z.x] `ip_address),":",(.Q.opt[.z.x] `tp_port);`.u.upd;1b)]
  / .qsp.write.toConsole[]


vwap_stream: .qsp.read.fromCallback[`vwap]
  .qsp.window.tumbling[00:00:10; `time; .qsp.use ``sort!11b]  // 10 second for debugging
  .qsp.map[ { (`vwap;value flip 0!select vwap:size wavg price, accVol:sum size by sym, exchange, time:(`date$time) + time.minute from x) }]
  .qsp.write.toProcess[.qsp.use `handle`target`spread!(`$raze ":",(.Q.opt[.z.x] `ip_address),":",(.Q.opt[.z.x] `tp_port);`.u.upd;1b)]
  / .qsp.write.toConsole[]

book_stream: .qsp.read.fromCallback[`bookCallback]
  .qsp.window.tumbling[00:00:10; `time; .qsp.use ``sort!11b]
  .qsp.map[ { (`book;first select time from x) }]
/   .qsp.write.toProcess[.qsp.use `handle`target`spread!(`$raze ":",(.Q.opt[.z.x] `ip_address),":",(.Q.opt[.z.x] `tp_port);`.u.upd;1b)]
  .qsp.write.toConsole[]


.qsp.onStart {
  // Link up to TP and subscribe for updates
  if[.debug.logging;0N!raze "Connecting to the TP with host of: ",.Q.opt[.z.x] `ip_address];
  / s: .z.p; while[(null .tp.h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";0N])&.z.p<s+00:00:30;0];
  s: .z.p; while[(null .tp.h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":",(.Q.opt[.z.x] `tp_port);0N])&.z.p<s+00:00:30;0];
  // Handle TP log replay being lists instead of tables
/   upd::enlist[`trade]!enlist{ohlcv flip cols[trade]!x;vwap flip cols[trade]!x};
  upd::(`trade;`order)!({ohlcv flip cols[trade]!x;vwap flip cols[trade]!x};{bookCallback flip cols[order]!x});
  // Subscribe to the relevant table for this pipeline
   
  {(set). x;-11!y}. .tp.h"(.u.sub[`trade;`]; (.u.i;`$\":/opt/kx/tp_log_dir/\",last \"/\" vs string[.u.L]))";
  {(set). x;-11!y}. .tp.h"(.u.add[`order;`]; (.u.i;`$\":/opt/kx/tp_log_dir/\",last \"/\" vs string[.u.L]))";
  // Define Tick callback for live (non-log replay) updates
  if[.debug.logging;0N!"Subscribed for tables:"];
  if[.debug.logging;0N!tables[]];

/   upd::enlist[`trade]!enlist {ohlcv x;vwap x};
  upd::(`trade;`order)!({ohlcv x;vwap x};{bookCallback x});
   }

.qsp.onCheckpoint { -1 "Checkpoint callback"; }
.qsp.onRecover { -1 "Recover callback"; }

// Purge in-memory state at eod
.u.end: { .qsp.checkpoint[]; .qsp.set[`apply;()!();()]; }

// Start the pipeline
.qsp.run (ohlcv_stream;vwap_stream;book_stream)