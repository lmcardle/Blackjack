//
//  BlackjackViewController.m
//  Blackjack
//
//  Created by Liam on 8/10/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import "BlackjackViewController.h"

@interface BlackjackViewController ()
@end

@implementation BlackjackViewController {
    int bet;
    int bank;
    int playerHandValue;
    int dealerHandValue;
    Deck *deck;
    Hand *player;
    Hand *dealer;
    //NSTimer *updateTimer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    deck = [[Deck alloc] init];
    
    //initialize bank
    bank = [[NSUserDefaults standardUserDefaults] integerForKey:@"bank"];
    if (!bank) {
        bank = 1000;
    }
    //updateTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateLabels) userInfo:nil repeats:YES];
    [self resetGame];
    
}

-(IBAction)addToBet {
    NSLog(@"adding to bet");
    bank -= 1;
    bet += 1;
    [self updateLabels];
    [dealButton setEnabled:YES];
}

-(IBAction)dealHand {
    NSLog(@"dealing hand");
    [dealButton setEnabled:NO];
    [betButton setEnabled:NO];
    [hitButton setEnabled:YES];
    [standButton setEnabled:YES];
    [doubleButton setEnabled:YES];
    [splitButton setEnabled:YES];
    [[dealer myHand] addObject:[deck dealNewCard]];
    [[player myHand] addObject:[deck dealNewCard]];
    [[player myHand] addObject:[deck dealNewCard]];
    NSLog(@"dealer's hand is %@", [dealer myHand]);
    NSLog(@"player's hand is %@", [player myHand]);
    playerHandValue = [player valueOfHand];
    [self updateLabels];
    
}


-(void)updateLabels {
    NSLog(@"update label called");
    [playerBank setText:[NSString stringWithFormat:@"%d", bank]];
    [playerBet setText:[NSString stringWithFormat:@"%d", bet]];
    [playerHand setText:[[player myHand] componentsJoinedByString:@" "]];
    [dealerHand setText:[[dealer myHand] componentsJoinedByString:@" "]];
    [handValueLabel setText:[NSString stringWithFormat:@"%d", playerHandValue]];
    
}

-(IBAction)stand {
    [hitButton setEnabled:NO];
    [doubleButton setEnabled:NO];
    [splitButton setEnabled:NO];
    [self updateLabels];
    [self playDealer];
}

-(void)playDealer {
    NSLog(@"Dealer is now playing");
    [[dealer myHand] addObject:[deck dealNewCard]];
    dealerHandValue = [dealer valueOfHand];
    [self updateLabels];
    while ((dealerHandValue < 21) && (dealerHandValue !=0)) {
        NSLog(@"top of while");
        NSLog(@"dealer's hand is %@", [dealer myHand]);
        [self updateLabels];
        sleep(2);
        if (dealerHandValue >16) {
            NSLog(@"hand bigger than 16, breaking");
            [self updateLabels];
            sleep(2);
            break;
        } else {
            NSLog(@"dealing myself new card, %d", dealerHandValue);
            NSString *dealerCard = [deck dealNewCard];
            [[dealer myHand] addObject:dealerCard];
            dealerHandValue = [dealer valueOfHand];
            [self updateLabels];
            sleep(2);
        }
        
    }
    if (dealerHandValue > 21) {
        [self handleBusted:NO];
    }
    if (dealerHandValue > playerHandValue) {
        [self handleEndGame:@"Dealer"];
    } else if (playerHandValue > dealerHandValue) {
        [self handleEndGame:@"Player"];
    } else {
        [self handleEndGame:@"Push"];
    }
    //some condition where we need this
    [self updateLabels];
    
}

-(void)handleEndGame:(NSString *)who {
    NSLog(@"%@ won the game", who);
    sleep(2);
    UIAlertView *endGameAlert;
    if ([who isEqualToString:@"Push"]) {
        endGameAlert = [[UIAlertView alloc] initWithTitle:@"Push!" message:@"Tie!" delegate:nil cancelButtonTitle:@"Reset Game!" otherButtonTitles:nil];
        bank += bet;
    } else {
        endGameAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Won!", who] message:@"Cool!" delegate:nil cancelButtonTitle:@"Reset Game!" otherButtonTitles:nil];
        if ([who isEqualToString:@"Player"]) {
            bank += 2*bet;
        }
    }
    [endGameAlert show];
    [self resetGame];
}

-(void)handleBusted:(BOOL)playerBusted {
    NSLog(@"handling busted");
    UIAlertView *bustedAlert;
    if (playerBusted) {
        bustedAlert = [[UIAlertView alloc] initWithTitle:@"Player Busted!" message:@"Better luck next time!" delegate:nil cancelButtonTitle:@"New Game" otherButtonTitles:nil];
        
    } else {
        bustedAlert = [[UIAlertView alloc] initWithTitle:@"Dealer Busted!" message:@"You Win!" delegate:nil cancelButtonTitle:@"New Game" otherButtonTitles:nil];
        bank += 2*bet;
    }
    [bustedAlert show];
    [self updateLabels];
    [self resetGame];
};

-(void)resetGame {
    NSLog(@"resetGame called");
    [playerBank setText:[NSString stringWithFormat:@"%d", bank]];
    [hitButton setEnabled:NO];
    [standButton setEnabled:NO];
    [doubleButton setEnabled:NO];
    [splitButton setEnabled:NO];
    [dealButton setEnabled:NO];
    bet = 0;
    playerHandValue = 0;
    player = [[Hand alloc] init];
    dealer = [[Hand alloc] init];
    [deck shuffleDeck];
    [betButton setEnabled:YES];
    [self updateLabels];
}

//TODO: hit, stand, double,
-(IBAction)hit {
    [doubleButton setEnabled:NO];
    NSString *hitCard = [deck dealNewCard];
    [[player myHand] addObject:hitCard];
    playerHandValue = [player valueOfHand];
    if (playerHandValue == 0) {
        [self handleBusted:YES];
    }
    [self updateLabels];
}

-(IBAction)doubleDown {
    [[player myHand] addObject:[deck dealNewCard]];
    // NSString *doubleCard = [deck dealNewCard];
    // [[player myHand] addObject:doubleCard];
    playerHandValue = [player valueOfHand];
    bank -= bet;
    bet *=2;
    if (playerHandValue == 0) {
        [self handleBusted:YES];
    }
    [self updateLabels];
    //[self stand];
}

////check value of card
//-(int)valueOfCard:(NSString *)card {
//    NSString *value = [card substringFromIndex:1];
//    if ([value isEqualToString:@"K"] || [value isEqualToString:@"Q"] || [value isEqualToString:@"J"] || [value isEqualToString:@"0"]) {
//        return 10;
//    } else if ([value isEqualToString:@"A"]) {
//        return 11;
//    } else
//        return [value intValue];
//}
//
////check value of hand
//-(void)valueOfHand:(NSMutableArray *)handToValue {
//    playerHandValue = 0;
//    int numAces = 0;
//    int tempValue = 0;
//    for (NSString *card in handToValue) {
//        tempValue = [self valueOfCard:card];
//        if (tempValue == 11) {
//            numAces++;
//        }
//        handValue += tempValue;
//        
//    }
//    while ((handValue > 21) && (numAces > 0)) {
//        numAces--;
//        handValue -= 10;
//        
//    }
//    
//    if (handValue > 21) {
//        handValue = 0;
//        [self handleBusted:YES];
//    }
//}


//play dealer hand
//reset game

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    //[updateTimer invalidate];
    [[NSUserDefaults standardUserDefaults] setInteger:bank forKey:@"bank"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



@end
