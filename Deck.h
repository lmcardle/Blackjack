//
//  Deck.h
//  Blackjack
//
//  Created by Liam on 8/10/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *cards;

-(void) shuffleDeck;
-(NSString *) dealNewCard;

@end
