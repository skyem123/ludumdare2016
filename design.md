Design Document
===============

To follow the "Ancient Technology" theme for this year,
we are making a puzzle game based around crystals. They
act as a sort of analog computer - rather than using
logic gates, as one would do with boolean values, to
solve puzzles the gates apply various operations on the
data being transferred. As if all of this weren't bad
enough, there are complications!

Crystal Types: (each has their own style!)
* Emitter: Outputs a constant value. (circle)
* Function: Takes one or more values in, outputs one value. (square or diamond)
* Note that a crystal the forwards is basically a one input function that does nothing to the value.
* Restrictor: Takes one value in, outputs one value or not at all. (triangle)
* Receiver: Takes one value and scores it based upon how close it is to the goal. (circle, fills with colour over 1 second as it "charges")

Other Mechanics:

* Connections are one way, in and out.  
* The greater the absolute value of the number a connection carries, the greater the frequency of its wave.
* ~~to indicated the source of the wave, the crystal that the wave comes from will be the same colour as the wave itself.~~
* Positive numbers have a green wave, negatives red.  
* Connections may not overlap.  
* Connections may not pass through walls.  
