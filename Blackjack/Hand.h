//
//  Hand.h
//  Blackjack
//
//  Created by Liam on 8/10/12.
//  Copyright (c) 2012 Liam McArdle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hand : NSObject {
}
@property (nonatomic,strong) NSMutableArray *myHand;
-(int)valueOfHand;
@end
