//
//  TableViewManager.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "TableViewManager.h"

@implementation TableViewManager 

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:0.9];
        [self addSubview:self.tableView];
    }
    return self;
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;//self.answers.count;
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
        NSInteger score = [[answerDictionary objectForKey:@"score"] integerValue];
        cell.scoreLabel.text = [[NSString alloc] initWithFormat:@"%ld", score];
        cell.answerLabel.text = [answerDictionary objectForKey:@"mainWord"];
    }
    cell.scoreLabel.text = @"21";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

@end


