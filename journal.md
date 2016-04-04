
**3/28/2016, 7:07:27 PM**: The ideal recorder should:
 - run in userspace, no deameons
 - snapshot initial state of the system so it can be recreated somehow later
 - track all user input (keyboard, mouse, touch) and record it appropriately
 - replay such sessions later, ie actually meeting the purpose of recording.
 - maybe run via sudo since keyboard and mouse logging are typically "system" functions.
 - push events to lilbro ideally, or if the volume is too much, store to a known location and let lilbro know start/stop events

# Solution options

* OS-level logger: write a logger for each input device for each OS. Send captured input to lilbro.
  * Pros: Will capture system-wide events
  * Cons: Difficult to write, will not capture snapshot of initial state easily.
* VirtualBox-based solution: Use VBox API to record events from a VM. Parse and send captured input or start/stop to lilbro
  * Pros: Can use VM snapshot feature to keep initial state, uniform coordinate/scancode capture.
  * Cons: debugvm log may not actually capture keyboard events. Also cannot replay mouse events easily.
* Browser-based solution: Create a solution that works on a browser alone. Maybe using Selenium recorder.
  * Pros: can easily recorder and replay.
  * Cons: may still not be able to recreate original state, and it wont be system-wide.


**3/29/2016, 8:38:39 PM**: Havent had much success with vbox. OS level logger design:

OSX: C++ OS hook thats installed by userspace program, which records to lilbro. opensource code: https://github.com/SlEePlEs5/logKext/blob/master/logKext.cpp
linux: use code from open souce keylogger: https://github.com/gearmover/keylogger/blob/master/inputevents_linux.go
windows: use code from https://github.com/kristian/system-hook

combine all of these into one go program that is a client for lilbro. So overall arch:
cmdline recorder -> OS-specific device hook -> lilbroclient -> lilbro server

**3/29/2016, 9:44:01 PM**: Finally got xnee working. Had to prevent the build of gnee for it to work, but after reviewing it, i thought about how to make this universal. Clearly this could be converted into a go-based tool that spans all os's. however: there are still privacy concerns and i'm not sure that the real purpose - understanding code - is really met. So i'm gonna look for an open source video recorder software that can generate gifvs.

**3/29/2016, 10:25:11 PM**: Found two open source options:
* LiceCAP: http://www.cockos.com/licecap/ which will record and convert to gifv in one step and works on OSX and Windows
* ScreenToGIF: https://screentogif.codeplex.com/ that works on Windows only.

This is aside from other commercial offerings such as Camtasia Studio, et al, rounded up well here: http://www.labnol.org/software/video-demo-with-animated-gif/28095/
