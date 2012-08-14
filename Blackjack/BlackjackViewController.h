//
//  BlackjackViewController.h
//  Blackjack
//
//  Created by Liam on 8/10/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "Hand.h"

@interface BlackjackViewController : UIViewController {
    IBOutlet UILabel *dealerHand;
    IBOutlet UILabel *playerHand;
    IBOutlet UILabel *playerBank;
    IBOutlet UILabel *playerBet;
    IBOutlet UIButton *hitButton;
    IBOutlet UIButton *standButton;
    IBOutlet UIButton *doubleButton;
    IBOutlet UIButton *splitButton;
    IBOutlet UIButton *betButton;
    IBOutlet UIButton *dealButton;
    IBOutlet UILabel *handValueLabel;
}

-(IBAction)addToBet;
-(IBAction)dealHand;
-(IBAction)hit;
-(IBAction)stand;
-(IBAction)doubleDown;
@end
