//
//  TableViewManager.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnswerCellTableViewCell.h"

@interface TableViewManager : UIView<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *answers;

@end
