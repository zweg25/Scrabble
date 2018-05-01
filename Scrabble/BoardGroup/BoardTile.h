//
//  Tile.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pair.h"

@interface BoardTile : UIView

typedef enum {
    TripleWord,
    DoubleWord,
    TripleLetter,
    DoubleLetter,
    SingleLetter,
    StarTile
} TileType;

@property TileType type;
@property Boolean isUsed;
@property NSString *letter;
@property Pair *position;

- (id)initWithFrame:(CGRect)frame type:(TileType)type position:(Pair*)pos;
- (TileType) setTileType:(TileType)type;

@end
