(
[
	\foo,
	\lol,
	\cake,
	\fantasy,
	\green,
	\delta,
	\theta,
	\alpha,
	\beta,
	\gamma
].do({arg paramName;
	var path = "/poems/%".format(paramName).asSymbol;
	Ndef(path, 0.0).kr(1);
	OSCdef("poems_%Responder".format(paramName).asSymbol, {arg msg, time, addr, port;
		var val = msg[1];
		Ndef(path).bus.set(val);
	}, path);
});
)

OSCFunc.trace(true)
OSCFunc.trace(false)

(
Ndef(\tet, {
	var yrt, sig, nrt, sum;
	//var foo = Ndef.kr('/poems/foo').poll(label: \foooo);
	var delta = Ndef.kr('/poems/delta').poll(label: 'd', trig: 1);
	var theta = Ndef.kr('/poems/theta').poll(label: 't', trig: 1);
	var alpha = Ndef.kr('/poems/alpha').poll(label: 'a', trig: 1);
	var beta = Ndef.kr('/poems/beta').poll(label: 'b', trig: 1);
	var gamma = Ndef.kr('/poems/gamma').poll(label: 'g', trig: 1);
	var o1 = SawDPW.ar(delta.linlin(0.0,1.0,120,240).lag(5), mul: 0.1);
	var o2 = SawDPW.ar(theta.linlin(0.0,1.0,240,480).lag(5), mul: 0.1);
	var o3 = SawDPW.ar(alpha.linlin(0.0,1.0,480,960).lag(5), mul: 0.1);
	var o4 = SawDPW.ar(beta.linlin(0.0,1.0,960,1920).lag(5), mul: 0.1);
	var o5 = SawDPW.ar(gamma.linlin(0.0,1.0,1920,1920*2).lag(5), mul: 0.1);
	sig = (o1+o2+o3+o4+o5);

	sig = SawDPW.ar([o1,o2,o3,o4,o5].abs*sig.abs*2e8);

	f=[1e4,2e4,3e4,4e4,5e4]*Pulse.ar(alpha);
	l=SinOsc.ar(delta).range(0,theta.linlin(0.0,1.0,1.0,10.0));
	d=[0.5,0.1,0.2,0.3,0.4]*(delta/theta/alpha/beta/gamma);
	yrt=Splay.ar(SinGrain.ar(Dust.ar(d/40),l,f),
		LFNoise0.kr(beta).range(0,1).lag(0.4));
	nrt=Squiz.ar(yrt,4,gamma,10);

	sum=Splay.ar(sig*nrt,delta,1,alpha);
	sum=LeakDC.ar(sum)*0.000000001; // specific for SawDPW
	//sum=LeakDC.ar(sum);


	/*~ge=LocalBuf(8192,2);
	~de=Dust.kr(delta.linlin(0.0,1.0,0.4,9.0))+Dust2.kr([alpha.linlin(0.0,1.0,0.4,10.0),beta.linlin(0.0,1.0,0.4,9.0)]);
	~re=PlayBuf.ar(2,~ge,TExpRand.kr(0.01,gamma.linlin(0.0,1.0,0.2,20.0),~de),~de,0,1)/(4*theta.linlin(0.0,1.0,1.0,2.0));
	FFT(~ge,~de+(~de*~re));
	sum = ~re.clip2(1);
	sum * 0.00;*/
}).play
)





Ndef(\tet).mold(2)

Ndef(\tet).stop

