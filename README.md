# NMIX 4310, Rich Media Production
Updated 05/03/2018

1. [Jukebox](#jukebox) (iOS, Swift, Xcode)
2. [RandomFlashcards](#randomflashcards) (iOS, Swift, Xcode)

These are a couple of the more notable apps I developed during my time in NMIX 4310. It was a very educational experience, easily one of my more productive classes during my time at UGA. These were all developed using an Xcode somewhere around version 9.3 and Swift 4, mostly using established Software Engineering practices regarding data modeling and decoupling. Future updates in my spare time to these applications will likely take the software engineering aspect several steps further.

## Jukebox

This is a simple UNIX shell that supports job control and a few basic commands.
It has a full command line interpreter that will correctly read quoted segments and break for break characters.
The shell supports piping and redirection.

**Basic commands:**
exit, cd, export, jobs, fg, bg, kill, help

Compile by running the makefile in a UNIX environment.

## RandomFlashcards
(Windows-based GUI)

This is a simple line drawing program that draws two dimensional images using sets of line coordinates provided by a user-selected text file. An example Mario text file is included (Mario is missing his hands due to a tragic plumbing accident).

After loading an image file, the controls may be used to rotate, scale, or translate the image.
Basic transformations will use the coordinates (0,0) as the center of transformation.
Advanced transformations allow the user to provide the coordinates to transform about.
The current image can be saved using the "Save Lines" feature.

After each transformation, pressing the "Draw" button will update the image. This is done deliberately for academic purposes - under the hood, the rasterization uses matrices to manipulate and display the image. By updating only at draw, we can observe the power of matrix concatenation in action.
