//
//  Bag.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextTile.h"

@interface Bag : UIView

@property (strong, nonatomic) NSDictionary *tiles;
@property CGFloat tileSize;
- (NSInteger) numberOfTile: (NSString *)tile;

@end
