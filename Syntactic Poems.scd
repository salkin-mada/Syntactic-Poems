
(
// boot RPI serv
s.options.memSize_(8192*30);
s.latency= 0.05;
s.boot;
/*s.doWhenBooted{
	("\n*** memSize; "++s.options.memSize).post;
	s.recChannels_(2);
	("\n~~~~~~~~~~~~~~~~~~~~~~~" ++ "\n*** Overwriting recChannels to: " ++ s.recChannels ++ "\n").post;
}*/
)




(
l= 900;    //global window/buffer size in pixels/samples
{
	//--variables
	var theta= 0;
	var fps= 20;
	var arr= Array.fill(l, 0);
	var cnt= 0;

	//--window setup
	var width= l/**1.60*/, height= l;
	var w= Window("gendar_theta", Rect(0, 0, width, height), true);
	var u= UserView(w, Rect(0, 0, width/**2*/, height));
	var w2= width*0.5;
	var h2= height*0.5;
	var cellWidth= 10, cellHeight= 10;

	//--buffer
	~bufferForPen= Buffer.alloc(s, l, 2);
	s.sync;

	// for poem 49
	~ge= Buffer.alloc(s, 8192, 2);
	s.sync;

	//--interface
	~amp = 0.3;
	~speed = 0.00001;
	~trails = 0.2;
	~flip= 1;
	~version = 9;
	~red = 1.0;
	~green = 1.0;
	~blue = 1.0;
	~alpha = 1.0;

	//--main loop
	u.drawFunc= {
		//uncomment framerate display in the two lines below to gain some speed
		Pen.color= Color.white;
		//Pen.stringAtPoint("func{sig.fold()2*9e3}"/*+"fps:"+u.frameRate.asInteger*/, Point(200, 200));
		//--
		~bufferForPen.getn(0, ~bufferForPen.numFrames-1, {|data| arr= data});
		if(cnt==0, {
			Pen.fillColor= Color.black;	//erase first time
			Pen.fillRect(Rect(0, 0, width, height));
		});

		Pen.fillColor= Color.red(0, ~trails);
		Pen.fillRect(u.bounds);			//manually clear
		Pen.strokeColor= Color.new(~red, ~green, ~blue, ~alpha);

		switch(~version,
			0, {			//redone
				var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;
				var times= 6;
				Pen.fillColor= Color.white;
				rule= (~trails/~amp*256).asInt;
				krt = krt+~flip/~amp*0.3;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				/* -> render */
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {
							Pen.addRect(
								Rect(
									(~amp*x*cellWidth)+x*(cellWidth*1.1)*~amp*~flip/~trails.linlin(0,200,1,8),
									(~amp*x*cellWidth)+yrt*(cellHeight*5)*~amp*~flip,
									cellWidth/~amp*2,
									cellHeight/~flip*2));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);
					}++[0];
					yrt= yrt+krt;
				});
				//provoke
				/*Pen.rotate(theta*~amp, w2, h2);
				Pen.translate(0, 20);
				arr.do{|y, x|
					var p= Point(x, y*(height*~amp));
					if(x==0, {Pen.moveTo(p)}, {Pen.lineTo(p/yrt)});
				};*/
				Pen.stroke;
			},
			1, {									//praw it rev
								var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;
				var times= 6;
				Pen.fillColor= Color.white;
				rule= (0..256).choose;
				krt = krt+~flip/~amp*0.3;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				/* -> render */
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {
							Pen.addRect(
								Rect(
									(~amp*x*cellWidth)+x*(cellWidth*1.18)*~amp*~flip/~trails.linlin(0,200,1,8),
									(~amp*x*cellWidth)+yrt*(cellHeight*3)*~amp*~flip,
									cellWidth/~amp*2.5,
									cellHeight/~flip*1.5));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);
					}++[0];
					yrt= yrt+krt;
				});

				Pen.rotate(90*~amp, cellWidth/~amp, cellHeight/~flip);
				/*Pen.translate(w2, h2);
				arr.do{|y, x|

					var p= Point(x*~amp, y*~amp).rotate(y*8pi);
					if(x==0, {Pen.moveTo(p*~amp)}, {Pen.lineTo(p*~flip+yrt)});
				};*/
				Pen.stroke;
				//Pen.fill;
			},
			2, {									//flower
				Pen.translate(w2, h2);
				Pen.moveTo(Point(arr[0], 0)*arr[0]);
				arr.do{|y, x|

					var p= Point(y, x)*y;
					var a= x%width/width*2pi+theta;
					Pen.lineTo(p.rotate(a));
				};
				Pen.stroke;
			},
			3, {									//experimental
				Pen.rotate(theta, w2, h2);
				Pen.translate(w2, h2);
				arr.do{|y, x|
					var p= Point(x*~amp, y*~amp).rotate(y*2pi);
					var a= x%width/width*1pi;
					var i= ~speed*~amp;
					var u= 0.1;
					if(x==0,
						{
							Pen.rotate(i, u, 0);

							Pen.moveTo(p)
						},
						{
							Pen.translate(i,0);
							//Pen.rotate(0, 0, 130*~speed);
							Pen.lineTo(p.rotate(a))
						}
					);
				};
				Pen.stroke;
			},
			4, {									//new search
				Pen.rotate(theta, w2, h2);
				Pen.translate(w2, h2);
				arr.do{|y, x|
					var p= Point(x*~amp, y*~amp).rotate(y*12pi);
					var a= x%width/width*1pi;
					var i= ~speed*~amp/2;
					var u= 0.1;
					if(x==0,
						{
							//Pen.rotate(i, u, 0);

							Pen.moveTo(p)
						},
						{
							Pen.translate(i.linlin(0.0,1.0,0.0,0.001)/*range(0,0.001)--fail på linux*/,0);
							//Pen.rotate(0, 0, 130*~speed);
							Pen.lineTo(p.rotate(a))
						}
					);
				};
				Pen.stroke;
			},
			5, {
				var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;//(~speed*8).asInt;
				var times= 6;
				Pen.fillColor= Color.red;
				//rule= 256.rand.postln;
				rule= (~trails/~amp*256).asInt;
				krt = krt+~flip/~amp*0.6;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				//--render
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {
							Pen.addRect(Rect(x*cellWidth, yrt*cellHeight, cellWidth/~amp, cellHeight/~flip));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);/*Pen.rotate(theta*~amp, w2, h2);
				Pen.translate(0, 20);
				arr.do{|y, x|
					var p= Point(x, y*(height*~amp));
					if(x==0, {Pen.moveTo(p)}, {Pen.lineTo(p/yrt)});
				};*/
					}++[0];
					yrt= yrt+krt;
				});
				Pen.fill;
				//Pen.stroke;
			},
			6, {
				var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;//(~speed*8).asInt;
				var times= 6;
				Pen.fillColor= Color.white;
				//rule= 256.rand.postln;
				rule= (~trails/~amp*256).asInt;
				krt = krt+~flip/~amp*0.6;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				//--render
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {
							Pen.addRect(
								Rect(
									(~amp*x*cellWidth)+x*cellWidth*~amp*~flip*5,
									(~amp*x*cellWidth)+yrt*cellHeight*~amp,
									cellWidth/~amp,
									cellHeight/~flip));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);
					}++[0];
					yrt= yrt+krt;
				});
				Pen.fill;
				//Pen.stroke;
			},
			7, {
				var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;//(~speed*8).asInt;
				var times= 6;
				Pen.fillColor= Color.white;
				//rule= 256.rand.postln;
				rule= (~trails/~amp*256).asInt;
				krt = krt+~flip/~amp*0.6;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				//--render
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {/*Pen.rotate(theta*~amp, w2, h2);
				Pen.translate(0, 20);
				arr.do{|y, x|
					var p= Point(x, y*(height*~amp));
					if(x==0, {Pen.moveTo(p)}, {Pen.lineTo(p/yrt)});
				};*/
							Pen.addRect(
								Rect(
									(~amp*x*cellWidth)+x*cellWidth*~amp*~flip*5,
									(~amp*x*cellWidth)+yrt*cellHeight*~amp,
									cellWidth/~amp,
									cellHeight/~flip));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);
					}++[0];
					yrt= yrt+krt;
				});
				Pen.fill;
				//Pen.stroke;
			},
			8, {

				/*
				   first "even" spread version attempt.
				*/

				var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;//(~speed*8).asInt;
				var times= 6;
				Pen.fillColor= Color.white;
				//rule= 256.rand.postln;
				rule= (~trails/~amp*256).asInt;
				krt = krt+~flip/~amp*0.6;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				/* -> render */
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {
							Pen.addRect(
								Rect(
									(~amp*x*cellWidth)+x*(cellWidth*1.1)*~amp*~flip/~trails.linlin(0,200,1,8),
									/*wierd fail på linux hvis jeg bruger .range(1,8)*/
									(~amp*x*cellWidth)+yrt*(cellHeight*5)*~amp,
									cellWidth/~amp,
									cellHeight/~flip));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);
					}++[0];
					yrt= yrt+krt;
				});
				Pen.fill;
				//Pen.stroke;
			},
			9, {

				/*
				   first further attempt.
				*/

				var pat, dict, rule, ruleRand, krt= 1, yrt= 7;
				var windowLength = 3;//(~speed*8).asInt;
				var times= 6;
				Pen.fillColor= Color(0.5,0.5,~blue,1);
				//rule= 256.rand.postln;/*Pen.rotate(theta*~amp, w2, h2);
				rule= (~trails/~amp*256).asInt;
				krt = krt+~flip/~amp*0.6;
				pat= 0.dup((width/cellWidth).round);
				pat.put((pat.size/2).round, 1);
				dict= ();
				times.do{|i| dict.put(i.asBinaryDigits(windowLength).join.asSymbol, rule.asBinaryDigits[(times-1)-i])};

				/* -> render */
				while({yrt*cellHeight<height}, {
					pat.do{|c, x|
						if(c==1, {
							Pen.addRect(
								Rect(
									(~amp*x*cellWidth)+x*(cellWidth*1.1)*~amp*~flip/~trails.linlin(0,200,1,8),
									(~amp*x*cellWidth)+yrt*(cellHeight*5)*~amp,
									cellWidth/~amp,
									Pen.translate(w2, h2);
				arr.do{|y, x|

					var p= Point(x*~amp, y*~amp).rotate(y*8pi);
					if(x==0, {Pen.moveTo(p*~amp)}, {Pen.lineTo(p*~flip+yrt)});
				};cellHeight/~flip));
						});
					};
					pat= [0]++pat.slide(windowLength, 1).clump(windowLength).collect{|c|
						dict.at(c.join.asSymbol);
					}++[0];
					yrt= yrt+krt;
				});
				Pen.fill;
				//Pen.stroke;
			}

		);
		theta= theta/**~speed*/;
		cnt= cnt+1;

	};

	//--window management
	u.clearOnRefresh= false;
	w.onClose= {
		~bufferForPen.free;
	};

	w.front;
	CmdPeriod.doOnce({if(w.isClosed.not, {w.close})});
	u.frameRate_(fps);
	u.animate= true;
}.fork(AppClock, 0.0);

OSCdef(\amp, {arg msg, time;
	var val = msg[1];
	~amp = val;
}.inEnvir, '/painter/amp');

OSCdef(\speed, {arg msg, time;
	var val = msg[1];
	~speed = val;
}.inEnvir, '/painter/speed');

OSCdef(\trails, {arg msg, time;
	var val = msg[1];
	~trails = val.linlin(0.00001, 1.0, 0.00001, 0.2);
}.inEnvir, '/painter/trails');

OSCdef(\flip, {arg msg, time;
	var val = msg[1];
	~flip = val.clip(0.01,1e3);
}.inEnvir, '/painter/flip');

OSCdef(\version, {arg msg, time;
	var val = msg[1];
	~version = val;
}.inEnvir, '/painter/version');

OSCdef(\red, {arg msg, time;
	var val = msg[1];
	~red = val;
}.inEnvir, '/rgba/red');

OSCdef(\green, {arg msg, time;
	var val = msg[1];
	~green = val;
}.inEnvir, '/rgba/green');

OSCdef(\blue, {arg msg, time;
	var val = msg[1];
	~blue = val;
}.inEnvir, '/rgba/blue');

OSCdef(\alpha, {arg msg, time;
	var val = msg[1];
	~alpha = val;
}.inEnvir, '/rgba/alpha');
)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


(
OSCdef(\ctrlAmp, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/painter/amp', val);
}, '/tr', argTemplate: [nil, 0]);

OSCdef(\ctrlSpeed, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/painter/speed', val);
}, '/tr', argTemplate: [nil, 1]);

OSCdef(\ctrlFlip, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/painter/flip', val);
}, '/tr', argTemplate: [nil, 2]);

OSCdef(\ctrlTrails, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/painter/trails', val);
}, '/tr', argTemplate: [nil, 3]);

OSCdef(\ctrlRed, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/rgba/red', val);
}, '/tr', argTemplate: [nil, 4]);

OSCdef(\ctrlGreen, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/rgba/green', val);
}, '/tr', argTemplate: [nil, 5]);

OSCdef(\ctrlBlue, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/rgba/blue', val);
}, '/tr', argTemplate: [nil, 6]);

OSCdef(\ctrlAlpha, {arg msg, time, addr, port;
	var val = msg[3];
	//msg.postln;
	NetAddr("127.0.0.1", 57120).sendMsg('/rgba/alpha', val);
}, '/tr', argTemplate: [nil, 7]);


y = List[
	{/*Silence.ar*/},
	{x=LPF18.ar(DPW4Saw.ar(LFNoise0.ar(3.1*Ndef(\x).ar)),10%Ndef(\x).ar,1.29);Limiter.ar(SinOsc.ar([x%2e2,x%3e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(5e3*Ndef(\x).ar.abs)),5e-2*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%40,x%70*Ndef(\x).ar]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.07*Ndef(\x).ar)),0.001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x+1e2,x+1e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(LFNoise0.ar(3.1*Ndef(\x).ar)),20%Ndef(\x).ar,1.49);Limiter.ar(SinOsc.ar([x%5e2,x%6e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.001*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%5e3,x%5e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.01*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x%5e3,x%5e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(1.01*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x%2e3,x%1e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(LFNoise0.ar(1.1*Ndef(\x).ar)),20%Ndef(\x).ar,0.99);Limiter.ar(SinOsc.ar([x%5e3,x%6e3]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(17.2*Ndef(\x).ar)),1*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%1e2,x%2e2]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(2*Ndef(\x).ar.abs)),1*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%1e2,x%2e2]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(1e4*Ndef(\x).ar.abs)),5e-5*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%20,x%30]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(4e3*Ndef(\x).ar.abs)),5e-2*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%40,x%50*Ndef(\x).ar]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.001*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%5e3,x%5e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.01*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x%5e3,x%5e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.2*Ndef(\x).ar)),0.2*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x%2e2,x%3e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),0.8*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x%5e2,x%4e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.0000001*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x+1e2,x+1e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.0007*Ndef(\x).ar)),0.1*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x+1e2,x+1e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.0007*Ndef(\x).ar)),0.0001*Ndef(5).ar,0.9);Limiter.ar(SinOsc.ar([x+88,x+99]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.07*Ndef(\x).ar)),0.0001*Ndef(\x).ar,0.3);Limiter.ar(SinOsc.ar([x+88,x+99]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.07*Ndef(\x).ar)),0.0001*Ndef(\x).ar,0.3);Limiter.ar(SinOsc.ar([x+Ndef(\x).ar.range(99,1),x+Ndef(\x).ar.range(1,88)]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),0.0001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x+Ndef(\x).ar.range(99,1),x+Ndef(\x).ar.range(1,88)]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),Ndef(\x).ar.range(1,20),0.9);Limiter.ar(SinOsc.ar([x+Ndef(\x).ar.range(99,1),x+Ndef(\x).ar.range(1,88)]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),Ndef(\x).ar.range(4,1),0.999);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(99,1),x%Ndef(\x).ar.range(1,88)]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),Ndef(\x).ar.range(9,1),0.999);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(99,1),x%Ndef(\x).ar.range(1,88)]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(1.01*Ndef(\x).ar)),0.0000001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x%2e3,x%1e2]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(LFNoise0.ar(1.1*Ndef(\x).ar)),20%Ndef(\x).ar,0.99);Limiter.ar(SinOsc.ar([x%5e3,x%6e3]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(17.2*Ndef(\x).ar)),1*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%1e2,x%2e2]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(2*Ndef(\x).ar.abs)),1*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%1e2,x%2e2]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(1e4*Ndef(\x).ar.abs)),5e-5*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%20,x%30]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(4e3*Ndef(\x).ar.abs)),5e-2*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%40,x%50*Ndef(\x).ar]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),Ndef(\x).ar.range(9,1),0.999);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(999,1),x%Ndef(\x).ar.range(1,888)]/x),0.2).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),Ndef(\x).ar.range(9,1),0.2);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(1999,1),x%Ndef(\x).ar.range(1,1888)]/x),0.4).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.99*Ndef(\x).ar.range(-4,4))),Ndef(\x).ar.range(90,1),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(1999,-4),x%Ndef(\x).ar.range(-8,1888)]/x),0.4).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.01*Ndef(\x).ar.range(-4,4))),Ndef(\x).ar.range(90,1),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-8,188)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-4,4))),Ndef(\x).ar.range(90,1),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-8,188)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-4,4))),Ndef(\x).ar.range(20,1),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-80,398)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-9,9))),Ndef(\x).ar.range(200,10),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-80,398)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-90,90)%Ndef(\x).ar)),Ndef(\x).ar.range(200,10),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-100,198)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-90,90)%Ndef(\x).ar)),Ndef(\x).ar.range(200,10),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-900,198)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-90,90)%Ndef(\x).ar)),Ndef(\x).ar.range(2,10),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-8900,28)]/x),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(12%Ndef(\x).ar.range(-1290,290)*Ndef(\x).ar)),Ndef(\x).ar.range(0.1,102.4),0.2);Limiter.ar(SinOsc.ar([x*Ndef(\x).ar.range(17,-12),x%Ndef(\x).ar.range(-1290,1028)]),0.3).flatten},
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(12%Ndef(\x).ar.range(-1290,290)*Ndef(\x).ar)),Ndef(\x).ar.range(0.1,102.4),0.2);Limiter.ar(SinOsc.ar([x*Ndef(\x).ar.range(17,-12),x%Ndef(\x).ar.range(-8290,1028)]),0.3).flatten},
	{x=LPFVS6.ar(LFSaw.ar(DPW4Saw.ar(Ndef(\x).ar*Saw.ar(Ndef(\x).ar))),Ndef(\x).ar.range(0.001,10),Ndef(\x).ar.abs*0.1);Limiter.ar(Resonz.ar(LFSaw.ar([x-Ndef(\x).ar.range(4000,x.abs),x-Ndef(\x).ar.range(4001,x.abs)]),x.range(x*200,Ndef(\x).ar.abs)+Ndef(\x).ar,1),0.3).flatten},
	{x=LPFVS6.ar(SinGrain.ar(Impulse.ar(10),0.1,DPW4Saw.ar(SinGrain.ar(Impulse.ar(30), 0.1, Ndef(\x).ar.abs*50))),Ndef(\x).ar.range(2000,30),Ndef(\x).ar.abs);Limiter.ar(DPW4Saw.ar([x%Ndef(\x).ar.range(700,x.abs),x%Ndef(\x).ar.range(701,x.abs)]),0.3).flatten},
	{x=LPFVS6.ar(SinGrain.ar(Impulse.ar(10),0.1,DPW4Saw.ar(SinGrain.ar(Impulse.ar(30), 0.1, Ndef(\x).ar.abs*50))),Ndef(\x).ar.range(2000,30),Ndef(\x).ar.abs);Limiter.ar(DPW4Saw.ar([x%Ndef(\x).ar.range(400,x.abs),x%Ndef(\x).ar.range(701,x.abs)]),0.3).flatten},
	{x=LPFVS6.ar(SinGrain.ar(Impulse.ar(10),0.1,DPW4Saw.ar(SinGrain.ar(Impulse.ar(30), 0.1, Ndef(\x).ar.abs*50))),Ndef(\x).ar.range(2000,30),Ndef(\x).ar.abs);Limiter.ar(DPW4Saw.ar([x%Ndef(\x).ar.range(200,x.abs),x%Ndef(\x).ar.range(701,x.abs)]),0.3).flatten},
	{SinOsc.ar([420,430],0,0.8)},
	{/*~ge=LocalBuf(8192,2);*/~de=Dust.kr(0.2)+Dust2.kr([2,1]);~re=PlayBuf.ar(2,~ge,TExpRand.kr(0.01,19,~de),~de,0,1)/4;FFT(~ge,~de+(~de*~re));~re.clip2(1).flatten},
	{t=(1..5);f=t*9999*Pulse.ar(1);d=SinOsc.ar(1).range(0,3);e=t/10;k=SinGrain.ar(Dust.ar(e),d,f).sum;Squiz.ar(k!2,4,1,10)},
	{t=(1..5);f=t*299*Pulse.ar(1);d=SinOsc.ar(1).range(0,3);e=t/10;k=SinGrain.ar(Dust.ar(e),d,f).sum;Squiz.ar(k!2,4,1,10)}
];








fork{
	Ndef(\x,
		\setsrc -> Pbind(
			\poem, Pseq([Pxrand((1..y.size-1), 2), 0], inf),
			//\poem, Pseq([Pxrand((1..y.size-1), 2), 49], inf),
			//\poem, Pseq([50,49], inf), // nice syntetisk chill

			//\poem, Pxrand([49,50,49,51,49,49], inf),
			//\poem, Pxrand([0,20], inf),

			// den sidste brugte i stability log --> \poem, Pseq([49,34,41,49,50,23,0,45,21,49,23,46,0], inf),

			/*Pfunc({|envir|
			var chosen, flag = false, count = 0;
			//flag.postln;
			if(flag==false){
			flag=true;
			chosen = (1..y.size-1).choose;
			};

			//chosen.postln;

			/*
			if(count>=7){
			chosen;
			count+1;
			}{
			count = 0;
			flag=false;
			};*/
			//chosen;
			}),*/
			\source,
			Pfunc({|envir|
				if(envir.poem > 0){
					y.at(envir.poem).postcs;
					/*~flag;
					if(~flag == 1){
						//~bufferForPen= BuffSendTrig.kr(Impulse.kr(24), 4, freq.at(0).linlin(20,1000,0.01,1.0); ); //reder.alloc(s, l, 2);
						//s.sync; // okay to do sync while prog is running - maybe?
						"/tfalse flag".postln;
						~flag = 0;
					};*/

					/*if(envir.poem == 49){
						//~ge.clear;
						//~ge.free;
						//s.sync; // needed?
						//"g was cleared".postln;
						y.at(envir.poem).postcs
					}{
						y.at(envir.poem).postcs
					}*/
					//"\t\tkån".postln;

				}{
					//"\t\tsil".postln;
					y.at(0).postcs;
					//~bufferForPen.clear;
					//"cleared Pen Buffer".postln;
					//"/ttrue flag".postln;
					//~flag = 1;
				}
			}),
			\dur,
			Pfunc({|envir|
				if(envir.poem > 0){
					(2..20.0).choose;
				}{
					2;
					//(20..360.0).choose;
				}
			})
		).flatten
		.trace(\poem, prefix: "xpoem: ")
		.trace(\dur, prefix: "xdur: ");
	).playN([2,3]);

	Pdef(\CtrlVersion,
		Pbind(
			\degree, Rest(), // stop sending midi to generic piano
			\version, Pbrown(0,1,1,inf),
			\versionSend, Pfunc({|envir|
				~version = envir.version;
			}),
			//\dur, Pbrown(0.1,2),
			\dur, Pbrown(2,10)
		).trace
	).play(quant:0);

	1.0.wait; // correct order ensured

	Ndef(\protect, {var in, freq, hasFreq, lim, followAmp, followCrest, followZero, follow, sum;
		in = In.ar(2,2);
		in = BHiShelf.ar(in, 1200, db: -10);
		lim = Limiter.ar(in);
		sum = LeakDC.ar(lim*0.7);

		followAmp = Amplitude.kr(sum);
		followCrest = Crest.kr(sum);
		followZero = ZeroCrossing.ar(sum);
		# freq, hasFreq = Tartini.kr(sum, 0.93,1024,512,512);

		SendTrig.kr(Impulse.kr(5), 0, followAmp; );
		SendTrig.kr(Impulse.kr(5), 1, followCrest; );
		SendTrig.kr(Impulse.kr(5), 2, followZero*0.0005; );
		SendTrig.kr(Impulse.kr(5), 3, freq.at(0).linlin(20,1000,0.01,1.0); );

		// four sendtrigs on 24 Hz is okay. more sendtrigs seems to overflood if not set to 10 Hz.
		//SendTrig.kr(Impulse.kr(10), 4, freq.at(0).linlin(20,1000,0.01,1.0); ); //r
		//SendTrig.kr(Impulse.kr(10), 5, freq.at(0).linlin(20,1000,0.5,1.0); ); //g
		//SendTrig.kr(Impulse.kr(10), 6, freq.at(0).linlin(20,1000,0.5,1.0); ); //b
		//SendTrig.kr(Impulse.kr(10), 7, freq.at(0).linlin(20,1000,0.01,1.0); ); //a

		RecordBuf.ar(HPF.ar((sum*3), 40), ~bufferForPen);

		sum;

	}).play;



})


































Ndef(\,{b=LocalBuf(8192,4);d=Dust.kr(0.2)+Dust2.kr([2,1]);r=PlayBuf.ar(2,b,TExpRand.kr(0.01,19,d),d,0,1)/4;FFT(b,d+(d*r));r.clip2(1)}).playN([0,1]);



Ndef(\,{b=LocalBuf(512*24,4);d=Impulse.kr(SinOsc.kr(0.1).unipolar.range(0.1,8));r=PlayBuf.ar(2,b,TChoose.kr(d, [0,3]),d,0,1);FFT(b,d-(d%r));r.clip2(0.1)}).playN([0,1]); // raster

(
Ndef(\,{b=LocalBuf(512*24,4);d=Impulse.kr(1);r=PlayBuf.ar(
	2,
	b,
	TChoose.kr(d,
		[TChoose.kr(d,[4,3,1]),6, [0.2]]
),d,0,1);FFT(b,d+(d*r));r.clip2(0.1)}).playN([0,1]); // raster
)

(
Ndef(\,{b=LocalBuf(512*40,4);d=Impulse.kr(LFNoise0.kr(1).range(0.1,4).poll);r=PlayBuf.ar(
	2,
	b,
	TChoose.kr(d,
		[TChoose.kr(d,[4,3,1]),6, [0.2]]
),d,0,1);FFT(b,d);r.clip2(0.4)}).playN([0,1]); // raster
)


(
Ndef(\er,{b=LocalBuf(2**1000,4);
	d=Impulse.kr(LFNoise0.kr(1).range(0.1,4).poll);
	r=PlayBuf.ar(
		2,
		b,
		TChoose.kr(d,
			[TChoose.kr(d,[0.1,3,1]),6, [0.2]]),
		d,
		0,
		1
	);
	FFT(b,d);
	r.clip2(0.4)
}).playN([0,1]); // raster
)




( // flot symetrisk scope stil
Ndef(\er,{b=LocalBuf(2**14,2);
	f=LFNoise0.kr(0.2).range(1,50).poll;
	d=SinOsc.ar(f)*LFNoise0.kr(2);
	r=PlayBuf.ar(
		2,
		b,
		SinOsc.kr(d),
		Dust.kr(0.3)+Dust2.kr(0.2),
		0,
		1
	);
	FFT(b,d);
	//r=Normalizer.ar(r,0.7);
	LeakDC.ar(r.clip2(0.6));
}).playN([0,1]); // raster
)








( // further further
Ndef(\er,{b=LocalBuf(2**14,2);
	f=LFNoise0.kr(3.2).range(40,50).poll;
	d=SinOsc.ar(f)*LFNoise0.kr(2)*SinOsc.ar(10)*Saw.ar(2);
	r=PlayBuf.ar(
		2,
		b,
		Saw.kr(d),
		Dust.kr(0.2)+Dust2.kr(0.1),
		0,
		1
	);
	FFT(b,d+f);
	//r=Normalizer.ar(r,0.7);
	r=CompanderD.ar(r, 0.2, 0.1);
	LeakDC.ar(r.clip2(0.4));
}).playN([0,1]); // raster
)



( // further further baby mango
Ndef(\er,{b=LocalBuf(2**14,2);
	f=LFNoise0.kr(3.2).range(40,50).poll;
	d=SinOsc.ar(f)*LFNoise0.kr(2)*SinOsc.ar(10)*Saw.ar(2);
	r=PlayBuf.ar(
		2,
		b,
		Saw.kr(d),
		Dust.kr(8.2)+Dust2.kr(0.1),
		0,
		1
	);
	FFT(b,d+f);
	//r=Normalizer.ar(r,0.7);
	r=CompanderD.ar(r, 0.2, 0.1);
	LeakDC.ar(r.clip2(0.4));
}).playN([0,1]); // raster
)



( // moremore
Ndef(\er,{b=LocalBuf(2**22,2);
	f=LFNoise0.kr(20.2).range(4,500).poll;
	d=SinOsc.ar(f)*LFNoise0.kr(2)*SinOsc.ar(10)*Saw.ar(2);
	r=PlayBufCF.ar(
		2,
		b,
		SawDPW.kr(d)%f,
		Impulse.kr(1000),
		0,
		1
	);
	FFT(b,d+f);
	//r=Normalizer.ar(r,0.7);
	r=CompanderD.ar(r, 0.2, 0.1);
	LeakDC.ar(r.clip2(0.4));
}).playN([0,1]); // raster
)






// se igennem


// more for ALMAT
/*wiind !!*/ play{Splay.ar({|i|f=1.9**i/128;BPF.ar(PinkNoise.ar(1!2),4**LFNoise2.kr(1.2**i/16)*300,0.15)*(5**LFNoise2.ar(f)/(i+8)*20)}!15)}
/*chello stil*/Ndef(\,{x=DelayN.ar(LeakDC.ar(Ndef(\).ar),1,z=1e-2);LPF.ar(Trig1.ar(Amplitude.kr(x,5,120)*1.5+x+z-Dust.ar(2),4e-3)*0.1+x*0.99,1200)}).play
Ndef(\y, { a = {{ Drand([Dshuf({0.0001.rand}!rrand(2,11),SinOsc.kr(0.1)*40), 0.05], inf) }}; TDuty.ar(a!2!8,0,0.1).sum }).play;
Ndef(\,{LPF.ar(x=DelayN.ar(LeakDC.ar(Ndef(\).ar,1-2e-6)*0.99,1,0.01)+Dust.ar(30.5!2);x+(Trig1.ar(x<(x.mean.lag(30)),4e-3)*0.05),9000)}).play


Ndef(\,{x=DelayL.ar(n=Ndef(\);n.ar,2,LFNoise0.kr(0.03*_!20)+1)+Blip.ar(0.5);LeakDC.ar(LPF.ar(x+x.mean*0.15,4e3)).sin});play{Splay.ar(n.ar)}




p=Impulse;play{mean({|i|Pluck.ar(LFSaw.ar([102,101]),x=p.ar(1,i/10)+p.ar(0),1,1/Latch.ar(1.015**Sweep.ar(0,1)*64%1+1*200,x),4,0.2)}!10)}
play{x=Saw.ar([50,50.1]);8.do{|i|f=2**(8-i);x=BRF.ar(AllpassN.ar(x,1,0.1/(12-i),2),80**TRand.ar(0,1,Impulse.ar(f/32,1/2)).lag(1/f)*80,2)};x}

play{b=LocalBuf(2*SampleRate.ir,2);BufCombL.ar(b,LeakDC.ar(RLPF.ar(Limiter.ar(PlayBuf.ar(2,b,0.4,0,0,1),0.5)+Dust.ar(0.1),5e3,0.03)),1,10)}
play{b=LocalBuf(4e5,2).clear;BufCombL.ar(b,LeakDC.ar(LPF.ar(PlayBuf.ar(2,b,16/15,0,0,1),300))+Blip.ar([20,21],1),2,40)/20}//
#supercollider
play{b=LocalBuf(4e5,2).clear;BufCombL.ar(b,LeakDC.ar(BufRd.ar(2,b,LFNoise1.ar(0.25)+1*2e5)*0.98)+Blip.ar(2!2,10),2,20)/10}//
#supercollider
play{b=LocalBuf(1e5,2).clear;x=BufRd.ar(2,b,Phasor.ar(0,1,0,1e5))*0.6;BufWr.ar(Blip.ar([1,1.01],10)/5+x,b,LFNoise1.ar(0.2)+1*5e4);x}//
#sc
Ndef(\,{x=DelayN.ar(LeakDC.ar(Ndef(\).ar),1,z=1e-2);LPF.ar(Trig1.ar(Amplitude.kr(x,5,120)*1.5+x+z-Dust.ar(2),4e-3)*0.1+x*0.99,1200)}).play
f=g=0;Routine({loop{g=g+1e-3;f=f+g%1;play{l=Line.kr(1,0,3,doneAction:2);h=2**f*100;e=Pluck.ar(CuspL.ar,1,i=1/h,i,2,0.3)!2};0.15.wait}}).play
Ndef('x',{x=Ndef('x').ar+0.01;a=BPF.ar(x,6**Latch.ar(x,Dust.ar(x))*200,0.1).sin;9.do{a=AllpassN.ar(a,0.2,{0.2.rand}!2,9)};a+a.mean}).play;
Ndef('x',{x=(Ndef('x').ar*1.8).tanh;BPF.ar(x+[0.01,0.1],12**Latch.ar(x.mean,Impulse.ar(3)).lag(0.1)*200)}).play//#supercollider
b=Buffer.read(s,"sounds/a11wlk01.wav");play{t=Impulse.kr(5);PlayBuf.ar(1,b,1,t,Demand.kr(t,0,Dseq(1e3*[103,41,162,15,141,52,124,190],4)))!2}
Ndef(\x,{DelayN.ar(BRF.ar(Saw.ar(20!2)*0.01+Rotate2.ar(*(Ndef(\x).ar*2).tanh++0.1),20**LFNoise1.kr(0.6)*500,1),1,1)}).play//
#supercollider
Ndef('x',{Normalizer.ar(FreqShift.ar(Rotate2.ar(*Ndef('x').ar++1/8).tanh,20*[-3,0.995])+Dust.ar(1!2,0.005),1,0.5)}).play//
#supercollider
play{p=PinkNoise.ar(1!2);BRF.ar(p+Blip.ar(p+2,400),150,2,0.1)+LPF.ar(FreeVerb2.ar(*LPF.ar(p+0.2*Dust.ar(0.1),60)++[1,1,0.2,1e4]).tanh,2000)}
x=0;Pbind(*[type:\set,id:{|freq=10|f=freq;LPF.ar(Saw.ar(f),f.lag(1)*3)!2}.play.nodeID,freq:Pfunc{x=x+32%35;x%12+1*40},dur:1/6]).play
x=0;Pbind(*[type:\set,id:{|freq=10|LFTri.ar(freq.lag(0.1))!2}.play.nodeID,freq:Pfunc{x=x+32%355;x%12+1*40},dur:1/6]).play//
#supercollider
n={|r,f,n=0,d=1|round(r**LFNoise0.ar([4,1,8,2]!d)*f,n)};play{Splay.ar(d=n.(3,0.6);Ringz.ar(d*0.01,n.(2,n.(20,400),40,20),d).mean.tanh)}
n={|r,f,d=1|2**LFNoise0.kr(1!d,r)*f};{p=n.(4,1e3);CombN.ar(Ringz.ar(LFPulse.ar(1,0,0.01),n.(2,p,80),0.6).sum,8/5,8/5,60)*4e-4!2}.play
x=LFPulse;d={|l,h,f,p,n|sum({Ringz.ar(x.ar(f,p,0.01),exprand(l,h).round(n),0.6)}!40)};{d.(30,150,2,[0,0.3],[1,x.kr(1/8)*10+40])*3e-4!2}.play
d={|l,h,f,p,n|sum({Ringz.ar(LFPulse.ar(f,p,0.01),exprand(l,h).round(n),0.5)}!20)};{d.(50,150,[2,1,1],[0,1/4,3/4],[1,40,50])*3e-4!2}.play
d={|l,h,f,p|({Ringz.ar(LFPulse.ar(f,p,0.01),exprand(l,h),0.5)}!20).sum};{d.(50,100,2,[0,1/4])+d.(3e3,1e4,4,0)+d.(2e2,3e3,1,0.5)*3e-4!2}.play
{LocalOut.ar(a=CombN.ar(BPF.ar(LocalIn.ar(2)*7.5+Saw.ar([32,33],0.2),2**LFNoise0.kr(4/3,4)*300,0.1).distort,2,2,40));a}.play//#supercollider
f=0;Routine({inf.do{|i|f=i/12+f%[4,3];{Formant.ar(2**f*100,2**(i%8*f*0.2)*100,100)*Line.kr(0.1,0,1)}.play;0.25.wait;}}).play//#supercollider
p={|f,a=1|LFPulse.ar(f)*a*[1,1.01]};{p.(p.(100-p.(1/16,20))+p.(2,1+p.(1/4))-0.5*200)+p.(100-p.(1/8,20),p.(8))*0.1}.play//
#supercollider
{a=LFTri.ar(1);20.do{a=BAllPass.ar(a,80,1);a=((a+0.02)*LFNoise0.kr(1/2)*8).tanh;a=LeakDC.ar(a,0.995)};a*0.1!2}.play//
#supercollider
{a=PinkNoise.ar(1!2);50.do{a=BBandStop.ar(a,LFNoise1.kr(0.05.rand).exprange(40,15000),exprand(0.1,2))};LPF.ar(a,1e5)}.play//
#supercollider







