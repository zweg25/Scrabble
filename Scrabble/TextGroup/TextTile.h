//
//  TextTile.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTile : UIView

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) NSString *letter;
@property Boolean isBlank;
@property CGFloat pointValue;

- (id)initWithFrame:(CGRect)frame letter:(NSString*)letter;

@end
