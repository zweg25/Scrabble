//
//  Rack.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Rack : UIView

- (id)initWithFrame:(CGRect)frame letters:(NSArray*)letters tileSize:(CGFloat)size;
- (void) resetPositions;

@property (strong, nonatomic) NSMutableArray *letters;
@property (strong, nonatomic) NSMutableArray *positions;
@property (strong, nonatomic) UIImageView *imgView;

@end
