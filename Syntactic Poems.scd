u=List[1,2,3]
u.size


(
y = List[
	{},
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
	{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.0007*Ndef(\x).ar)),0.001*Ndef(\x).ar,0.9);Limiter.ar(SinOsc.ar([x+1e2,x+1e2]/x),0.2).flatten},
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
	{SinOsc.ar([220,230], 0, 0.4)},
	{Saw.ar([220,230], 0, 0.3)},
	{Pulse.ar([220,230], 0, 0.2)}
];
)

y.size;

(
fork{
	Ndef(\x,
		\setsrc -> Pbind(
			\poem, 45,//Pseq([Pxrand((1..y.size-1), 2), 0], inf),
			\source,
			Pfunc({|envir|
				if(envir.poem > 0){
					"\t\tkån".postln;
					y.at(envir.poem).postcs
				}{
					"\t\tsil".postln;
					y.at(0)
				}
			}),
			\dur,
			Prand( (10..30.0), inf)
		).flatten
		.trace(\poem, prefix: "poem: ")
		.trace(\dur, prefix: "dur: ");
	).playN([22,23]);

	/*Ndef(\u,
		\setsrc -> Pbind(
			\poem, Pseq([Pxrand((1..y.size-1), 2), 0], inf),
			\source,
			Pfunc({|envir|
				if(envir.poem > 0){
					"\t\tkån".postln;
					y.at(envir.poem).postcs
				}{
					"\t\tsil".postln;
					y.at(0)
				}
			}),
			\dur,
			Prand( (10..30.0), inf)
		).flatten
		.trace(\poem, prefix: "poem: ")
		.trace(\dur, prefix: "dur: ");
	).playN([22,23]);

	Ndef(\o,
		\setsrc -> Pbind(
			\poem, Pseq([Pxrand((1..y.size-1), 2), 0], inf),
			\source,
			Pfunc({|envir|
				if(envir.poem > 0){
					"\t\tkån".postln;
					y.at(envir.poem).postcs
				}{
					"\t\tsil".postln;
					y.at(0)
				}
			}),
			\dur,
			Prand( (10..30.0), inf)
		).flatten
		.trace(\poem, prefix: "poem: ")
		.trace(\dur, prefix: "dur: ");
	).playN([22,23]);*/

	1.0.wait; // correct order ensured.. hmm.

	Ndef(\protect, {var in, lim;
		in = In.ar(22,2);
		in = BHiShelf.ar(in, 1200, db: -10);
		lim = Limiter.ar(in);
		LeakDC.ar(lim)*0.6;
}).play
})










/*kån
{Pulse.ar([220,230], 0, 0.2)}
poem: 50
dur: 10
kån
{Saw.ar([220,230], 0, 0.3)}
poem: 49
dur: 3
Ndef('u'): adopted proxy input to audio rate
kån
{x=LPF18.ar(DPW4Saw.ar(Saw.ar(10.19*Ndef(\x).ar.range(-4,4))),Ndef(\x).ar.range(20,1),0.6);Limiter.ar(SinOsc.ar([x%Ndef(\x).ar.range(187,-8),x%Ndef(\x).ar.range(-80,398)]/x),0.3).flatten}
poem: 37
dur: 1
Ndef('o'): wrapped channels from 4 to 2 channels
kån
{x=LPF18.ar(DPW4Saw.ar(Saw.ar(0.7*Ndef(\x).ar)),Ndef(\x).ar.range(1,20),0.9);Limiter.ar(SinOsc.ar([x+Ndef(\x).ar.range(99,1),x+Ndef(\x).ar.range(1,88)]/x),0.2).flatten}
poem: 23
dur: 5
Ndef('o'): wrapped channels from 4 to 2 channels
kån
{x=LPF18.ar(DPW4Saw.ar(Saw.ar(2*Ndef(\x).ar.abs)),1*Ndef(\x).ar,0.2);Limiter.ar(SinOsc.ar([x%1e2,x%2e2]/x),0.3).flatten}
poem: 10
dur: 1
Ndef('u'): wrapped channels from 4 to 2 channels
kån
{x=LPF18.ar(DPW4Saw.ar(Saw.ar(4e3*Ndef(\x).ar.abs)),5e-2*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%40,x%50*Ndef(\x).ar]/x),0.3).flatten}
poem: 31
dur: 9
Ndef('u'): wrapped channels from 4 to 2 channels
kån
{Pulse.ar([220,230], 0, 0.2)}
poem: 50
dur: 1
kån
{x=LPF18.ar(DPW4Saw.ar(Saw.ar(1e4*Ndef(\x).ar.abs)),5e-5*Ndef(\x).ar,0.1);Limiter.ar(SinOsc.ar([x%20,x%30]/x),0.3).flatten}
poem: 11
dur: 1
Ndef('o'): wrapped channels from 4 to 2 channels
kån
{x=LPFVS6.ar(LFSaw.ar(DPW4Saw.ar(Ndef(\x).ar*Saw.ar(Ndef(\x).ar))),Ndef(\x).ar.range(0.001,10),Ndef(\x).ar.abs*0.1);Limiter.ar(Resonz.ar(LFSaw.ar([x-Ndef(\x).ar.range(4000,x.abs),x-Ndef(\x).ar.range(4001,x.abs)]),x.range(x*200,Ndef(\x).ar.abs)+Ndef(\x).ar,1),0.3).flatten}
poem: 44
dur: 9
Ndef('o'): wrapped channels from 4 to 2 channels*/


