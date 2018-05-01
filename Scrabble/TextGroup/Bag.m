//
//  Bag.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "Bag.h"

@implementation Bag

// A custom designated initializer for an UIView subclass.
- (id)initWithFrame:(CGRect)frame inViewController:(ViewController<TextTileDelegate>*)viewController {
    // Initialize the superclass first.
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.25];
        self.viewController = viewController;
        [self populateTiles];
        [self initView];
    }
    return self;
}

- (void) populateTiles {
    
    NSInteger numA = 9;
    NSInteger numB = 2;
    NSInteger numC = 2;
    NSInteger numD = 4;
    NSInteger numE = 12;
    NSInteger numF = 2;
    NSInteger numG = 3;
    NSInteger numH = 2;
    NSInteger numI = 9;
    NSInteger numJ = 1;
    NSInteger numK = 1;
    NSInteger numL = 4;
    NSInteger numM = 2;
    NSInteger numN = 6;
    NSInteger numO = 8;
    NSInteger numP = 2;
    NSInteger numQ = 1;
    NSInteger numR = 6;
    NSInteger numS = 4;
    NSInteger numT = 6;
    NSInteger numU = 4;
    NSInteger numV = 2;
    NSInteger numW = 2;
    NSInteger numX = 1;
    NSInteger numY = 2;
    NSInteger numZ = 1;
    NSInteger numBlank = 2;

    self.tiles = [[NSDictionary alloc] initWithObjectsAndKeys:
                  [NSNumber numberWithInteger: numA], @"A",
                  [NSNumber numberWithInteger: numB], @"B",
                  [NSNumber numberWithInteger: numC], @"C",
                  [NSNumber numberWithInteger: numD], @"D",
                  [NSNumber numberWithInteger: numE], @"E",
                  [NSNumber numberWithInteger: numF], @"F",
                  [NSNumber numberWithInteger: numG], @"G",
                  [NSNumber numberWithInteger: numH], @"H",
                  [NSNumber numberWithInteger: numI], @"I",
                  [NSNumber numberWithInteger: numJ], @"J",
                  [NSNumber numberWithInteger: numK], @"K",
                  [NSNumber numberWithInteger: numL], @"L",
                  [NSNumber numberWithInteger: numM], @"M",
                  [NSNumber numberWithInteger: numN], @"N",
                  [NSNumber numberWithInteger: numO], @"O",
                  [NSNumber numberWithInteger: numP], @"P",
                  [NSNumber numberWithInteger: numQ], @"Q",
                  [NSNumber numberWithInteger: numR], @"R",
                  [NSNumber numberWithInteger: numS], @"S",
                  [NSNumber numberWithInteger: numT], @"T",
                  [NSNumber numberWithInteger: numU], @"U",
                  [NSNumber numberWithInteger: numV], @"V",
                  [NSNumber numberWithInteger: numW], @"W",
                  [NSNumber numberWithInteger: numX], @"X",
                  [NSNumber numberWithInteger: numY], @"Y",
                  [NSNumber numberWithInteger: numZ], @"Z",
                  [NSNumber numberWithInteger: numBlank], @"blank",
                  nil];
}

- (NSInteger) numberOfTile: (NSString *)tile {
    if ([self.tiles objectForKey:tile]) {
        return [[self.tiles objectForKey:tile] integerValue];
    } else {
        return 0;
    }
}

- (void) initView {
    int i = 0;
    NSArray *sortedKeys = [[self.tiles allKeys] sortedArrayUsingSelector: @selector(compare:)];
    
    int numInRow = 3;
    CGFloat padding = 6;
    self.tileSize = (self.frame.size.width / numInRow) - padding;
    
    for (NSString *letter in sortedKeys) {
        //NSInteger value = [self numberOfTile:letter];
        
        CGRect frame = CGRectMake((i % numInRow) * (self.tileSize + padding/2) + padding/2,
                                  ((int)(i/numInRow)) * (self.tileSize + padding/2),
                                  self.tileSize, self.tileSize);
        
        TextTile *textTile = [[TextTile alloc] initWithFrame:frame letter:letter clonable:true];
        textTile.delegate = self.viewController;
        [self addSubview:textTile];
        i++;
    }
}

@end
