.qsp.run
  .qsp.read.fromCallback[`upd]              /read data from the upd function
  .qsp.window.timer[00:00:05]               /buffer rcvd data into 5-second buckets
  .qsp.map[{[op;md;data]
    .qsp.set[op;md] exec max val from data  /store and emit max value for each window
    }; .qsp.use`name`state!(`maxval; 0f)]   /name this stateful operator for reference later
  .qsp.write.toConsole[]                    /write output to console for debugging