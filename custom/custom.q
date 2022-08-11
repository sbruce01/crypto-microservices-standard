// Sample DA custom file.

// Can load other files within this file. Note that the current directory
// is the directory of this file (in this example: /opt/kx/custom).
//\l subFolder/otherFile1.q
//\l subFolder/otherFile2.q

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


trade_summary:{[startTS;endTS]
	0!?[`trade;enlist(within;`time;(startTS;endTS));`sym`time!(`sym;(+;`time.date;(xbar;5;`time.minute)));`trades`volume`price`dap!((count;`i);(sum;`size);(avg;`price);enlist .da.cfg.mountName)]
    }


.da.registerAPI[`trade_summary;
    .sapi.metaDescription["Define a new API. Counts number of entries by specified columns."],
    //.sapi.metaParam[`name`type`isReq`description!(`args;99h;1b;"Arguments - table, startTS, endTS, byCols")],
    .sapi.metaParam[`name`type`isReq`description!(`startTS;-12h;1b;"Start time (inclusive).")],
    .sapi.metaParam[`name`type`isReq`description!(`endTS;-12h;1b;"End time (exclusive).")],
    .sapi.metaReturn[`type`description!(98h;"Count by specified columns.")],
    .sapi.metaMisc[enlist[`safe]!enlist 1b]
    ]

// Just works
.da.i.eorReceived:1b