# "Set" Card Game
## 1.1 Rules
 
 "Set" is a card game where a group of players try to identify a "set" of cards from those placed
face-up on a table.
Each card has an image on it with 4 orthogonal attributes:

* Color (red, green, or purple)
* Shape (diamond, squiggle, or oval)
* Shading (solid, empty, or striped)
* Number (one, two, or three)

Three cards are a part of a set if, for each property, the values are all the same or all different.
For example:

* The cards "two red solid squiggles", "one green solid diamond", "three purple solid ovals" would make up a set. (number, shape, and color are different, shading is the same)
* The cards "two red solid squiggles", "one green solid squiggles", "three purple solid ovals" would not make up a set, because shape is the same on two cards, but different on the third.
* A game of Set starts by dealing 12 cards, face-up. When a player sees three cards that make up a set, they yell "Set!" and grab the cards. New cards are dealt from the deck to replace them.
* If no player can find a set, three more cards are dealt (to make 15, then 18, then 21…)
* The game is over when there are no cards left in the deck, and no sets left on the table. The player with the most sets wins.

## 1.2 Requirements

Your task is to model the game in code, and implement the following methods:

* A method that takes three cards, and determines whether the three cards make a set
  * Card::is_set?
* A method that given a "board" of cards, will either find a set, or determine if there are no sets on the table
  * Board#find_set
* A method that will play an entire game of Set, from beginning to end, and return a list of each valid sets you removed from the board.
  * Game#play
  
For this last method, there will be multiple correct solutions, but any valid list of sets is fine.

## 1.3 Guidelines
We expect that you should be able to complete this exercise in no more than a few hours. We
understand that that might be a pretty large chunk of time, and we appreciate the effort you put in
to help us build a great team.

If you can't invest that much time, we would also be happy to see a solution to a version of this
problem with more limited scope, or code you've written from another interesting project of
yours.

After you submit your code to us, we'll get in touch with you, and potentially arrange an
interview with someone from the team. Besides the typical technical interview questions, you
should also be prepared to talk about and improve your answer to this problem.

### 1.3.1 How far should I go?
Keep your solution simple, but treat it like production code, whatever that means to you. We're
trying to understand what your day-to-day development process is like, so the closer you can get
to that, the better.

You can use any language or tools you're most comfortable with – if we can't parse it, we'll
follow up.


### 1.3.2 What if I don't understand the problem, or something isn't totally clear?
If your question isn't blocking your progress, we'd prefer that you make your best guess, and
document your assumptions. If you can't move forward, let us know, and we'll try to help.

Questions:
1. How many cards on a board (starts with 3x4 = 12 by default)?
2. How many players? (2 by default, by accepts a num_players parameter)
3. How many cards in a deck? (3*3*3*3 = 81 possible unique comibiations)
4. Is the game supposed to play by itself then exit and list all captured sets?