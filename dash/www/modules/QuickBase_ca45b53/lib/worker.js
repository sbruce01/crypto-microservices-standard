function l(h){var k;return function(){k&&clearTimeout(k);k=setTimeout(function(){k=void 0;h()},15E3)}}var m=console.log.bind(console,"%s",function(){function h(){}h.toString=function(){var k=new Date,h=""+k.getMilliseconds();return"INFO\t"+k.toTimeString().substring(0,8)+"."+(2===h.length?"0":"")+h+"\t"};return h}()),n;
(function(h){var k=function(){return function(b,a,f,c){this.s=b;this.j=a;this.query=f;this.i=c;this.timestamp=(new Date).getTime()}}();h.K=k;var r=function(){function b(a,f){this.c={};this.a=null;this.I=1;this.l=l(this.v.bind(this));this.m();this.o=a;this.h=f}b.prototype.unsubscribe=function(a){delete this.c[a];this.f(new k(4),a)};b.prototype.f=function(a,f){if(this.a&&this.a.readyState===WebSocket.OPEN){f=f||this.I++;this.c[f]=a;var c=[];a.j&&a.query&&(c.push(a.j),c.push(a.query));var b=24;c.forEach(function(a){b+=
null===a?0:a.length});var d=new Uint8Array(b),e=new DataView(d.buffer);e.setInt32(0,1,!0);e.setInt32(4,b,!0);e.setUint8(8,0);e.setUint8(9,0);e.setInt32(10,2+c.length,!0);e.setUint8(14,250);e.setInt32(15,f,!0);e.setUint8(19,250);e.setInt32(20,a.s,!0);var p=24;c.forEach(function(a){null!==a&&(d.set(a,p),p+=a.byteLength)});this.a.send(d.buffer);this.l();return f}return 0};b.prototype.g=function(){if(this.a)try{this.a.onopen=this.a.onclose=this.a.onmessage=function(){},this.a.close(),this.a=null}catch(a){this.a=
null}};b.prototype.m=function(){try{var a="file:"===location.protocol?"ws://localhost:10001/":("https:"===location.protocol?"wss://":"ws://")+location.host+"/api/ws";m(b.b+a);this.a=new WebSocket(a);this.a.binaryType="arraybuffer";this.a.onopen=this.H.bind(this);this.a.onclose=this.D.bind(this);this.a.onerror=this.F.bind(this);this.a.onmessage=this.G.bind(this)}catch(f){m(b.b+"Create Err",f),this.h("create websocket error",f)}this.l()};b.prototype.v=function(){this.a?
this.f(new k(0)):this.m()};b.prototype.J=function(a){for(var f="",c,b,d,e=0;e<a.length;e++)switch((c=a[e])>>4){case 0:case 1:case 2:case 3:case 4:case 5:case 6:case 7:f+=String.fromCharCode(c);break;case 12:case 13:b=a[++e];f+=String.fromCharCode((c&31)<<6|b&63);break;case 14:b=a[++e],d=a[++e],f+=String.fromCharCode((c&15)<<12|(b&63)<<6|(d&63)<<0)}return f};b.prototype.D=function(a){m(b.b+"Closed",a);this.o(this.a?this.a.readyState:WebSocket.CLOSED,a.reason||a.type);this.g()};b.prototype.F=function(a){m(b.b+
"Error",a);this.h(a);this.g()};b.prototype.G=function(a){var b=new DataView(a.data),c=b.getInt32(15,!0),g=b.getUint8(20),d=this.c[c];d?(3!==d.s&&delete this.c[c],d.i&&(b.setFloat64(0,(new Date).getTime(),!0),d.i(b.buffer))):5===g?(this.h(this.J(new Uint8Array(a.data.slice(27)))),this.g()):console.log("Stray Response "+c)};b.prototype.H=function(a){m(b.b+"Open",a);this.o(this.a?this.a.readyState:WebSocket.CLOSED,a.type)};b.b="Socket ";return b}(),t=function(){function b(a){this.ports=[];this.scope=
a;this.client=new r(this.C.bind(this),this.A.bind(this))}b.prototype.w=function(a){var b=this,c=a.ports[0];this.ports.push(c);var g={};c.onmessage=function(a){function f(a){(new DataView(a)).setInt32(15,d,!0);c.postMessage(a,[a]);3!==h&&delete g[d]}var d=a.data[0],h=a.data[1];switch(h){case 1:case 2:case 3:g[d]=b.client.f(new k(h,a.data[2],a.data[3],f));break;case 4:b.client.unsubscribe(g[d]);delete g[d];break;case 6:"Closing"===a.data[1]&&(Object.keys(g).forEach(function(a){return b.client.unsubscribe(g[Number(a)])}),
b.ports.splice(b.ports.indexOf(c),1),c.close());break;default:debugger}};this.client&&this.client.a&&this.client.a.readyState===WebSocket.OPEN&&c.postMessage([6,WebSocket.OPEN,null])};b.prototype.A=function(a){this.ports.forEach(function(b){try{b.postMessage([5,a||"WS Error"])}catch(c){}})};b.prototype.B=function(a){function b(a){(new DataView(a)).setInt32(15,d,!0);postMessage(a,[a]);3!==e&&delete g[d]}var c=this,g={},d=a.data[0],e=a.data[1];switch(e){case 1:case 2:case 3:g[d]=this.client.f(new k(e,
a.data[2],a.data[3],b));break;case 4:this.client.unsubscribe(g[d]);delete g[d];break;case 6:"Closing"===a.data[1]&&Object.keys(g).forEach(function(a){return c.client.unsubscribe(g[Number(a)])})}};b.prototype.C=function(a,b){for(var c=0;c<this.ports.length;c++)try{this.ports[c].postMessage([6,a,b||null])}catch(g){debugger}};return b}();h.u=t})(n||(n={}));var q=new n.u(this);void 0!==this.onconnect?this.addEventListener("connect",q.w.bind(q)):(q.ports.push(this),this.onmessage=q.B.bind(q));
