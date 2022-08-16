.debug.logging:1b;

stream: 
  .qsp.read.fromCallback[`ohlcv]
  .qsp.window.tumbling[00:01:00; `time; .qsp.use ``sort!11b]
  // ohlcv analytic
  .qsp.map[ { 
    vwap_tab:select vwap:size wavg price, accVol:sum size by sym, exchange, time:(`date$time) + time.minute from x;
    ohlcv_tab:select open:first price, high:max price, low:min price, close:last price, volume:sum size by sym, exchange, time:(`date$time) + time.minute from x;
    ((`vwap;`ohlcv);(vwap_tab;ohlcv_tab))} ]
  / // Write output events to the console for local debugging
  .qsp.write.toProcess[.qsp.use `handle`target`spread!(`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";`.u.sp_upd;1b)]
  / .qsp.write.toConsole[]

.qsp.onStart {
  // Link up to TP and subscribe for updates
  if[.debug.logging;0N!raze "Connecting to the TP with host of: ",.Q.opt[.z.x] `ip_address];
  s: .z.p; while[(null .tp.h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";0N])&.z.p<s+00:00:30;0];
  // Handle TP log replay being lists instead of tables
  if[.debug.logging;0N!"Initiating update function for log replay"];
  upd::enlist[`trade]!enlist{ohlcv flip cols[trade]!x};
  // Subscribe to the relevant table for this pipeline
  if[.debug.logging;0N!"Subscribing to tables"];
  / {(set). x;-11!y}. h"(.u.sub[`trade;`]; .u`i`L)";
  {(set). x;-11!y}. .tp.h"(.u.sub[`trade;`]; (.u.i;`:/opt/kx/tp_log_dir/crypto2022.08.16))";
  // Define Tick callback for live (non-log replay) updates
  if[.debug.logging;0N!"Subscribed for tables:"];
  if[.debug.logging;0N!tables[]];
  if[.debug.logging;0N!"Setting update function for streaming data"];
  upd::enlist[`trade]!enlist ohlcv;
   }

.qsp.onCheckpoint { -1 "Checkpoint callback"; }
.qsp.onRecover { -1 "Recover callback"; }

// Purge in-memory state at eod
.u.end: { .qsp.checkpoint[]; .qsp.set[`apply;()!();()]; }

// Start the pipeline
.qsp.run stream