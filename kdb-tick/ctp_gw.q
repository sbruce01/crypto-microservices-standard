/q tick.q SRC [DST] [-p 5010] [-o h]
system"l tick/sym.q"

// open handle to gw
gw:hopen "J"$last ":" vs first system"docker port crypto-sggw-1"

// load in and define other tables to publish
last_book:([]time:"p"$();sym:`$();side:`$();price:"f"$();size:"f"$());
vwaps:([]time:"p"$();sym:`$();vwap_bid_1:"f"$(); vwap_bid_5000000:"f"$(); vwap_bid_10000000:"f"$();vwap_ask_1:"f"$(); vwap_ask_5000000:"f"$(); vwap_ask_10000000:"f"$());

vwap_depth:{$[any z<=s:sums x;(deltas z & s) wavg y;0nf]};

calc_vwap:{[x]
	res:select time, sym, 
	       vwap_bid_1:vwap_depth'[bidsizes;bids;1], vwap_bid_5000000:vwap_depth'[bidsizes;bids;5000000], vwap_bid_10000000:vwap_depth'[bidsizes;bids;10000000] 
  	      ,vwap_ask_1:vwap_depth'[asksizes;asks;1], vwap_ask_5000000:vwap_depth'[asksizes;asks;5000000], vwap_ask_10000000:vwap_depth'[asksizes;asks;10000000]
		from x;
	.debug.vwaps:res;
	.u.pub[`vwaps;res];
	}

calc_last_book:{.u.pub[`last_book;] .debug.last_book:
		       {(ungroup select time,sym,side:`bid,price:bids,size: bidsizes from x), 
			(ungroup select time,sym,side:`offer,price:asks,size:asksizes from x)} x;
	}

.stream.functions:``book!(::;`calc_vwap`calc_last_book)
.stream.snap:`book`trade!(
        {last gw(`.kxi.getData;(`table`startTS`endTS)!(`orderbook;.z.p-0D00:01:00;.z.p);`f;(0#`)!())};
        {last gw(`.kxi.getData;(`table`startTS`endTS)!(`trade;.z.p-0D00:01:00;.z.p);`f;(0#`)!())}
	)


\l tick/u.q
\d .u
ld:{if[not type key L::`$(-10_string L),string x;.[L;();:;()]];i::j::-11!(-2;L);if[0<=type i;-2 (string L)," is a corrupt log. Truncate to length ",(string last i)," and restart";exit 1];hopen L};
tick:{init[];
	if[not min(`time`sym~2#key flip value@)each t;'`timesym];@[;`sym;`g#]each t;d::.z.D;if[l::count y;L::`$":",y,"/",x,10#".";l::ld d]
	};

endofday:{ } //end d;d+:1;if[l;hclose l;l::0(`.u.ld;d)]};
ts:{ } //if[d<x;if[d<x-1;system"t 0";'"more than one day?"];endofday[]]};

upd:{[t;x]
 .debug.tx:(t;x);
 ts"d"$a:.z.P;
 //if[not -16=type first first x;a:"n"$a;x:$[0>type first x;a,x;(enlist(count first x)#a),x]];
 f:key flip value t;
 pub[t;data:$[0>type first x;enlist f!x;flip f!x]];
 .stream.functions[t] @\: data;
	}

snap:{[x]
	.stream.snap[x 0]x 1
 }

\d .
upd:{.u.upd[x;value flip y]}

// load up tick tables so this process can publish
/.u.tick[src;.z.x 1];
.u.init[]
// subscribe to the actual TP
/ get the ticker plant and history ports, defaults are 5010,5012
.u.x:.z.x,(count .z.x)_(":5010";":5012");

/ init schema and sync up from log file;cd to hdb(so client save can run)
.u.rep:{[x;y]} //(.[;();:;].)each x;if[null first y;:()];-11!y;system "cd ",1_-10_string first reverse y};

/ connect to ticker plant for (schema;(logcount;log))
.u.rep .(hopen `$":",.u.x 1)"(.u.sub[`;`];`.u `i`L)";

