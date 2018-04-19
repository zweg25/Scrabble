//
//  ViewController.h
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "Dictionary.h"
#import "Bag.h"
#import "TextTile.h"
#import "Rack.h"
#import "TableViewManager.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) Board *board;
@property (strong, nonatomic) Dictionary *dictionary;
@property (strong, nonatomic) Bag *tileBag;
@property (strong, nonatomic) Rack *rack;
@property (strong, nonatomic) TableViewManager *tableViewManager;

@end

