(
fork{
	var cond = Condition.new;
	"SP_BOOT.scd".loadRelative;
	NotificationCenter.register(\boot, \done, \yo, {
		cond.unhang;
	});
	cond.hang;
	NotificationCenter.unregister(\boot, \done, \yo);

	"SP_DRAW.scd".loadRelative;
	NotificationCenter.register(\draw, \done, \waitingForDraw, {
		cond.unhang;
	});
	cond.hang;
	NotificationCenter.unregister(\draw, \done, \waitingForDraw);
	"loaded_draw".postln;

	"SP_LIST.scd".loadRelative;
	"SP_OSC.scd".loadRelative;

	"\n\t\tall are go baby\n\n".postln;

	"SP_SND.scd".loadRelative;
}
)



Document.open("/home/pi/Documents/SuperCollider/Syntactic-Poems/SP_BOOT.scd")
Document.open("/home/pi/Documents/SuperCollider/Syntactic-Poems/SP_DRAW.scd")
Document.open("/home/pi/Documents/SuperCollider/Syntactic-Poems/SP_LIST.scd")
Document.open("/home/pi/Documents/SuperCollider/Syntactic-Poems/SP_OSC.scd")
Document.open("/home/pi/Documents/SuperCollider/Syntactic-Poems/SP_SND.scd")