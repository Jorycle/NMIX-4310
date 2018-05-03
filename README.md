# NMIX 4310, Rich Media Production
Updated 05/03/2018

1. [Jukebox](#jukebox) (iOS, Swift, Xcode)
2. [RandomFlashcards](#randomflashcards) (iOS, Swift, Xcode)

These are a couple of the more notable apps I developed during my time in NMIX 4310. It was a very educational experience, easily one of my more productive classes during my time at UGA. These were all developed using an Xcode somewhere around version 9.3 and Swift 4, mostly using established Software Engineering practices regarding data modeling and decoupling. Future updates in my spare time to these applications will likely take the software engineering aspect several steps further.

## Jukebox

The Jukebox app uses the Apple iTunes API to deliver samples of iTunes' top 10 hottest tracks. With simple JSON parsing, the app can get all of the metadata for songs and then dive into a separate section of a slightly different Apple API to retrieve the song itself. Given that this functionality took a little twisting for me to accomplish on the part of retrieving the song, I imagine Apple may eventually remove song sample clips from non-affiliate APIs.

Samples are limited to just 30 seconds each, but you can browse the top 10 songs to view artist and album names, the album artwork, and listen to the clip.

If I were to update this further in the future, I would likely include a less wonky-looking interface, links to the iTunes store, and perhaps divide it into several categories of songs to select from.

(And maybe make it look like good old WinAmp from my childhood...)

You can [view the code here](https://github.com/Jorycle/NMIX-4310/tree/master/Jukebox), or [download the archive here](https://github.com/Jorycle/NMIX-4310/raw/master/Jukebox.zip).

## RandomFlashcards

This is my centerpiece, final project app for NMIX 4310 and it represents just about everything I learned in the class. It leverages the Quizlet API to deliver random flashcards chosen by the user from Quizlet's massive set database.

Although Quizlet has its own app that delivers flashcards, I was interested in making something that was a little bit more of a crossover with another popular flashcard study tool, Anki. Anki improves retention by randomly giving you vocabulary in accordance to a priority level - terms you know well will show up every couple of minutes, while terms you don't know at all will show up frequently. It depends on user feedback to figure out these priorities.

My algorithm is not quite as complex as Anki's - it uses a simple 3 star rating system, with three stars indicating that you've mastered the term. Cards are chosen by a simple random generator, with roughly a 60% chance for 1-star terms to appear and a 10% chance for 3-star terms, and 2-star cards sit somewhere inbetween. In practice, it usually works pretty well for giving you new content while also refreshing what you know about mastered terms.

Beyond that, you can choose sets from the entire range of public sets on Quizlet and create your own master deck, removing cards you're not interested in at selection and merging them into one larger set. You can then save this set - and all of your star ratings with it - so that you can come back to exactly where you left off. Because the data is saved locally on your device, you can also send your deck to a friend so they can study off of it, too.

This video gives it a quick walkthrough:
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/WNgWUa39f28?rel=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


You can [view the code here](https://github.com/Jorycle/NMIX-4310/tree/master/RandomFlashcards), or [download the archive here](https://github.com/Jorycle/NMIX-4310/raw/master/RandomFlashcards.zip).
