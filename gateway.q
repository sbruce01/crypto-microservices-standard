/ no dayend except 0#, can connect to tick.q or chainedtick.q tickerplant
/ q gw.q localhost:5002 localhost:5008 -p 511 </dev/null >foo 2>&1 & 

if[not system"p";system"p 40002"]

// Open connection to sggw
gw:hopen "J"$last ":" vs first system"docker port crypto-sggw-1"

// Attempting to import the rest functionality
$["/"=last getenv`QHOME;runCommand:"l ",a:,[getenv`QHOME;"rest.q_"];runCommand:"l ",a:,[getenv`QHOME;"/rest.q_"]];

.gda.restEnabled:0b;

loadRestFunctionality:{
  system[x];
  .gda.restEnabled:1b;
  0N!"Successfully loaded in Rest";
 };

@[loadRestFunctionality;runCommand;{0N!"Rest Failed to Load",x}];

// vwap calculation
//TODO: This should be called somewhere other than in the dashboard
vwap_depth:{$[any z<=s:sums x;(deltas z & s) wavg y;0nf]};

// Defining a function to query data from within a Q session (long way build up later)
getData:{[tbl;sd;ed;ids;exc]
    wClause:();
    if[not all null ids;wClause,:enlist("in";`sym;(),ids)];
    if[not all null exc;wClause,:enlist("in";`exchange;(),exc)];
    tab:$[all null ids,exc;
        last gw(`.kxi.getData;`table`startTS`endTS!(tbl;sd;ed);`callback;(0#`)!());
        last gw(`.kxi.getData;`table`startTS`endTS`filter!(tbl;sd;ed;wClause);`callback;(0#`)!())
    ];
    :tab
  };

getCorrelation:{[exchange;startTime;endTime]
    data:getData[`vwap;startTime;endTime;`;exchange];
    res:select vwap:accVol wavg vwap by sym, time from data where not null vwap;
    times:([]time:asc distinct exec time from res);
    rack:times cross select distinct sym from res;
    col_order:exec sym from `mcap xdesc select mcap:sum vwap*accVol by sym from data where not null vwap;
    matrix:update fills vwap by sym from rack lj res;
    correlation:{x cor/:\: x} col_order xcols exec vwap by sym from matrix;
    areCols:(cols correlation) where {not all null value x} each -1_value update sym:key[correlation] from correlation;
    $[count areCols;:areCols!flip areCols!correlation[areCols][areCols];:()];
  };

// Defining a funciton to query data with the specification of columns to retain
getDataWithCols:{[tbl;sd;ed;ids;exc;columns]
    wClause:();
    if[not all null ids;wClause,:enlist("in";`sym;(),ids)];    
    if[not all null exc;wClause,:enlist("in";`exchange;(),exc)];    
    tab:$[all null ids,exc;
        $[all null columns;last gw(`.kxi.getData;`table`startTS`endTS!(tbl;sd;ed);`callback;(0#`)!());last gw(`.kxi.getData;`table`startTS`endTS`agg!(tbl;sd;ed;columns);`callback;(0#`)!())];
        $[all null columns;last gw(`.kxi.getData;`table`startTS`endTS`filter!(tbl;sd;ed;wClause);`callback;(0#`)!());last gw(`.kxi.getData;`table`startTS`endTS`filter`agg!(tbl;sd;ed;wClause;columns);`callback;(0#`)!())]
    ];
    :tab
    };
    

// If the rest functionality has been imported successfully set registers
if[.gda.restEnabled;
  // Defining the function to be called from the REST endpoint
  .db.getDataREST:{
    .debug.getDataREST:x;
    tbl:x[`arg;`tbl];
    sd:$[(.z.p*0)~x[`arg;`sd];.z.p-00:01:00.000000000;x[`arg;`sd]];
    ed:$[(.z.p*0)~x[`arg;`ed];.z.p;x[`arg;`ed]];
    ids:x[`arg;`ids];
    exc:x[`arg;`exc];
    getData[tbl;sd;ed;ids;exc]};

  .db.getDataWithColsREST:{
    .debug.getDataWithColsREST:x;
    tbl:x[`arg;`tbl];
    sd:$[(.z.p*0)~x[`arg;`sd];.z.p-00:01:00.000000000;x[`arg;`sd]];
    ed:$[(.z.p*0)~x[`arg;`ed];.z.p;x[`arg;`ed]];
    ids:x[`arg;`ids];
    exc:x[`arg;`exc];
    columns:x[`arg;`columns];
    getDataWithCols[tbl;sd;ed;ids;exc;columns]};

  / Alias namespace for convenience, typically once at beginning of file
  .rest:.com_kx_rest;

  .rest.init enlist[`autoBind]!enlist[1b]; / Initialize
  // Adding in the register
  .rest.register[`get;
    "/getData";
    "API with format of getData";
    .db.getDataREST;
    .rest.reg.data[`tbl;-11h;0b;`trade;"Table to Query"],
      .rest.reg.data[`sd;-12h;0b;.z.p*0;"Start Date"],
          .rest.reg.data[`ed;-12h;0b;.z.p*0;"End Date"],
              .rest.reg.data[`ids;11h;0b;0#`;"Instruments to subscribe to"],
                  .rest.reg.data[`exc;11h;0b;0#`;"Exchange to subscribe to"]];

  // Adding Column Based Register
  .rest.register[`get;
    "/getDataWithCols";
    "API with format of getDataWithCols";
    .db.getDataWithColsREST;
    .rest.reg.data[`tbl;-11h;0b;`trade;"Table to Query"],
      .rest.reg.data[`sd;-12h;0b;.z.p*0;"Start Date"],
          .rest.reg.data[`ed;-12h;0b;.z.p*0;"End Date"],
              .rest.reg.data[`ids;11h;0b;0#`;"Instruments to subscribe to"],
                  .rest.reg.data[`exc;11h;0b;0#`;"Exchange to subscribe to"],
                    .rest.reg.data[`columns;11h;0b;0#`;"Columns to filter on Q side"]];
  ];
