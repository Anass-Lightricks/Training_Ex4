//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Anass Alzurba on 06/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong)NSMutableArray *cards;
@property (nonatomic,strong) Deck* deck;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}



-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        self.deck= deck;
        for (int i=0;i<count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}
-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

#define  MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define COST_TO_CHOOSE  1

static const int DEFAULT_MATCH_MODE =2;

@synthesize matchMode =_matchMode;



- (NSUInteger) matchMode
{
    if(!_matchMode){
        _matchMode = DEFAULT_MATCH_MODE;
    }
    return _matchMode;
}

-(void) setMatchMode:(NSUInteger) matchMode
{
    if(matchMode == 2 || matchMode ==3){
        _matchMode = matchMode;
    }
}

- (Card*) addCard{
    Card *card = [self.deck drawRandomCard];
    if(card){
        [self.cards addObject:card];
    }
    return card;
}

- (void) removeCardAtIndex:(NSUInteger) index{
    [self.cards removeObjectAtIndex:index];
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    NSMutableArray * chosenCards = [[NSMutableArray alloc] init];
    for (Card *otherCard in self.cards){
        if (otherCard.isChosen && !otherCard.isMatched){
            [chosenCards addObject:otherCard];
        }
    }
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            [chosenCards removeObject:card];
        }else{
            //match against other chosen cards
            if([chosenCards count] ==  self.matchMode - 1){
                int matchScore = [card match:chosenCards];
                if(matchScore){
                    self.score += matchScore * MATCH_BONUS;
                    for(Card *otherCard  in chosenCards){
                        otherCard.matched = YES;
                    }
                    card.matched = YES;
                }else{
                    self.score -= MISMATCH_PENALTY;
                    for(Card *otherCard  in chosenCards){
                        otherCard.chosen = NO;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            [chosenCards addObject:card];
        }
    }
    
    
}

@end
