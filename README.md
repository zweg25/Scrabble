# Scrabble: 
Linguistic Principles Behind Word Games

**Project Description:** A scrabble board solver that allows a user to set up a normal scrabble board and the best resulting word based on points scored and tiles left after words are played.

## How to run code

**Instructions**

When you download this repository you can run it straight in [XCode](https://developer.apple.com/xcode/downloads/). Make sure you have a reliable wifi connection for certain HTTP requests. 

## Design Details

This project was programmed in Objective-C. I broke up the project into three main components: the board, the rack, and the solver. 
The board handles the values of each tile on it as well as the point value for each tile.
The rack maintains the tiles ready to play and interacts with http://www.cross-tables.com/leaves.php, an online scrabble calculator to determine the leave value of certain rack.
The solver interacts with the board and the rack to find the top point value words according to score and leave value. It uses a Dictionary object which contains all words and prefixes in an English Words With Friends dictionary to test all combinations of valid letters.

Putting this altogether results in a basic intelligent scrabble solver that ranks the top plays.


## Motivation

In my Linguistic Principles Behind Word Games class at Brown University, I learned about the orthography and phonology of the English language. 
The goal of this project is to demonstrate the significance of positive and negative synergy in the English language through gameplay.

In the normal game of Scrabble most inexperienced players search only for the highest scoring word. 
However, studies from linguists such as Bagehmil suggest that the tiles left in the rack after a word is played are critical when deciding what to play.
This stems from understanding the tendencies in the English language (and other languages that play Scrabble).
There are many orthographic factors that come to play beyond just a word's value.

In English, most words maintain a rhythmic isochrony, meaning most speech has a standard duration. This causes many words in the language to have a structured consonant-vowel (CV) balance.
Thus, when a high scoring word results in a poor CV balance left in a player's rack, it should be questioned whether or not that word is the best play because it will make the next turn more difficult.
That is what this program explores. It calculates the synergy of the tiles left over for the next turn, giving the rack a leave-score along with the normal point value score.

Each tile has an average single-tile leave value based on its frequency in common words, but there are also calculators that evaluate the synergy of a group of tiles.
The difference is a calculator considers the score of the letters left in the rack based on how well they go together taking in factors like CV balance and common combinations of letters in the English language.
For example, a "Q" is a very difficult tile to play, giving it a negative single-tile leave score.
However, if a "U" is also in a player's rack, then the value of their leave score together becomes positive.
Consequently, single-tile leave scores could have very different outputs than the overall rack's leave score.
The single tile leave score does not think of the entire hand. However, it does consider the strength of letters on average.
That is why I use both values in my program to evaluate the total value of a specific play.

Duplicate tiles are another source of negative synergy. The only two tiles that have positive synergy according to Scrabble professional Joel Wapnick are S and Blank tiles. Every other letter causes more difficulty in producing words with the other tiles, causing a negative leave score. Similarly, pattens of letters that do not occur in complex onsets or codas in the language cause a similar negativity. This can be seen in KV, MW, QX and many other pairs of letters. My program attempts to consider these details when trying to rank different plays.

Overall, this program is motivated by different linguistic topics to not only provide the best Scrabble word, but also to explore how significant synergy is in the English language.

## Known Bugs/What's Next

As of now, blank tiles are not implemented. They are not as important to the motivation of the project. 
Additionally, exchanging tiles are a very important factor in the game of Scrabble, 
but because I do not have direct access to the algorithm's calculators use to determine a rack's leave score, I could not try every combination of leftover racks as it would take to long.
Thus, the next most important thing to implement is evaluating the value of exchanging tiles in an efficient way.

