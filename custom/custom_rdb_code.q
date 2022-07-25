//
// @desc Define a new API. Counts number of entries by specified columns.
//
// @param table     {symbol}            Table name.
// @param byCols    {symbol|symbol[]}   Column(s) to count by.
// @param startTS   {timestamp}         Start time (inclusive).
// @param endTS     {timestamp}         End time (exclusive).
//
// @return          {table}             Count by specified columns.
//
countBy:{[table;startTS;endTS;byCols]
    ?[table;enlist(within;`realTime_rdb;(startTS;endTS-1));{x!x,:()}byCols;enlist[`cnt]!enlist(count;`i)]
    }

// Register with the DA process.
.da.registerAPI[`countBy;
    .sapi.metaDescription["Define a new API. Counts number of entries by specified columns."],
    .sapi.metaParam[`name`type`isReq`description!(`table;-11h;1b;"Table name.")],
    .sapi.metaParam[`name`type`isReq`description!(`byCols;-11 11h;1b;"Column(s) to count by.")],
    .sapi.metaParam[`name`type`isReq`description!(`startTS;-12h;1b;"Start time (inclusive).")],
    .sapi.metaParam[`name`type`isReq`description!(`endTS;-12h;1b;"End time (exclusive).")],
    .sapi.metaReturn[`type`description!(98h;"Count by specified columns.")]
    .sapi.metaMisc[enlist[`safe]!enlist 1b]
    ]

7+7

avgBy:{[table;startTS;endTS;byCols]
    ?[table;enlist(within;`realTime;(startTS;endTS-1));{x!x,:()}byCols;enlist[`cnt]!enlist(avg;`i)]
    }


// Register with the DA process.
.da.registerAPI[`avgBy;
    .sapi.metaDescription["Define a new API. Avg number of entries by specified columns."],
    .sapi.metaParam[`name`type`isReq`description!(`table;-11h;1b;"Table name.")],
    .sapi.metaParam[`name`type`isReq`description!(`byCols;-11 11h;1b;"Column(s) to count by.")],
    .sapi.metaParam[`name`type`isReq`description!(`startTS;-12h;1b;"Start time (inclusive).")],
    .sapi.metaParam[`name`type`isReq`description!(`endTS;-12h;1b;"End time (exclusive).")],
    .sapi.metaReturn[`type`description!(98h;"Count by specified columns.")]
    .sapi.metaMisc[enlist[`safe]!enlist 1b]
    ]
