//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 09/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardGameViewController.h"

#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"


@interface SetCardGameViewController ()
@property (weak, nonatomic) IBOutlet UIButton *moreCardsButton;

@end

@implementation SetCardGameViewController

@synthesize cardsCount = _cardsCount;

- (NSUInteger) cardsCount{
    return _cardsCount;
}

-(Deck *)createDeck{
    return [[SetCardDeck alloc]init];
}

-(CardMatchingGame *)createGame{
    self.cardsCount = 12;
    CardMatchingGame* game = [super createGame];
    game.matchMode =3;
    return game;
}

- (CardView*) createCardViewForCard:(Card*) card{
    SetCard * setCard = (SetCard*) card;
    SetCardView* cardView = [[SetCardView alloc]init];
    cardView.shape = setCard.shape;
    cardView.number = setCard.number;
    cardView.color = setCard.color;
    cardView.shading = setCard.shading;
    return cardView;
}

- (void)viewDidLoad {
//    self.cardsCount= 12;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)updateUI
{
    [super updateUI];
    for (CardView *cardView in self.cardViews){
        NSUInteger cardViewIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardViewIndex];
        
         cardView.chosen = card.isChosen;
         cardView.matched = card.isMatched;
         }
    [self removeMatchedFromGame];
//    for (UIButton *cardButton in self.cardViews){
//        NSUInteger cardButtonIndex = [self.cardViews indexOfObject:cardButton];
//        Card *card = [self.game cardAtIndex:cardButtonIndex];
//
//        if (card.isChosen && !card.isMatched){
//            cardButton.layer.borderWidth = 1.5f;
//            cardButton.layer.borderColor = [UIColor blackColor].CGColor;
//            cardButton.layer.cornerRadius = 6.5f;
//        }else
//        {
//            cardButton.layer.borderWidth = 0;
//        }
//    }
}

#define CARDS_TO_ADD_AT_A_TIME 3

- (IBAction)TapMoreCards:(UIButton *)sender {
    NSUInteger oldCount = self.cardsCount;
    self.cardsCount += CARDS_TO_ADD_AT_A_TIME;
    [self setGridBounds];
    for(int i = 0; i<self.cardsCount;i++){
        if(i>=oldCount){
            Card* newCard = [self.game addCard];
            if(newCard){
                [self dealCard:newCard];
            }else{
                self.moreCardsButton.hidden = YES;
                break;
            }
        }
        [self drawCardView:self.cardViews[i] atIndex:i];
    }
}

- (IBAction)touchRedealButton:(UIButton *)sender{
    self.moreCardsButton.hidden = NO;
    [super touchRedealButton:sender];
}


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
