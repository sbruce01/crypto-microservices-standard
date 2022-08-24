countBy:{[table;startTS;endTS;byCols]
    ?[table;enlist(within;`time;(startTS;endTS-1));{x!x,:()}byCols;enlist[`cnt]!enlist(count;`i)]
    }


.da.registerAPI[`countBy;
    .sapi.metaDescription["Define a new API. Counts number of entries by specified columns."],
    //.sapi.metaParam[`name`type`isReq`description!(`args;99h;1b;"Arguments - table, startTS, endTS, byCols")],
    .sapi.metaParam[`name`type`isReq`description!(`table;-11h;1b;"Table name.")],
    .sapi.metaParam[`name`type`isReq`description!(`byCols;-11 11h;1b;"Column(s) to count by.")],
    .sapi.metaParam[`name`type`isReq`description!(`startTS;-12h;1b;"Start time (inclusive).")],
    .sapi.metaParam[`name`type`isReq`description!(`endTS;-12h;1b;"End time (exclusive).")],
    .sapi.metaReturn[`type`description!(98h;"Count by specified columns.")],
    .sapi.metaMisc[enlist[`safe]!enlist 1b]
    ]

// TODO: Find solution for this:
// Makes RDB Queryable, but custom aggs not return
.da.i.eorReceived:1b