//
//  Board.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardTile.h"
#import "Pair.h"

@interface Board : UIView

@property (strong, nonatomic) NSMutableArray *board;

@end
