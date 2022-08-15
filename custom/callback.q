.debug.logging:1b;
// Read any data passed to the local callback function `publish` - this function
// will be created in the global namespace when running the stream
stream: .qsp.read.fromCallback[`publish]

////////////////////////// DEV //////////////////////////////////

  / Version to return to a funciton if using .qsp.write.toProcess
  .qsp.map[{ (`maxPrice;0!select max price by sym, exchange from x) }]

  // Write output events to the console for local debugging
  / .qsp.write.toConsole[]
  / .qsp.write.toProcess[.qsp.use `handle`target`spread!(`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";`.u.upd;1b)]


  [.qsp.use `handle`target`spread!(`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";`.test.set;1b)]


////////////////////////// END DEV //////////////////////////////////


// When the pipeline is started by the Controller, the `onStart` hook is fired.
// At this point, a tickerplant, or any other pub/sub interface, could be subscribed
// to, using the local function `publish` as the callback.
.qsp.onStart {
  // Link up to TP and subscribe for updates
  if[.debug.logging;0N!raze "Connecting to the TP with host of: ",.Q.opt[.z.x] `ip_address];
  s: .z.p; while[(null .tp.h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";0N])&.z.p<s+00:00:30;0];
  // Handle TP log replay being lists instead of tables
  if[.debug.logging;0N!"Initiating update function for log replay"];
  upd::enlist[`trade]!enlist{publish flip cols[trade]!x};
  // Subscribe to the relevant table for this pipeline
  if[.debug.logging;0N!"Subscribing to tables"];
  / {(set). x;-11!y}. h"(.u.sub[`trade;`]; .u`i`L)";
  {(set). x;-11!y}. .tp.h"(.u.sub[`trade;`]; (.u.i;`:/opt/kx/tp_log_dir/crypto2022.08.15))";
  // Define Tick callback for live (non-log replay) updates
  if[.debug.logging;0N!"Subscribed for tables:"];
  if[.debug.logging;0N!tables[]];
  if[.debug.logging;0N!"Setting update function for streaming data"];
  upd::enlist[`trade]!enlist publish; }

.qsp.onCheckpoint { -1 "Checkpoint callback"; }
.qsp.onRecover { -1 "Recover callback"; }

// Purge in-memory state at eod
.u.end: { .qsp.checkpoint[]; .qsp.set[`apply;()!();()]; }

// Start the pipeline
.qsp.run stream