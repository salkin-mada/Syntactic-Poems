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



}