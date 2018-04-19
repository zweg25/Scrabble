//
//  AnswerCellTableViewCell.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/19/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* answerLabel;
@property (nonatomic, weak) IBOutlet UILabel* scoreLabel;

@end
