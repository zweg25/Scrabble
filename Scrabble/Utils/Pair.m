//
//  Pair.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "Pair.h"

@implementation Pair

- (id) initWithRow:(NSInteger)row col:(NSInteger)col {
    self = [super init];
    if (self) {
        self.row = row;
        self.col = col;
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToPair:other];
}

- (BOOL)isEqualToPair:(Pair *)pair {
    if (self == pair)
        return YES;
    
    return self.row == pair.row && self.col == pair.col;
}

@end
