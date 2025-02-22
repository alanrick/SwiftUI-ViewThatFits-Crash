# Swift 6 Crash Puzzle
This small project crashes when compiled with Swift 6. It does not produce warnings, but crashes when one of the yellow buttons is pressed.
The code can be changed to prevent the crash. These changes are marked in the source code with **Uncrash**. But this just cures the symptoms, not the cause.

Historical: This code was refactored to follow the MVVM architecture. Prior to this the code did not crash.

**Who can discover the cause of the crashes?**

**Update:** Claude.ai found the nub of the problem instantly.

## Summary of the Cause
1. Removing the *ViewThatFits* from ResultPointsView in ResultPointsView.swift prevents the crash, or,
2. Removing the *animation* from ChangePointsView in ChangePointsView.swift also prevents the crash, or, 
3. Removing the *Text("hello world")* in the ContentView in ContentView.swift also prevents the crash, or, 
4. Removing the *if* statement in the DisplayOnePointView also prevents the crash.

I'm pretty sure that number 1 is the real culprit. ViewThatFits cannot figure which view to use because of the animation etc. Points 2 to 4 are just coincidental. They tip the scale  making the ViewThatFits have to work too hard to reach a decision and the app crashes.

## Xcode Fix
Apple replied today to my ticket to say the problem has now been now fixed:
Xcode 16.3 beta (16E5104o)
https://developer.apple.com/download/ 

Ticket: [FB16236881](https://feedbackassistant.apple.com/feedback/16236881)