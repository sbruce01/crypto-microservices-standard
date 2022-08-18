.debug.logging:1b;

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


.qsp.onStart {
  // Link up to TP and subscribe for updates
  if[.debug.logging;0N!raze "Connecting to the TP with host of: ",.Q.opt[.z.x] `ip_address];
  / s: .z.p; while[(null .tp.h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";0N])&.z.p<s+00:00:30;0];
  s: .z.p; while[(null .tp.h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":",(.Q.opt[.z.x] `tp_port);0N])&.z.p<s+00:00:30;0];
  // Handle TP log replay being lists instead of tables
  / upd::enlist[`trade]!enlist{ohlcv flip cols[trade]!x};
  upd::enlist[`trade]!enlist{ohlcv flip cols[trade]!x;vwap flip cols[trade]!x};
  / upd::`trade`trade!({ohlcv flip cols[trade]!x};vwap flip cols[trade]!x);
  // Subscribe to the relevant table for this pipeline
  {(set). x;-11!y}. .tp.h"(.u.sub[`trade;`]; (.u.i;`$\":/opt/kx/tp_log_dir/\",last \"/\" vs string[.u.L]))";
  // Define Tick callback for live (non-log replay) updates
  if[.debug.logging;0N!"Subscribed for tables:"];
  if[.debug.logging;0N!tables[]];
  / upd::enlist[`trade]!enlist ohlcv;
  upd::enlist[`trade]!enlist {ohlcv x;vwap x};
  / upd::`trade`trade!(ohlcv;vwap);
   }

.qsp.onCheckpoint { -1 "Checkpoint callback"; }
.qsp.onRecover { -1 "Recover callback"; }

// Purge in-memory state at eod
.u.end: { .qsp.checkpoint[]; .qsp.set[`apply;()!();()]; }

// Start the pipeline
.qsp.run (ohlcv_stream;vwap_stream)