//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Anass Alzurba on 06/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"


@interface CardMatchingGame : NSObject
// designated initializer
-(instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;

- (Card*) addCard;
-(void)chooseCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;
- (void) removeCardAtIndex:(NSUInteger) index;

@property (nonatomic,readonly) NSInteger score;

@property (nonatomic) NSUInteger matchMode ;

@end


