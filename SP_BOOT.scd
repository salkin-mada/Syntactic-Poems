// boot RPI serv
s.options.memSize_(8192*30);
s.latency= 0.05;
s.options.numOutputBusChannels_(4);
s.boot;
s.doWhenBooted{
	("\n*** memSize; "++s.options.memSize).post;
	s.recChannels_(2);
	("\n~~~~~~~~~~~~~~~~~~~~~~~" ++ "\n*** Overwriting recChannels to: " ++ s.recChannels ++ "\n").post;
	NotificationCenter.notify(\boot, \done);
}
