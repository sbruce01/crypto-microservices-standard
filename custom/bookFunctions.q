// Define book tables
book: ([]`s#time:"p"$();`g#sym:`$();bids:();bidsizes:();asks:();asksizes:());

//////////////////// Define Functions for Book

bookbuilder:{[x;y]
    .debug.xy:(x;y);
    $[not y 0;x;
        $[
            `insert=y 4;
                x,enlist[y 1]! enlist y 2 3;
            `update=y 4;
                $[any (y 1) in key x;
                    [
                        //update size
                        a:.[x;(y 1;1);:;y 3];
                        //update price if the price col is not null
                        $[0n<>y 2;.[a;(y 1;0);:;y 2];a]
                    ];
                    x,enlist[y 1]! enlist y 2 3
                ];  
            `remove=y 4;
                $[any (y 1) in key x;
                    enlist[y 1] _ x;
                    x];
            x
        ]
    ]
    };