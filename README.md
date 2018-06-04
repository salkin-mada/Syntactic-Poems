
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


```
// notes all poems her count +1

approoveed,
44
33
21 ice
24              -- undersøg de bløde ting der kommer frem
23 ice          -- den gør det...


ovrvejs
41 alarm alarm, okay?
```
