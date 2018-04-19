//
//  Pair.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pair : NSObject

- (id) initWithRow:(NSInteger)row col:(NSInteger)col;

@property NSInteger row;
@property NSInteger col;

@end
