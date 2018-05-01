//
//  Tile.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "BoardTile.h"

@implementation BoardTile

// A custom designated initializer for an UIView subclass.
- (id)initWithFrame:(CGRect)frame type:(TileType)type position:(Pair*)pos {
    // Initialize the superclass first.
    //
    // Make sure initialization was successful by making sure
    // an instance was returned. If initialization fails, e.g.
    // because we run out of memory, the returned value would
    // be nil.
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        switch (self.type) {
            case TripleWord:
                self.backgroundColor = [UIColor orangeColor];
                break;
            
            case DoubleWord:
                self.backgroundColor = [UIColor redColor];
                break;
                
            case TripleLetter:
                self.backgroundColor = [UIColor blueColor];
                break;
                
            case DoubleLetter:
                self.backgroundColor = [UIColor cyanColor];
                break;
                
            case StarTile:
                self.backgroundColor = [UIColor greenColor];
                break;
                
            default:
                self.backgroundColor = [UIColor lightGrayColor];
                break;
        }
        self.isUsed = false;
        self.letter = @"";
        self.position = pos;
    }
    return self;
}

- (TileType) setTileType:(TileType)type {
    self.type = type;
    return self.type;
}

@end
