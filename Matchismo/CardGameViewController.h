//
//  ViewController.h
//  Matchismo
//
//  Created by Anass Alzurba on 02/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardMatchingGame.h"
#import "CardView.h"

@interface CardGameViewController : UIViewController


@property (strong,nonatomic) NSMutableArray* cardViews;

//abstract
- (Deck *)createDeck;

-(void)updateUI;

//protected
- (void) setGridBounds;

-(void) removeMatchedFromGame;

@property (nonatomic) NSUInteger cardsCount;

-(CardView *) dealCard: (Card*)card;

- (void) drawCardView:(CardView*) cardView atIndex:(NSUInteger) i;

- (CardView*) createCardViewForCard:(Card*) card;

@property (strong,nonatomic) CardMatchingGame *game;

- (IBAction)touchRedealButton:(UIButton *)sender;



-(CardMatchingGame *) createGame;

@end

