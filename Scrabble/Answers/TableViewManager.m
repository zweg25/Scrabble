//
//  TableViewManager.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "TableViewManager.h"

@implementation TableViewManager {
    NSString *curWord;
}

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat padding = 10;
        CGRect tableViewFrame = CGRectMake(0, 0, self.bounds.size.width / 2 - padding, self.bounds.size.height);
        self.tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:0.9];
        [self addSubview:self.tableView];
        
        self.answers = [[NSMutableArray alloc] init];
        
        CGRect answerDisplayFrame = CGRectMake(self.bounds.size.width / 2, 0, self.bounds.size.width / 2 - padding, self.bounds.size.height);
        self.answerDisplay = [[UITextView alloc] initWithFrame:answerDisplayFrame];
        self.answerDisplay.backgroundColor = [UIColor lightGrayColor];
        self.answerDisplay.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
        self.answerDisplay.textColor = [UIColor whiteColor];
        self.answerDisplay.delegate = self;
        [self addSubview:self.answerDisplay];
    }
    return self;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.answers.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AnswerCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
    if (cell == nil) {
        [self.tableView registerNib:[UINib nibWithNibName:@"AnswerCell" bundle:nil] forCellReuseIdentifier:@"AnswerCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AnswerCell"];
    }
    if (self.bounds.size.width < 300) {
        cell.answerLabel.font = [UIFont fontWithName:cell.answerLabel.font.fontName size:14];
        cell.scoreLabel.font = [UIFont fontWithName:cell.scoreLabel.font.fontName size:cell.scoreLabel.font.pointSize - 4];
    }
    if (self.answers.count > indexPath.row) {
        NSDictionary *answerDictionary = [self.answers objectAtIndex:indexPath.row];
        CGFloat totalScore = [[answerDictionary objectForKey:@"totalValue"] floatValue];
        cell.scoreLabel.text = [[NSString alloc] initWithFormat:@"%.1f", totalScore];
        cell.answerLabel.text = [[NSString alloc] initWithFormat:@"%@ (%@)", [answerDictionary objectForKey:@"mainWord"], [answerDictionary objectForKey:@"score"]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerCellTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate didSelectRow:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = [self.answers objectAtIndex:indexPath.row];
    
    NSString *display = [[NSString alloc] initWithFormat:@"%@\n", [[dic objectForKey:@"mainWord"] uppercaseString]];
    
    CGFloat leave = [[dic objectForKey:@"leave"] floatValue];
    NSString *rack = [dic objectForKey:@"rack"];
    
    if (leave > 1) {
        display = [[NSString alloc] initWithFormat: @"%@This scores well because it leaves you with a high scoring leave value of %.3f with the rack: %@\n", display, leave, rack];
    } else if (leave < -3) {
        display = [[NSString alloc] initWithFormat: @"%@Although this word may have a decent score, it has a low leave value of %.3f with the rack: %@\n", display, leave, rack];
    } else {
        display = [[NSString alloc] initWithFormat: @"%@This scores a total number of %@ points with a neutral leave score.\n", display, [dic objectForKey:@"score"]];
    }
    
    if (rack.length > 0) {
        CGFloat singleTileLeave = [[dic objectForKey:@"singleTileLeave"] floatValue];
        if (singleTileLeave > 0 && leave <= 0) {
            display = [[NSString alloc] initWithFormat: @"%@However, the single-tile leave score is positive with a value of %.3f.\n", display, singleTileLeave];
        } else if (singleTileLeave < 0 && leave >= 0) {
            display = [[NSString alloc] initWithFormat: @"%@However, the single-tile leave score is negative with a value of %.3f.\n", display, singleTileLeave];
        } else if (singleTileLeave >= 1 && leave >= 1) {
            display = [[NSString alloc] initWithFormat: @"%@Although they differ, the single-tile leave score also demonstrates a positive leave-score a value of %.3f.\n", display, singleTileLeave];
        } else if (singleTileLeave < -3 && leave < -3) {
            display = [[NSString alloc] initWithFormat: @"%@Although they differ, the single-tile leave score also demonstrates a negative leave-score a value of %.3f.\n", display, singleTileLeave];
        } else {
            display = [[NSString alloc] initWithFormat: @"%@Without considering the synergy of the tiles, the individual leave score is: %.3f.\n", display, singleTileLeave];
        }
    }
    
    NSInteger consonants = [[dic objectForKey:@"consonants"] integerValue];
    NSInteger vowels = [[dic objectForKey:@"vowels"] integerValue];
    if (consonants - vowels > 1) {
        display = [[NSString alloc] initWithFormat: @"%@The CV balance in the remaining rack is quite poor having %li consonants but only %li vowel(s)\n", display, consonants, vowels];
    } else if (consonants - vowels < -1) {
        display = [[NSString alloc] initWithFormat: @"%@The CV balance in the remaining rack is quite poor having %li vowels but only %li consonant(s)\n", display, vowels, consonants];
    } else {
        display = [[NSString alloc] initWithFormat: @"%@The CV balance in the remaining rack is within 1 vowel to consonant, which is pretty good!\n", display];
    }
    
    if (![[dic objectForKey:@"maxLetter"] isEqualToString:@""]) {
        display = [[NSString alloc] initWithFormat: @"%@If you do play this word, hopefully you pick a \"%@\" because it is the highest single-tile (besides blank) that will boost your leave score by %@\n", display, [dic objectForKey:@"maxLetter"], [dic objectForKey:@"maxValue"]];
        display = [[NSString alloc] initWithFormat: @"%@Likewise, hopefully you do not pick a \"%@\" because it is the lowest single-tile that will reduce your leave score by %@\n", display, [dic objectForKey:@"maxLetter"], [dic objectForKey:@"maxValue"]];
    }
    
    display = [[NSString alloc] initWithFormat: @"%@With all this information, %@ is ranked as the number %li choice.\n", display, [dic objectForKey:@"mainWord"], indexPath.row + 1];
    
    self.answerDisplay.text = display;
    
    curWord = [dic objectForKey:@"mainWord"];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (curWord != nil) {
        UIReferenceLibraryViewController* ref =
        [[UIReferenceLibraryViewController alloc] initWithTerm:curWord];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIViewController *topView = window.rootViewController;
        [topView presentViewController:ref animated:YES completion:nil];
    }
    return NO;
}

@end


