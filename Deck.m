//
//  Deck.m
//  Blackjack
//
//  Created by Liam on 8/10/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import "Deck.h"

@implementation Deck

@synthesize cards = _cards;

-(id) init
{
    self = [super init];
    if (self) {
        // init all you want
        [self shuffleDeck];
    }
    return self;
}

-(void) shuffleDeck
{
    NSLog(@"shuffing deck!");
    _cards = nil;
    _cards = [[NSMutableArray alloc] init];
    NSArray *suits = [NSArray arrayWithObjects:@"C", @"D", @"S", @"H", nil];
    NSArray *values = [NSArray arrayWithObjects:@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"J", @"Q", @"K", nil];
    for (NSString *suit in suits) {
        for (NSString *value in values) {
            [_cards addObject:[NSString stringWithFormat:@"%@%@", suit, value]];
        }
    }
    NSLog(@"deck shuffled!");
    //NSLog(@"%@", _cards);
}

-(NSString *) dealNewCard
{
    int cardIndex = arc4random() % [_cards count];
    NSString *card = [_cards objectAtIndex:cardIndex];
    [_cards removeObjectAtIndex:cardIndex];
    NSLog(@"Dealing card %@", card);
    return card;
}
@end
