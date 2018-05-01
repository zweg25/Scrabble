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

@implementation ViewController {
    NSInteger preset;
}

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
    self.tileBag = [[Bag alloc] initWithFrame: CGRectMake(x, y, width, height) inViewController:self];
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
                                        self.view.frame.size.width - 2*padding,
                                        self.view.frame.size.height - tableViewY - 80 - padding)];
    self.tableViewManager.delegate = self;
    [self.view addSubview:self.tableViewManager];
    
    // Set up calculate button
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.calculateButton setBackgroundColor:[UIColor greenColor]];
    [self.calculateButton addTarget:self
                             action:@selector(calculatePressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    [self.calculateButton setTitle:@"Calculate!" forState:UIControlStateNormal];
    [self.calculateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.calculateButton.frame = CGRectMake(0, self.view.frame.size.height - 60 - 20, 180, 60);
    [self.calculateButton setCenter:CGPointMake(self.view.center.x, self.calculateButton.center.y)];
    [self.view addSubview:self.calculateButton];
    
    // Move bag to front of view
    [self.view bringSubviewToFront:self.tileBag];
    
    // Saved State
    self.savedState = [[NSMutableDictionary alloc] init];
    
    // UIActivityIndicator on Calculate button
    self.loadingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.calculateButton.bounds.size.height, self.calculateButton.bounds.size.height)];
    self.loadingWheel.center = CGPointMake(
                                           self.calculateButton.bounds.size.width / 2,
                                           self.calculateButton.bounds.size.height / 2);
    self.loadingWheel.backgroundColor = [UIColor clearColor];
    [self.loadingWheel setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.loadingWheel startAnimating];
    [self.calculateButton addSubview:self.loadingWheel];
    [self.loadingWheel setHidesWhenStopped:YES];
    [self.loadingWheel stopAnimating];
    [self.loadingWheel setColor:[UIColor blackColor]];
    
    UIButton *setBoard = [UIButton buttonWithType:UIButtonTypeCustom];
    [setBoard setBackgroundColor:[UIColor clearColor]];
    [setBoard addTarget:self action:@selector(setBoardMethod:)
                   forControlEvents:UIControlEventTouchUpInside];
    [setBoard setTitle:@"Preset" forState:UIControlStateNormal];
    [setBoard setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [setBoard setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [setBoard setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    setBoard.frame = CGRectMake(0, self.view.frame.size.height - 60, 60, 60);
    [self.view addSubview:setBoard];
    
    // Keep at -1 for preset button
    preset = -1;
}

- (IBAction)setBoardMethod:(id)sender {
    preset = (preset + 1) % 3;
    NSString *rack1 = @"i,g,u,a,n,a,a";
    NSString *board1 = @",,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,R,O,U,N,D,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,";
    NSString *rack2 = @"d,o,p,p,r,t,w";
    NSString *board2 = @",,,,,,,,,L,A,Z,I,E,R\n\
                        ,,,,,,,,,,,O,,,\n\
                        ,,,,,,,,,,,U,,,\n\
                        ,,,,,,,,,,,K,,,\n\
                        ,,,,,,,,,T,I,S,,,J\n\
                        ,,,,,,,,,W,,,,,O\n\
                        ,,,,,,,,,E,,,,,C\n\
                        ,,,,,,,G,L,E,E,T,,,U\n\
                        ,,,,,,,,,N,,,,,N\n\
                        ,,,,,,,E,L,Y,T,R,O,I,D\n\
                        ,,B,R,E,V,E,T,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,";
    NSString *rack3 = @"a,e,i,i,i,n,t";
    NSString *board3 = @",,,,,,,,,,,,,,\n\
                        ,,,,,,,,,U,,,,,\n\
                        ,,,,,,,,,R,,,,,\n\
                        ,,,,,,,,F,A,K,E,D,,\n\
                        ,,,,,I,G,U,A,N,A,,,,\n\
                        ,,,,,,,,,Y,,,,,\n\
                        ,,,,,,,W,,L,,,,,\n\
                        ,,,,L,O,O,I,E,S,,,,,\n\
                        ,,,,,,,Z,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,\n\
                        ,,,,,,,,,,,,,,";
    
    NSArray *presetRacks = [[NSArray alloc] initWithObjects:rack1, rack2, rack3, nil];
    NSArray *presetBoards = [[NSArray alloc] initWithObjects:board1, board2, board3, nil];
    NSString *rack = [presetRacks objectAtIndex:preset];
    NSString *board = [presetBoards objectAtIndex:preset];
    for (UIView *subview in self.board.subviews) {
        if ([subview isKindOfClass:TextTile.class]) {
            [subview removeFromSuperview];
        }
    }
    for (UIView *subview in self.rack.subviews) {
        if ([subview isKindOfClass:TextTile.class]) {
            [subview removeFromSuperview];
        }
    }
    NSMutableArray *newBoard = [[NSMutableArray alloc] init];
    NSArray *rows = [board componentsSeparatedByString:@"\n"];
    for (int r = 0; r < self.board.board.count; r++) {
        NSString *row = [rows objectAtIndex:r];
        NSArray *rowArray = [row componentsSeparatedByString:@","];
        NSMutableArray *newRow = [[NSMutableArray alloc] init];
        for (int c = 0; c < rowArray.count; c++) {
            NSString *letter = [[rowArray objectAtIndex:c] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            BoardTile *bt = [[self.board.board objectAtIndex:r] objectAtIndex:c];
            if (![letter isEqualToString:@""]) {
                bt.letter = letter;
                bt.isUsed = true;
                TextTile *tt = [[TextTile alloc] initWithFrame:bt.frame letter:letter clonable:false];
                tt.delegate = self;
                tt.origSize = CGSizeMake(self.tileBag.tileSize, self.tileBag.tileSize);
                [self.board addSubview:tt];
            } else {
                bt.letter = @"";
                bt.isUsed = false;
            }
            [newRow addObject:bt];
        }
        [newBoard addObject:newRow];
    }
    self.board.board = newBoard;
    
    self.rack.letters = [[[rack uppercaseString] componentsSeparatedByString:@","] mutableCopy];
    [self.rack resetPositions];
    for (NSString *letter in self.rack.letters) {
        TextTile *tt = [[TextTile alloc] initWithFrame:CGRectMake(0, 0, self.tileBag.tileSize, self.tileBag.tileSize) letter:letter clonable:false];
        tt.delegate = self;
        CGPoint pos = [[self.rack.positions firstObject] CGPointValue];
        [self.rack.positions removeObjectAtIndex:0];
        tt.center = pos;
        [self.rack addSubview:tt];
    }
}

- (IBAction)calculatePressed:(id)sender {
    if (self.rack.letters.count > 0 && self.loadingWheel.isHidden) {
        [self queryScores];
    }
}

- (void) queryScores {
    // New calculation, makes saved state permanent
    [self.savedState removeAllObjects];
    [self.tableViewManager.answers removeAllObjects];
    [self.tableViewManager.tableView reloadData];
    [self.loadingWheel startAnimating];
    [self.loadingWheel setHidden:NO];
    [self.calculateButton setTitle:@"" forState:UIControlStateNormal];
    
    // @"http://www.scrabblecheatboard.com"
    STHTTPRequest *r = [STHTTPRequest requestWithURLString:@"https://www.appitt.com/scrabble/scrabbleGetter.php"];
    
    //self.rack.letters = [[NSMutableArray alloc] initWithObjects:@"l", @"e", @"t", @"t", @"e", @"r", @"s", nil];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                @"WWF", @"lexicon",
                                @"Scrabble", @"layout",
                                @"", @"board_name",
                                @"", @"board_id",
                                [[self.rack.letters componentsJoinedByString:@""] lowercaseString], @"rack",
                                nil];
    
    for (int r = 0; r < self.board.board.count; r++) {
        NSArray *rowArray = [self.board.board objectAtIndex:r];
        for (int c = 0; c < rowArray.count; c++) {
            NSString *key = [[NSString alloc] initWithFormat:@"board_%i_%i", r, c];
            BoardTile *boardTile = [rowArray objectAtIndex:c];
            NSString *let = boardTile.letter;
            if ([let isEqualToString:@"blank"]) {
                let = @" ";
            } else if (![let isEqualToString:@""]) {
                let = [let lowercaseString];
            }
            [dic setObject:let forKey:key];
        }
    }
    
    r.POSTDictionary = dic;
    
    r.completionBlock = ^(NSDictionary *headers, NSString *body) {
        [self.tableViewManager.answers removeAllObjects];
        NSArray *rows = [body componentsSeparatedByString:@"\n"];
        for (int i = 0; i < rows.count - 1; i++) {
            NSArray *cols = [rows[i] componentsSeparatedByString:@","];
            NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:
                               cols[0], @"score",
                               cols[1], @"mainWord",
                               cols[2], @"row",
                               cols[3], @"col",
                               cols[4], @"direction",
                               cols[5], @"rack",
                               cols[6], @"leave",
                               cols[7], @"vowels",
                               cols[8], @"consonants",
                               cols[9], @"maxLetter",
                               cols[10], @"maxValue",
                               cols[11], @"minLetter",
                               cols[12], @"minValue",
                               cols[13], @"singleTileLeave",
                               cols[14], @"totalValue",
                               nil];
            NSDictionary *prevDic = [self.tableViewManager.answers lastObject];
            if (!(prevDic
                  && [[prevDic objectForKey:@"score"] isEqualToString:[d objectForKey:@"score"]]
                  && [[prevDic objectForKey:@"mainWord"] isEqualToString:[d objectForKey:@"mainWord"]])) {
                [self.tableViewManager.answers addObject:d];
            }
        }
        // Sort array by total value
        NSArray *sortedArray = [self.tableViewManager.answers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            CGFloat data1 = [[obj1 valueForKey:@"totalValue"] floatValue];
            CGFloat data2 = [[obj2 valueForKey:@"totalValue"] floatValue];
            if (data1 < data2) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if (data1 > data2) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        self.tableViewManager.answers = [sortedArray mutableCopy];
        
        [self.tableViewManager.tableView reloadData];
        
        [self.loadingWheel stopAnimating];
        [self.calculateButton setTitle:@"Calculate!" forState:UIControlStateNormal];
    };
    
    r.errorBlock = ^(NSError *error) {
        NSLog(@"Error: %@", error.description);
        
        [self.loadingWheel stopAnimating];
        [self.calculateButton setTitle:@"Calculate!" forState:UIControlStateNormal];
    };
    
    [r startAsynchronous];
}

- (void) tileTouched:(TextTile *)textTile touch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self.view];
    
    if ([textTile.superview isEqual:self.board]) {
        NSInteger row = floor(textTile.frame.origin.y / self.board.tileSize);
        NSInteger col = floor(textTile.frame.origin.x / self.board.tileSize);
        BoardTile *bt = [[self.board.board objectAtIndex:row] objectAtIndex:col];
        bt.letter = @"";
        bt.isUsed = false;
    } else if ([textTile.superview isEqual:self.rack]) {
        [self.rack.positions addObject:[NSValue valueWithCGPoint:textTile.center]];
        // Remove first occurance of letter in rack
        NSInteger index = [self.rack.letters indexOfObject:textTile.letter];
        [self.rack.letters removeObjectAtIndex:index];
    }
    textTile.center = location;
    [self.view addSubview:textTile];
    [self.view bringSubviewToFront:textTile];
}

- (void) tileReleased:(TextTile *)textTile touch:(UITouch *)touch {
    CGPoint location = [touch locationInView:self.view];
    
    [textTile removeFromSuperview];
    
    if (CGRectContainsPoint(self.board.frame, location)) {
        CGPoint boardLocation = [touch locationInView:self.board];
        // Approx location
        NSInteger row = floor(boardLocation.y / self.board.tileSize);
        NSInteger col = floor(boardLocation.x / self.board.tileSize);
        BoardTile *hoveredBt = [[self.board.board objectAtIndex:row] objectAtIndex:col];
        if (hoveredBt.isUsed) {
            double nearestDist = -1;
            // Loop for exact
            for (int r = 0; r < self.board.board.count; r++) {
                NSArray *rowArray = [self.board.board firstObject];
                for (int c = 0; c < rowArray.count; c++) {
                    BoardTile *bt = [[self.board.board objectAtIndex:r] objectAtIndex:c];
                    double dx = (boardLocation.x-bt.frame.origin.x);
                    double dy = (boardLocation.y-bt.frame.origin.y);
                    double dist = dx*dx + dy*dy;
                    if ((nearestDist == -1 || nearestDist > dist) && !bt.isUsed) {
                        nearestDist = dist;
                        row = r;
                        col = c;
                    }
                }
            }
        }
        BoardTile *bt = [[self.board.board objectAtIndex:row] objectAtIndex:col];
        textTile.frame = bt.frame;
        textTile.imgView.frame = bt.bounds;
        bt.letter = textTile.letter;
        bt.isUsed = true;
        [self.board addSubview:textTile];
        //NSLog(@"In board");
    } else if (CGRectContainsPoint(self.rack.frame, location) && self.rack.positions.count > 0) {
        CGPoint rackLocation = [touch locationInView:self.rack];
        CGPoint closestPos = [[self.rack.positions firstObject] CGPointValue];
        
        for (NSValue *val in self.rack.positions) {
            CGPoint pos = [val CGPointValue];
            if (fabs(pos.x - rackLocation.x) < fabs(closestPos.x - rackLocation.x)) {
                closestPos = pos;
            }
        }
        textTile.center = closestPos;
        [self.rack.positions removeObject:[NSValue valueWithCGPoint: closestPos]];
        [self.rack.letters addObject:textTile.letter];
        [self.rack addSubview:textTile];
        //NSLog(@"In rack");
    } else {
        //NSLog(@"In nowhere");
    }
    NSLog(@"%@", self.rack.letters);
}

- (void) didSelectRow:(NSInteger)rowIndex {
    NSDictionary *rowDic = [self.tableViewManager.answers objectAtIndex:rowIndex];
    NSString *rackLetters = [rowDic objectForKey:@"rack"];
    
    if (self.savedState.count == 0) {
        NSMutableArray *board = [[NSMutableArray alloc] initWithArray:self.board.board copyItems:YES];
        NSMutableArray *rack  = [[NSMutableArray alloc] initWithArray:self.rack.letters copyItems:YES];
        NSMutableArray *pos   = [[NSMutableArray alloc] initWithArray:self.rack.positions copyItems:YES];
        [self.savedState setObject:board forKey:@"board"];
        [self.savedState setObject:rack forKey:@"rack"];
        [self.savedState setObject:pos forKey:@"positions"];
    } else {
        self.board.board = [self.savedState objectForKey:@"board"];
        self.rack.letters = [self.savedState objectForKey:@"rack"];
        self.rack.positions = [self.savedState objectForKey:@"positions"];
        
        // Remove all added tiles on board
        NSArray *subviews = [self.savedState objectForKey:@"subviews"];
        for (UIView *view in subviews) {
            CGPoint loc = view.frame.origin;
            NSInteger row = floor(loc.y / self.board.tileSize);
            NSInteger col = floor(loc.x / self.board.tileSize);
            BoardTile *bt = [[self.board.board objectAtIndex:row] objectAtIndex:col];
            bt.isUsed = false;
            bt.letter = @"";
            [view removeFromSuperview];
        }
    }
    
    // Remove all letters left on rack
    for (UIView *view in [self.rack subviews]) {
        if ([view isKindOfClass:TextTile.class]) {
            // Add available position
            [self.rack.positions addObject:[NSValue valueWithCGPoint:view.center]];
            [view removeFromSuperview];
        }
    }
    
    // Re-add all letters on rack
    [self.rack.letters removeAllObjects];
    [self.rack resetPositions];
    for (int i = 0; i < rackLetters.length; i++) {
        NSString *letter = [[rackLetters substringWithRange:NSMakeRange(i, 1)] uppercaseString];
        [self.rack.letters addObject:letter];
        
        CGPoint position = [[self.rack.positions firstObject] CGPointValue];
        [self.rack.positions removeObjectAtIndex:0];
        
        TextTile *textTile = [[TextTile alloc] initWithFrame:CGRectMake(0, 0, self.tileBag.tileSize, self.tileBag.tileSize) letter:letter clonable:false];
        textTile.center = position;
        textTile.delegate = self;
        [self.rack addSubview:textTile];
    }
    
    // Add new word to board
    NSMutableArray *subviews = [[NSMutableArray alloc] init];
    NSInteger row = [[rowDic objectForKey:@"row"] integerValue];
    NSInteger col = [[rowDic objectForKey:@"col"] integerValue];
    NSString *word = [rowDic objectForKey:@"mainWord"];
    NSString *direction = [rowDic objectForKey:@"direction"];
    
    while ([word length] > 0) {
        NSString *firstChar = [[word substringToIndex:1] uppercaseString];
        word = [word substringFromIndex:1];
        BoardTile *bt = [[self.board.board objectAtIndex:row] objectAtIndex:col];
        if (!bt.isUsed) {
            bt.isUsed = true;
            bt.letter = firstChar;
            TextTile *textTile = [[TextTile alloc] initWithFrame:bt.frame letter:firstChar clonable:false];
            textTile.delegate = self;
            textTile.origSize = CGSizeMake(self.tileBag.tileSize, self.tileBag.tileSize);
            [self.board addSubview:textTile];
            [subviews addObject:textTile];
        }
        
        if ([direction isEqualToString:@"down"]) {
            row++;
        } else {
            col++;
        }
    }
    
    [self.savedState setObject:subviews forKey:@"subviews"];
    [self printBoardUsed];
}

- (void) printBoardUsed {
    NSLog(@"\nBOARD USED:\n");
    for (int row = 0; row < self.board.board.count; row++) {
        NSArray *rA = [self.board.board objectAtIndex:row];
        for (int col = 0; col < rA.count; col++) {
            BoardTile *bt = [[self.board.board objectAtIndex:row] objectAtIndex:col];
            if (bt.isUsed) {
                NSLog(@"row: %i, col %i, pair: %li %li, letter: %@", row, col, bt.position.row, bt.position.col, bt.letter);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
