//
//  Dictionary.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "Dictionary.h"

@implementation Dictionary

- (id) initWithFile:(NSString *)file {
    self = [super init];
    if (self) {
        // The source text file is named "Example.txt". Written with UTF-8 encoding.
        NSString* path = [[NSBundle mainBundle] pathForResource:file
                                                         ofType:@"txt"];
        NSError* error = nil;
        NSString* content = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:&error];
        if (error) {
            // If error object was instantiated, handle it.
            NSLog(@"ERROR while loading from file: %@", error);
        } else {
            self.words = [content componentsSeparatedByString:@"\n"];
            NSMutableSet *prefixes = [[NSMutableSet alloc] init];
            for (NSString *word in self.words) {
                for (int i = 0; i < word.length; i++) {
                    NSString *prefix = [word substringToIndex:i];
                    [prefixes addObject:prefix];
                }
            }
            self.prefixes = prefixes;
        }
    }
    return self;
}

- (bool) containsWord: (NSString *)word {
    return [self.words containsObject:word];
}

- (bool) containsPrefix: (NSString *)prefix {
    return [self.prefixes containsObject:prefix];
}


@end
