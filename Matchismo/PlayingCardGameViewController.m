//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 09/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "PlayingCardGameViewController.h"

#import <UIKit/UIKit.h>

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController



- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame *)createGame{
    CardMatchingGame* game = [super createGame];
    game.matchMode =2;
    return game;
}

- (CardView*) createCardViewForCard:(Card*) card{
    PlayingCard * playingCard = (PlayingCard *) card;
    PlayingCardView * cardView = [[PlayingCardView alloc] init];
    cardView.rank = playingCard.rank;
    cardView.suit = playingCard.suit;
    return cardView;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
