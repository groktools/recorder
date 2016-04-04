# Recorder
Record your explorations of code

# Introduction
**Recorder** is the idea that you should record your interactions with the code you're trying to understand so that you can replay it later for recall or to share with others.


#Why Recorder
As found by [Maalej et al](https://mobis.informatik.uni-hamburg.de/wp-content/uploads/2014/06/TOSEM-Maalej-Comprehension-PrePrint2.pdf) (page 12):
> 3 Developers interact with the application user interface to test whether the application behaves as expected and to find starting points for further inspection..

The idea, therefore, is to make it easy to record and replay developer interactions with the system under study to make comprehension easier.

# The dream record/replay tool
Ideally, there would be a single tool that would allow you to record and replay. One can imagine a tool that works like so:

    ./record --context="Booking ticket" --all-input -o booking_ticket.log

...which could be played back like so:

    ./replay booking_ticket.log

However, things are not that easy in the real world:
* **Privacy/Security concerns**:Features such as Keyboard and mouse logging are typically fraught with privacy and security concerns. OSs therefore lock these down, rightfully.
* **OS constraints**: Since these are typically low level features, each OS implements access to them differently, making integration and abstraction difficult.
* **Brittle Solution**: Assuming we get past these hurdles, we're still left with a very brittle solution: recorded data are vey specific to the conditions at the time recording and perfect replay requires a perfect recreation of those conditions.
* **Aide comprehension**: Assuming we're able to make a flexible solution, it must still enable comprehension for it to be of use to the developer.

# Addressing the real-world concerns:
* I looked at each OS's requirements for Keyboard and Mouse hooks and found code that can be found in these open-source codebases (See below). However, each one of them requires deep integration with OS build platforms with potentially very little gain for the effort.
  * OSX: https://github.com/SlEePlEs5/logKext/blob/master/logKext.cpp
  * Linux: https://github.com/gearmover/keylogger/blob/master/inputevents_linux.go
  * Windows: https://github.com/kristian/system-hook
* All of them would also require administrator access at every run (every in userspace) and could effectively be considered malware by the layman user.
* Looking for an existing solution that's accepted by most people seemed to be a better option, therefore, and I found open source solutions for each OS:
  * Linux: [Xnee](http://www.gnu.org/software/xnee/).
  * Windows: [SysHook](https://github.com/kristian/system-hook)
  * OSX: [LogKext](https://github.com/SlEePlEs5/logKext). This is keyboard only.
* After reviewing their code, I tried out XNee and found it to be quite good in capture and replay. This tool is now wrapped in `linux\record.sh` and `linux\replay.sh`
* However, the other issues still remained: replay was very brittle and easily broken. For example, the order of applications in the `alt-tab` sequence became important: an text editor was invoked instead of a browser since I'd changed the order of tabbing through applications between recording and replaying.
* I therefore started looking at a much simpler model: recording videos of application usage. The concerns here are ease of use and video size. Both of these are addressed by the recent growth in popularity of animated gifs, which results in the choice of the following tools:
  * OSX: LiceCAP: http://www.cockos.com/licecap/ which will record and convert to gifv in one step and works on OSX and Windows
  * Windows: ScreenToGIF: https://screentogif.codeplex.com/ that works on Windows only.
  * Of course, existing commercial solutions are well known and [documented](http://www.labnol.org/software/video-demo-with-animated-gif/28095/).

# Why this makes more sense than building another all-encompassing tool

1. Small tools that can be used for different purposes work better than big tools that are sharpened for a single purpose.
2. An all-encompassing tool would **still** fall short on the comprehension axis.
3. As found by [Maalej et al](https://mobis.informatik.uni-hamburg.de/wp-content/uploads/2014/06/TOSEM-Maalej-Comprehension-PrePrint2.pdf) (Page 15):
  > ...Industry developers do not use dedicated program comprehension tools
  > ...During comprehension tasks, IDE and specialized tools are used in parallel by developers, despite the fact that the IDE provides similar features.
