fork{
	Ndef(\x,
		\setsrc -> Pbind(
			\poem, Pseq(
				[
					1,
					1,
					28,
					Pxrand((2..y.size-1), 3),
					1,
					1,
					0,
					28,
					Pxrand((2..y.size-1), 2),
					29,
					1,
					0,
					1,
					30,
					Pxrand((2..y.size-1), 2),
				],
				inf
			),
			\source,
			Pfunc({|envir|
				if(envir.poem > 0){
					y.at(envir.poem).postcs;
				}{
					"\n\t\INSIST NEGATIVE\n".postln;
					y.at(0).postcs;
				}
			}),
			\dur,
			Pfunc({|envir|
			case
			{envir.poem > 1} {(10..40.0).choose}
			{envir.poem == 1} {(60..120).choose}
			{envir.poem == 0} {(20..40.0).choose;}
			})
		).flatten
		.trace(\poem, prefix: "xpoem: ")
		.trace(\dur, prefix: "xdur: ");
	).playN([2,3]);

	Pdef(\CtrlVersion,
		Pbind(
			\degree, Rest(), // stop sending midi to generic piano
			\version, Pseq(
				[
					Prand((0..2), 60),
					Prand((3..10), 5)
				],
				inf
			),
			\versionSend, Pfunc({|envir|
				~version = envir.version;
			}),
			\dur, Pbrown(0.1,2)
		)/*.trace*/
	).play(quant:0);

	0.5.wait; // correct order ensured

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