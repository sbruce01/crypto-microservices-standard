// Sample Agg custom file.

// Can load other files within this file. Note that the current directory
// is the directory of this file (in this example: /opt/kx/custom).

//
// @desc An override to the default ping aggregation function. Instead of doing a raze,
// we just take the min (so true indicates all targets successful).
//
// @param res   {boolean[]} Results from the DAPs.
//
// @return      {boolean}   Min of all DAP results.
//
//
// @desc Agg function that does a plus join on a list of tables.
//
// @param tbls  {table[]}   List plus-joinable tables.
//
// @return      {table}     Plus join.
//
pjAgg:{[tbls]
    (pj/)tbls
    };

razeAgg:{[tbls]
	raze tbls
	};

//
// @desc Agg function that does an average daily count by sym.
//
// @param tbls  {table[]}   List of tables with ``` `sym`date`cnt``` columns.
//
// @return      {table}     Average count by sym
//


//
// In order to be usable, aggregation functions MUST be registered with the Agg process. When registering,
// one can also set the aggregation function as the default aggregation function for one or more APIs.
// For example, Suppose we had an API defined in the DAPs that peforms a "count by" operation on a table:
//
// countBy:{[table;startTS;endTS;byCols]
//     ?[table;enlist(within;`realTime;(startTS;endTS-1));{x!x,:()}byCols;enlist[`cnt]!enlist(count;`i)]
//     }
//
// We can then register our aggregations functions thusly:
//

.sgagg.registerAggFn[`pjAgg;();
    //.sapi.metaDescription["Plus join aggregation"],
    //.sapi.metaParams[`name`type`description!(`tbls;0h;"Tables received from DAPs")],
    //.sapi.metaReturn`type`description!(98h;"The plus join (over) of the tables");
    `countBy]; // Register as default aggregation function for this API


.sgagg.registerAggFn[`razeAgg;();`trade_summary]; // Register as default aggregation function for this API
//
// Note also that an aggregation function can be default aggregation function for multiple APIs. E.g.
//  .sgagg.registerAggFn[`myAggFn;();`api1`api2`api3]
//
