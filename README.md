# NMIX 4310, Rich Media Production
Updated 05/03/2018

1. [Jukebox](#jukebox) (iOS, Swift, Xcode)
2. [RandomFlashcards](#randomflashcards) (iOS, Swift, Xcode)

These are a couple of the more notable apps I developed during my time in NMIX 4310. It was a very educational experience, easily one of my more productive classes during my time at UGA. These were all developed using an Xcode somewhere around version 9.3 and Swift 4, mostly using established Software Engineering practices regarding data modeling and decoupling. Future updates in my spare time to these applications will likely take the software engineering aspect several steps further.

## Jukebox

The Jukebox app uses the Apple iTunes API to deliver samples of iTunes' top 10 hottest tracks. With simple JSON parsing, the app can get all of the metadata for songs and then dive into a separate section of a slightly different Apple API to retrieve the song itself. Given that this functionality took a little twisting for me to accomplish on the part of retrieving the song, I imagine Apple may eventually remove song sample clips from non-affiliate APIs.
Sadly, samples are limited to just 30 seconds each, but you can browse the top 10 to view artist and album names, the album artwork, and listen to the clip. If I were to update this further in the future, I would likely include a less wonky-looking interface, links to the iTunes store, and perhaps divide it into several categories of songs to select from.
(And maybe make it look like good old WinAmp from my childhood...)

You can [view the code here](https://github.com/Jorycle/NMIX-4310/tree/master/Jukebox), or [download the archive here](https://github.com/Jorycle/NMIX-4310/raw/master/Jukebox.zip).

## RandomFlashcards

This is my centerpiece, final project app for NMIX 4310 and it represents just about everything I learned in the class. It 
