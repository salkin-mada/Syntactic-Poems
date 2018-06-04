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

/*OSCdef(\ctrlRed, {arg msg, time, addr, port;
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
}, '/tr', argTemplate: [nil, 7]);*/