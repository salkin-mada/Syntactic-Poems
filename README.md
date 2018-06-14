
#### disable dpms
```
sudo nano /etc/lightdm/lightdm.conf
in -> [Seat:*]
# dont sleep the screen
xserver-command=X -s 0 dpms
```

#### hide cursor
```
nano ~/.config/lxsession/LXDE-pi/autostart
# idle mouse cursor when inactive
@uncluter -display :0 -noevents -grab
```

##### clean
```
cleaned up in LXDE-pi/xsessions.conf
~.config/lxsessions/LXDE-pi/autostart
```

##### composite
```
enable PAL in /boot/config.txt
sdtv_mode
0 = Normal NTSC
1 = Japanese version of NTSC – no pedestal
2 = Normal PAL
3 = Brazilian version of PAL – 525/60 rather than 625/50, different subcarrier

sdtv_aspect
1 = 4:3
2 = 14:9
3 = 16:9

sdtv_disable_colourburst
Setting ```sdtv_disable_colourburst``` to ```1``` disables colourburst on composite video output. The picture will be displayed in monochrome, but it may appear sharper.
```

##### composite TRRS cable
```
normal working aka "correct"
|       |           |           |         >
redcenter  gnd all      yellowcenter  whitecenter
*RED is composite out.. not yellow


interesting crazy behavior
|       |           |           |         >
GND ALL  Yellowcenter whitecenter redcenter
*YELLOW (supposed composite out) reacts funny





```


#### whats my ip
```
ip addr
```

##### selection
```
subject to change

1 OK
2 NOP
3 OK
4 OK
5 NOP
6 NOP
7 NOP
8 OK
9 OK
10 OK
11 OK
12 OK
13 OK
14 NOP
15 NOP
16 OK
17 NOP
18 OK
19 NOP
20 OK
21 OK
22 OK
23 OK
24 NOP
25 NOP
26 NOP
27 OK
28 NOP
29 OK
30 NOP
31 OK
32 OK
33 OK
34 NOP
35 OK
36 OK
37 OK
38 OK
39 OK
40 NOP
41 NOP
42 NOP
43 NOP
44 NOP
45 NOP
46 NOP
47 NOP
48 OK
49 NOP
50 OK
51 OK
52 OK
53 OK
54 OK
55 OK
56 OK
57 OK
```
