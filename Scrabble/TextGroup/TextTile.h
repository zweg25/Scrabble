//
//  TextTile.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TextTile;

@protocol TextTileDelegate

- (void) tileTouched:(TextTile *)textTile touch:(UITouch *)touch;
- (void) tileReleased:(TextTile *)textTile touch:(UITouch*)touch;

@end

@interface TextTile : UIView

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) NSString *letter;
@property Boolean isBlank;
@property Boolean clonable;
@property CGFloat pointValue;
@property CGSize origSize;

@property (weak, nonatomic) id <TextTileDelegate> delegate;


- (id)initWithFrame:(CGRect)frame letter:(NSString*)letter clonable:(Boolean)clonable;

@end

