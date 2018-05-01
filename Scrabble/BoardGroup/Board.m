//
//  Board.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "Board.h"

@implementation Board {
    NSInteger defaultSize;
    NSArray *doubleWords;
    NSArray *tripleWords;
    NSArray *doubleLetters;
    NSArray *tripleLetters;
}

// A custom designated initializer for an UIView subclass.
- (id)initWithFrame:(CGRect)frame size:(NSInteger)size {
    // Initialize the superclass first.
    //
    // Make sure initialization was successful by making sure
    // an instance was returned. If initialization fails, e.g.
    // because we run out of memory, the returned value would
    // be nil.
    self = [super initWithFrame:frame];
    if (self) {
        
        // Board pairs
        NSMutableArray *doubleWordsInit = [[NSMutableArray alloc] init];
        for (int i = 1; i < size - 1; i++) {
            if (i < floor(size / 2) - 2 || i > floor(size / 2) + 2) {
                Pair *dw1 = [[Pair alloc] initWithRow:i col:i];
                Pair *dw2 = [[Pair alloc] initWithRow:size - i - 1 col:i];
                Pair *dw3 = [[Pair alloc] initWithRow:i col:size - i - 1];
                Pair *dw4 = [[Pair alloc] initWithRow:size - i - 1 col:size - i - 1];
                [doubleWordsInit addObject:dw1];
                [doubleWordsInit addObject:dw2];
                [doubleWordsInit addObject:dw3];
                [doubleWordsInit addObject:dw4];
            }
        }
        doubleWords = [[NSArray alloc] initWithArray:doubleWordsInit];
        tripleWords = [[NSArray alloc] initWithObjects:
                       [[Pair alloc] initWithRow:0 col:0],
                       [[Pair alloc] initWithRow:0 col:7],
                       [[Pair alloc] initWithRow:0 col:14],
                       [[Pair alloc] initWithRow:7 col:0],
                       [[Pair alloc] initWithRow:7 col:14],
                       [[Pair alloc] initWithRow:14 col:0],
                       [[Pair alloc] initWithRow:14 col:7],
                       [[Pair alloc] initWithRow:14 col:14],
                       nil];
        doubleLetters = [[NSArray alloc] initWithObjects:
                         [[Pair alloc] initWithRow:0 col:3],
                         [[Pair alloc] initWithRow:0 col:11],
                         [[Pair alloc] initWithRow:14 col:3],
                         [[Pair alloc] initWithRow:14 col:11],
                         [[Pair alloc] initWithRow:2 col:6],
                         [[Pair alloc] initWithRow:2 col:8],
                         [[Pair alloc] initWithRow:12 col:6],
                         [[Pair alloc] initWithRow:12 col:8],
                         [[Pair alloc] initWithRow:3 col:0],
                         [[Pair alloc] initWithRow:3 col:7],
                         [[Pair alloc] initWithRow:3 col:14],
                         [[Pair alloc] initWithRow:11 col:0],
                         [[Pair alloc] initWithRow:11 col:7],
                         [[Pair alloc] initWithRow:11 col:14],
                         [[Pair alloc] initWithRow:6 col:2],
                         [[Pair alloc] initWithRow:6 col:6],
                         [[Pair alloc] initWithRow:6 col:8],
                         [[Pair alloc] initWithRow:6 col:12],
                         [[Pair alloc] initWithRow:8 col:2],
                         [[Pair alloc] initWithRow:8 col:6],
                         [[Pair alloc] initWithRow:8 col:8],
                         [[Pair alloc] initWithRow:8 col:12],
                         [[Pair alloc] initWithRow:7 col:3],
                         [[Pair alloc] initWithRow:7 col:11],
                         nil];
        
        tripleLetters = [[NSArray alloc] initWithObjects:
                         [[Pair alloc] initWithRow:1 col:5],
                         [[Pair alloc] initWithRow:1 col:9],
                         [[Pair alloc] initWithRow:13 col:5],
                         [[Pair alloc] initWithRow:13 col:9],
                         [[Pair alloc] initWithRow:5 col:1],
                         [[Pair alloc] initWithRow:5 col:5],
                         [[Pair alloc] initWithRow:5 col:9],
                         [[Pair alloc] initWithRow:5 col:13],
                         [[Pair alloc] initWithRow:9 col:1],
                         [[Pair alloc] initWithRow:9 col:5],
                         [[Pair alloc] initWithRow:9 col:9],
                         [[Pair alloc] initWithRow:9 col:13],
                         nil];
        
        // Initialize board
        self.board = [[NSMutableArray alloc] initWithCapacity:size];
        self.tileSize = fmin(self.frame.size.width, self.frame.size.height) / size;
        CGFloat padding = 2;
        for (int r = 0; r < size; r++) {
            // Create new row of tiles
            NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:size];
            for (int c = 0; c < size; c++) {
                // Add each tile to row
                CGRect frame = CGRectMake(c * self.tileSize + padding / 2, r * self.tileSize + padding / 2,
                                          self.tileSize - padding, self.tileSize - padding);
                Pair *position = [[Pair alloc] initWithRow:r col:c];
                TileType type = SingleLetter;
                if ([doubleWords containsObject:position]) {
                    type = DoubleWord;
                } else if ([tripleWords containsObject:position]) {
                    type = TripleWord;
                } else if ([doubleLetters containsObject:position]) {
                    type = DoubleLetter;
                } else if ([tripleLetters containsObject:position]) {
                    type = TripleLetter;
                } else if (r == floor(size/2) && c == floor(size/2)) {
                    type = StarTile;
                } else {
                    type = SingleLetter;
                }
                BoardTile *tile = [[BoardTile alloc] initWithFrame:frame type:type position:position];
                [self addSubview:tile];
                [row addObject:tile];
            }
            // Add row to board
            [self.board addObject:row];
        }
        self.hasStarted = false;
    }
    return self;
}

// Override the designated initializer from the superclass to
// make sure the new designated initializer from this class is
// used instead.
- (id)initWithFrame:(CGRect)frame {
    defaultSize = 15;
    return [self initWithFrame:frame size:defaultSize];
}

@end
