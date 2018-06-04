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