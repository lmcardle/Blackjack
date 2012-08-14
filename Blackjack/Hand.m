//
//  Hand.m
//  Blackjack
//
//  Created by Liam on 8/10/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import "Hand.h"

@implementation Hand {
    int handValue;
}
@synthesize myHand = _myHand;

-(id)init {
    self =[super init];
    if (self) {
        _myHand = [[NSMutableArray alloc] init];
    }
    return self;
}

//check value of card
-(int)valueOfCard:(NSString *)card {
    NSString *value = [card substringFromIndex:1];
    if ([value isEqualToString:@"K"] || [value isEqualToString:@"Q"] || [value isEqualToString:@"J"] || [value isEqualToString:@"0"]) {
        return 10;
    } else if ([value isEqualToString:@"A"]) {
        return 11;
    } else
        return [value intValue];
}


//check value of hand
-(int)valueOfHand {
    handValue = 0;
    int numAces = 0;
    int tempValue = 0;
    for (NSString *card in [self myHand]) {
        tempValue = [self valueOfCard:card];
        if (tempValue == 11) {
            numAces++;
        }
        handValue += tempValue;
        
    }
    while ((handValue > 21) && (numAces > 0)) {
        numAces--;
        handValue -= 10;
        
    }
    
    if (handValue > 21) {
        handValue = 0;
    }
    return handValue;
}
@end
