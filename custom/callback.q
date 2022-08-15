.debug.logging:1b;
// Read any data passed to the local callback function `publish` - this function
// will be created in the global namespace when running the stream
stream: .qsp.read.fromCallback[`publish]
    / .debug.logging:1b;
  // Create a sliding window firing every 5 seconds in event time on the
  // last 10 seconds of data. ".z.d+x`time" assigns the event-time timestamp
  // associated with each record in order to assign buckets to the correct
  // windows.
  //
  // This window is also snapped, so will fire at `00:00:05, 00:00:10, 00:00:15,
  // etc` regardless of when the pipeline is started.
/   .qsp.window.sliding[00:00:05; 00:00:10; .qsp.use`timeAssigner`snap!({.z.d+x`time}; 1b)]


  / Run a stateful map calculating a custom analytic over the incoming data.
  / .qsp.map[
  /   {[o;m;x]
  /     if[.debug.logging;0N!"Starting complex custom analytic, with arguments:";0N!x];
  /     s:  .qsp.get[o;m];

  /     d:  select size:sums size, sp:sums size * price by sym from x;
  /     l:  first each/: select last each size, last each sp by sym from d;
  /     vw: update ts: m`window, sym:x`sym from
  /       select vw:sp % size from ungroup key[d]!(0^s key d) + value d;

  /     .qsp.set[o;m;@[s;key l;:;value l]]; vw
  /   };
  /   .qsp.use``state!(::; ([sym:0#`]size:0#0;sp:0#0f))
  / ]

  // Select the maximum value for each symbol of the last analytic for each window
/   .qsp.map[{ select max vw by sym, ts from x }]
/   .qsp.map[{if[.debug.logging;0N!"Starting max value analytic"]; select max price by sym, exchange from x }]
  .qsp.map[{ 0!select max price by sym, exchange from x }]


  // Write output events to the console for local debugging
  .qsp.write.toConsole[]


// When the pipeline is started by the Controller, the `onStart` hook is fired.
// At this point, a tickerplant, or any other pub/sub interface, could be subscribed
// to, using the local function `publish` as the callback.
.qsp.onStart {
  // Link up to TP and subscribe for updates
  if[.debug.logging;0N!raze "Connecting to the TP with host of: ",.Q.opt[.z.x] `ip_address];
  s: .z.p; while[(null h:@[hopen;`$raze ":",(.Q.opt[.z.x] `ip_address),":5010";0N])&.z.p<s+00:00:30;0];
  // Handle TP log replay being lists instead of tables
  if[.debug.logging;0N!"Initiating update function for log replay"];
  upd::enlist[`trade]!enlist{publish flip cols[trade]!x};
  // Subscribe to the relevant table for this pipeline
  if[.debug.logging;0N!"Subscribing to tables"];
  / {(set). x;-11!y}. h"(.u.sub[`trade;`]; .u`i`L)";
  {(set). x;-11!y}. h"(.u.sub[`trade;`]; (.u.i;`:/opt/kx/tp_log_dir/crypto2022.08.15))";
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