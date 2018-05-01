//
//  Rack.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "Rack.h"

@implementation Rack {
    NSMutableArray *copyPositions;
}

// A custom designated initializer for an UIView subclass.
- (id)initWithFrame:(CGRect)frame letters:(NSArray*)letters tileSize:(CGFloat)size {
    // Initialize the superclass first.
    //
    // Make sure initialization was successful by making sure
    // an instance was returned. If initialization fails, e.g.
    // because we run out of memory, the returned value would
    // be nil.
    self = [super initWithFrame:frame];
    if (self) {
        // Set vars
        self.letters = [letters mutableCopy];
        
        /*self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.imgView setImage:[UIImage imageNamed:@"rack.png"]];
        [self.imgView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.imgView];*/
        
        UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wood_pattern"]];
        self.backgroundColor = patternColor;
        self.positions = [[NSMutableArray alloc] init];
        
        // Add blank tiles
        for (int i = 0; i < 7; i++) {
            UIView *blankTile = [[UIView alloc] initWithFrame:
                                 CGRectMake(i * self.frame.size.width / 7 + size/2, 0, size - 2, size - 2)];
            CGPoint point = CGPointMake(blankTile.center.x, self.frame.size.height/2);
            [blankTile setCenter: point];
            [blankTile setBackgroundColor:[UIColor colorWithRed:0.33 green:0.33 blue:0.33 alpha:0.4]];
            [self addSubview:blankTile];
            
            [self.positions addObject: [NSValue valueWithCGPoint:point]];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 30)];
        [label setFont:[UIFont fontWithName:@"Avenir" size:20]];
        [label setText:@"Tile Rack"];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        
        copyPositions = [[NSMutableArray alloc] initWithArray:self.positions copyItems:YES];
        [copyPositions sortUsingComparator:^NSComparisonResult(id firstObject, id secondObject) {
            CGPoint firstPoint = [firstObject CGPointValue];
            CGPoint secondPoint = [secondObject CGPointValue];
            return (firstPoint.x > secondPoint.x) - (secondPoint.x > firstPoint.x);
        }];
    }
    return self;
}

- (void) resetPositions {
    self.positions = [[NSMutableArray alloc] initWithArray:copyPositions copyItems:YES];
}

@end
