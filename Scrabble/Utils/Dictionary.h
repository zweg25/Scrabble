//
//  Dictionary.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dictionary : NSObject

@property (strong, nonatomic) NSArray *words;
@property (strong, nonatomic) NSSet *prefixes;

- (id) initWithFile:(NSString *)file;

@end
