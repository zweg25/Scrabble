//
//  ViewController.m
//  Scrabble
//
//  Created by Zak Wegweiser on 4/18/18.
//  Copyright © 2018 Zak Wegweiser. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat padding = 10;
    
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat size =  0.75;
    // Set up board
    self.board = [[Board alloc] initWithFrame:
                  CGRectMake(padding, padding + 10,
                             self.view.frame.size.width * size, self.view.frame.size.width * size)];
    [self.board setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.2 alpha:0.5]];
    [self.view addSubview:self.board];
    
    // Set up dictionary
    self.dictionary = [[Dictionary alloc] initWithFile:@"scrabble_dic"];
    
    // Set up bag
    CGFloat x = self.board.frame.origin.x + self.board.frame.size.width + padding/2;
    CGFloat y = self.board.frame.origin.y + 2*padding;
    CGFloat width = self.view.frame.size.width - self.board.frame.size.width - padding;
    CGFloat height = self.board.frame.size.height - 2*padding;
    self.tileBag = [[Bag alloc] initWithFrame: CGRectMake(x, y, width, height)];
    [self.view addSubview:self.tileBag];
    
    // Set up rack
    CGRect rackFrame = CGRectMake(
                                  self.board.frame.origin.x + padding,
                                  y + height + padding,
                                  self.view.frame.size.width - 4*padding,
                                  self.tileBag.tileSize * 1.5);
    self.rack = [[Rack alloc] initWithFrame:rackFrame
                                    letters:[[NSArray alloc] init]
                                   tileSize: self.tileBag.tileSize];
    [self.view addSubview:self.rack];
    
    // Set up answer tableView
    CGFloat tableViewY = rackFrame.origin.y + rackFrame.size.height + 4 * padding;
    self.tableViewManager = [[TableViewManager alloc] initWithFrame:
                             CGRectMake(rackFrame.origin.x,
                                        tableViewY,
                                        self.view.frame.size.width/2 - padding,
                                        self.view.frame.size.height - tableViewY - 80 - padding)];
    [self.view addSubview:self.tableViewManager];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
