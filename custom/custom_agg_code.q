
pjAgg:{[tbls]
    (pj/)tbls
    };

/ .sgagg.registerAggFn[`pjAgg;
/     .sapi.metaDescription["Plus join aggregation"],
/     .sapi.metaParam[`name`type`description!(`tbls;0h;"Tables received from DAPs")],
/     .sapi.metaReturn`type`description!(98h;"The plus join (over) of the tables");
/     `countBy // Register as default aggregation function for this API
/     ]

.sgagg.registerAggFn[`pjAgg;();
    //.sapi.metaDescription["Plus join aggregation"],
    //.sapi.metaParams[`name`type`description!(`tbls;0h;"Tables received from DAPs")],
    //.sapi.metaReturn`type`description!(98h;"The plus join (over) of the tables");
    `countBy]; // Register as default aggregation function for this API