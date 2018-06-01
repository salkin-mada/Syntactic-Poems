/*
sudo nano /etc/lightdm/lightdm.conf
in -> [Seat:*]
# dont sleep the screen
xserver-command=X -s 0 dpms

nano ~/.config/lxsession/LXDE-pi/autostart
# idle mouse curser when inactive
@uncluter -display :0 -noevents -grab
*/

/*
cleaned up in LXDE-pi/xsessions.conf
~.config/lxsessions/LXDE-pi/autostart
*/



/*( // use this for raspi
s.options.memSize_(8192*10);
s.boot;
/*s.doWhenBooted{
	("\n*** memSize; "++s.options.memSize).post;
	s.recChannels_(2);
	("\n~~~~~~~~~~~~~~~~~~~~~~~" ++ "\n*** Overwriting recChannels to: " ++ s.recChannels ++ "\n").post;
}*/
)*/



(
s.options.memSize_(8192*30);
s.latency= 0.05;
s.boot;
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
			//\poem, Pseq([Pxrand((1..y.size-1), 2), 0], inf),
			//\poem, Pseq([Pxrand((1..y.size-1), 2), 49], inf),
			//\poem, Pseq([50,49], inf), // nice syntetisk chill

			\poem, Pxrand([49,50,49,51,49,49], inf),

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
					(2..5.0).choose;
				}
			})
		).flatten
		.trace(\poem, prefix: "xpoem: ")
		.trace(\dur, prefix: "xdur: ");
	).playN([2,3]);

	Pdef(\CtrlVersion,
		Pbind(
			\degree, Rest(), // stop sending midi to generic piano
			\version, 1,//Pbrown(0,1,1,inf),
			\versionSend, Pfunc({|envir|
				~version = envir.version;
			}),
			\dur, Pbrown(0.1,2)
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




