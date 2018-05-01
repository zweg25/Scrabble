//
//  TableViewManager.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerCellTableViewCell.h"

@protocol AnswerTableDelegate

- (void) didSelectRow:(NSInteger)rowIndex;

@end

@interface TableViewManager : UIView<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *answers;

@property (strong, nonatomic) UITextView *answerDisplay;

@property (weak, nonatomic) id <AnswerTableDelegate> delegate;

@end
