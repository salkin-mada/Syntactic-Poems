

:::::> _PROGRAM_STABILITY_LOG <:::::
------------on RPI------------------


// no visuals, (8192*10) server mem
1 amp power
17:35-18:20 = 45 mins -> crashed, unresponsive
//from fresh boot, 2 amp power, no xfvb, no vnc reboot, no visuals, !!-> with or not no (not sure damn) localbuf function
18:42-19:52 = 70 mins -> all good -> reboot

// here after with visuals, Pen, drawFunc, u.animate

//with localbuf function, 1024/4 size, s.latency default
21:35-quickly started to run more functions at a time,
as if one function started a "lavine" and just kept going on into the next function call

//no localbuf function, 1024/4 size, s.latency default
21:48-22:10 = 22 mins -> crashed, unresponsive

//no localbuf function, 1024/4 size, s.latency default, fps 60
21:48-22:10 = 22 mins -> yellow server meters, lang still going strong
after quitting server, lang keeps posting new function calls to the post window
quit lang, tried to reboot but no go. jacky needs restart..

//1024/4 size, s.latency default, fps 60, no localbuf func
//attempt in blindness -> with weird .clear message on Pen buffer on silence func.
// silly detail.. did not move gendar_thata windows from init position... esoterisk som fa'en!
22:44-00:06 = 82 mins -> all good -> re-compile - reboot intepreter - reboot server

// exact same settings, BUT 1024/2 size
00:07-00:09 -> manually aborted -> re-compile
started to run more functions at a time,
as if one function started a "lavine" and just kept going on into the next function call
-- observation, while running sudden yellow server meters but turns green again. everything alright?

// same, but now with framerate limited to 30 fps;
00:19-00:27 -> crash, hmm weird, meters green lang posting funcs in post window, but no sound and no change in draw func
killed all servers -> lang keeps posting func in post window -> quit lang

//for the heck of it attempt - > 1024 size!!, s.latency default, fps 30, no localbuf func
00:41-00:44 -> immediately starts to "lavine" func calls -> drawFunc stoppes working, window black -> reboot
-- interestingly enough while "lavining" silence y.at(0) works this time... ==?
-- should add: that this run was done with u.framerate.asInteger on Pen.stringAtPoint

we need a new approach, raising sys mem even more? rpi er det mulig.

stepping down one notch
// 1024/2, s.latency default, fps 30 (fps shown in win), no localbuf func
00:47-00:51 -> immediately starts to "lavine" func calls, no silences -> reboot

restore settings from last 82 mins succes, but with additional 30 fps restriction
// 1024/4, s.latency default, no localbuf func, fps 30
(win size to small, so we cant see, but u.frameRate.asInteger is uncommented)
00:55-00:01 -> manual abort, seems stable "hm hm" -> cmd-period -> win close, lang hangs? -> quit lang -> reboot

// same as above, BUT  1024/2 and (8192*13) server mem, and u.frameRate.asInteger is commented out
01:08-01:09 -> fucked, "lavine", static black win -> reboot

lowering mem drastically
//1024/2 and (8192*6) server mem, and u.frameRate.asInteger is commented out, no local buf
01:12-15 = 3 mins -> seems smooth, but then "lavine"

-- posib new approach lowering screen resolution?

going to sleep

-- maybe -p95 should go -p75

//1024/4 and (8192*10) mem, no local buf func, fps 30
12:08-12:10 -> manual abort, seems steady -> reboot

// lowering fps attempt
// 1024/2, 8192*10 mem, no local buf func, fps 15
12:11-12:16 -> manual abort, seems steady -> cmd-period

// 1024 size, 8192*10 mem, no local buf func, fps 15
12:16-12:17 -> "lavine", clicks, win draw stuck in black -> reboot

// 1024 size, 8192*10 mem, no local buf func, fps 10
12:18-12:20 -> "lavine", clicks, win draw stuck -> cmd-period -> quit lang -> reboot

// 1024 size, 8192*13 mem, no local buf, fps 10
12:22-24 -> "lavine"

--walking silently away, going back to 512 size
// 1024/2, 8192*13 mem, no local buf, fps 24
12:50-12:57 -> was very smooth but then alas! clicks and "lavine"

// 1024/2, 8192*10 mem, no local buf func, fps 24,
-- simplyfied func calls i.e often silence and pen buf clear. makes any difference?
13:00-13:07 -> was very smooth but then alas! clicks and "lavine"
-- it seems something gets "filled" up and it disturbs the ugen graph or scheduling.

// 1024/2, 8192*10 mem, no local buf func, fps 24,
-- no fice func for the hell of it
13:11-13:13 -> "lavine" -> reboot -> quit lang -> reboot -> couldn't activate jacky client ' -> jacky reboot
-- dump node tree

// 1024/2, 8192*10 mem, no local buf func, fps 24,
-- changing OSC rate from 60 Hz to 24 Hz
13:20-13:29 -> manual abort -> seems stable
-- alas alas have been overflooding server with OSC all along
-- insisting on esoterisk stemning, overlooking the -> ovious <-

// 1024, 8192*10 mem, no local buf func, fps 24, OSC rate 24 Hz
13:30-13:36 -> manual abort -> seems stable

-- going fullscreen on draw win
// size l=900, h=900 w=l*1.6, 8192*10 mem, no local buf func, fps 24, OSC rate 24 Hz
13:47-13:54 -> manual abort -> seems stable

// size l=900, h=900 w=l*1.6, 8192*10 mem, with local buf func, fps 24, OSC rate 24 Hz
-- and stepping up src complexity
13:56-13:57 -> draw win stuck in black but no sound "lavining"

// size l=900, h=900 w=l*1.6, 8192*10 mem, with local buf func, fps 24, OSC rate 24 Hz
--no pen buf clear and no local buf clear in pattern
14:00-14:02 -> draw win stuck in black but no sound "lavining"
-- small harsh burst calling poem 49, draw win not animated
-- BUT! trails opacity interacting with text from Pen.stringAtPoint, interesting.

//same as above but no call to local buf func(poem 49) in pattern
14:10-14:20 -> manual abort -> seems stable


// size l=900, h=900 w=l*1.6, 8192*13 mem, with local buf func, fps 24, OSC rate 24 Hz
14:20-14:21 -> harsh sound calling local buf func poem 49 -> black screen
-- dump node tree

// size l=900, h=900 w=l*1.6, 8192*13 mem, with local buf func, fps 24, OSC rate 24 Hz
-- clearing local buf everytime poem 49 is called
14:28-14:29 -> yellow Server meters -> all freeze -> could not re-initialize audio -> jacky reboot

// size l=900, h=900 w=l*1.6, 8192*6 mem, with local buf func, fps 24, OSC rate 24 Hz
-- making local buf global var into environment ~variable - no clearing in pattern
-- -> freeing in pattern
14:55-14:56 -> harsh burst, unresponsive draw win -> reboot

// size l=900, h=900 w=l*1.6, 8192*10 mem, with Buffer.alloc(8192,2) on poem 49 func, fps 24, OSC rate 24 Hz
-- -> no freeing in patt
-- -> throwing LocalBuf out the window -> exchanged with Buffer.alloc
-- no RecordBuf of ndef sum
15:18-15:32 = 14 mins -> manual abort -> seems stable
-- keep good distance to LocalBuf on RPI

//size l=900, h=900 w=l*1.6, 8192*10 mem, fps 24, OSC rate 24 Hz
-- with RecordBuf of ndef sum
-- if all is well, try to push FPS
15:32-15:44 = 12 mins -> manual abort -> seems stable

--pushing FPS
//size l=900, h=900 w=l*1.6, 8192*10 mem, fps 60, OSC rate 24 Hz
15:44-15:48 -> manual abort -> seems stable, but is a bit laggy
--going for 40 FPS

//size l=900, h=900 w=l*1.6, 8192*10 mem, fps 40, OSC rate 24 Hz
-- endurance test
-- going for a walk
16:23-








// something complete different.

new one on windows:
compiling class library...
	Found 695 primitives.
	Compiling directory 'C:\Program Files\SuperCollider-3.9.3\SCClassLibrary'
	Compiling directory 'C:\Users\na\AppData\Roaming\SuperCollider\Extensions'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\Extensions'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\Vowel'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\XML'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\wslib'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\miSCellaneous_lib'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\JoshMisc'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\crucial-library'
	Compiling directory 'C:\Users\na\AppData\Local\SuperCollider\downloaded-quarks\rd_dot'
	numentries = 1864435 / 35028112 = 0.053
	8396 method selectors, 4172 classes
	method table size 33688472 bytes, big table size 280224896
	Number of Symbols 21326
	Byte Code Size 838675
	compiled 868 files in 2.52 seconds

Info: 19 methods are currently overwritten by extensions. To see which, execute:
MethodOverride.printAll

compile done
localhost : setting clientID to 0.
internal : setting clientID to 0.
Class tree inited in 0.01 seconds


*** Welcome to SuperCollider 3.9.3. *** For help press Ctrl-D.
SCDoc: Indexing help-files...
SCDoc: Indexed 2353 documents in 5.42 seconds
WARNING: SCDoc: In C:\Program Files\SuperCollider-3.9.3\HelpSource\Classes\Buffer.schelp
  Grouped methods [ getn, getMsg ] do not have the same argument signature.
WARNING: SCDoc: In C:\Program Files\SuperCollider-3.9.3\HelpSource\Classes\Buffer.schelp
  Method -cheby has arg named 'amps', but doc has 'argument:: amplitudes'.