//
//  TextTile.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "TextTile.h"

@implementation TextTile

// A custom designated initializer for an UIView subclass.
- (id)initWithFrame:(CGRect)frame letter:(NSString*)letter clonable:(Boolean)clonable {
    // Initialize the superclass first.
    //
    // Make sure initialization was successful by making sure
    // an instance was returned. If initialization fails, e.g.
    // because we run out of memory, the returned value would
    // be nil.
    self = [super initWithFrame:frame];
    if (self) {
        // Set vars
        self.origSize = self.frame.size;
        self.letter = letter;
        self.isBlank = [self.letter isEqualToString:@"blank"];
        
        // Init imgview
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        UIImage *tileImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", letter]];
        [self.imgView setImage: tileImage];
        [self addSubview:self.imgView];
        
        // Add score label
        /*
        CGFloat fontSize = self.frame.size.width < 50 ? 10 : 20;
        CGFloat textPadding = self.frame.size.width < 50 ? 2 : 10;
        UIFont *font = [UIFont fontWithName:@"Avenir" size:fontSize];
        UILabel *scoreLabel = [[UILabel alloc] initWithFrame:
                               CGRectMake(self.frame.size.width - fontSize - textPadding,
                                          self.frame.size.height - fontSize - textPadding,
                                          font.pointSize, font.pointSize)];
        scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)[TextTile valueOfLetter:letter]];
        scoreLabel.font = font;
        scoreLabel.numberOfLines = 1;
        scoreLabel.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
        scoreLabel.adjustsFontSizeToFitWidth = YES;
        scoreLabel.clipsToBounds = YES;
        scoreLabel.backgroundColor = [UIColor clearColor];
        scoreLabel.textColor = [UIColor blackColor];
        scoreLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:scoreLabel];
         */
        
        self.clonable = clonable;
    }
    return self;
}

+ (NSInteger) valueOfLetter: (NSString *)letter {
    NSInteger numA = 1;
    NSInteger numB = 3;
    NSInteger numC = 3;
    NSInteger numD = 2;
    NSInteger numE = 1;
    NSInteger numF = 4;
    NSInteger numG = 2;
    NSInteger numH = 4;
    NSInteger numI = 1;
    NSInteger numJ = 8;
    NSInteger numK = 5;
    NSInteger numL = 1;
    NSInteger numM = 3;
    NSInteger numN = 1;
    NSInteger numO = 1;
    NSInteger numP = 3;
    NSInteger numQ = 10;
    NSInteger numR = 1;
    NSInteger numS = 1;
    NSInteger numT = 1;
    NSInteger numU = 1;
    NSInteger numV = 4;
    NSInteger numW = 4;
    NSInteger numX = 8;
    NSInteger numY = 4;
    NSInteger numZ = 10;
    NSInteger numBlank = 0;
    
    NSDictionary *values = [[NSDictionary alloc] initWithObjectsAndKeys:
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
    
    if ([values objectForKey:letter]) {
        return [[values objectForKey:letter] integerValue];
    } else {
        return 0;
    }
}

+ (NSInteger) valueOfTile: (TextTile *)tile {
    return [TextTile valueOfLetter:tile.letter];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (self.clonable) {
        // Add tile to remain in bag
        TextTile *remaining = [[TextTile alloc] initWithFrame:self.frame letter:self.letter clonable:true];
        [self.superview insertSubview:remaining belowSubview:self];
        
        self.clonable = false;
        remaining.delegate = self.delegate;
    }
    UITouch *touch = [event.allTouches anyObject];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.origSize.width, self.origSize.height);
    self.imgView.frame = CGRectMake(0, 0, self.origSize.width, self.origSize.height);
    [self.delegate tileTouched:self touch:touch];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if (!self.clonable) {
        UITouch *touch = [event.allTouches anyObject];
        self.center = [touch locationInView:self.superview];
    }
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [event.allTouches anyObject];
    [self.delegate tileReleased:self touch:touch];
}

@end
