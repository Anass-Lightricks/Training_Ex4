//
//  ViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 02/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"
#import "View/CardView.h"
#import "Grid.h"

@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) Grid* grid;
@property (weak, nonatomic) IBOutlet UIView *gridFrame;

@end


@implementation CardGameViewController

+(NSUInteger) cardsCount{
    return 12;
}

-(NSMutableArray*) cardViews{
    if(!_cardViews){
        _cardViews = [[NSMutableArray alloc]init];
    }
    return _cardViews;
}


- (void) setGridBounds{
    self.grid.size = self.gridFrame.bounds.size;
    self.grid.cellAspectRatio =  64.0/96.0;
    self.grid.minimumNumberOfCells = [CardGameViewController cardsCount];
}

- (Grid *)grid{
    if(!_grid){
        _grid = [[Grid alloc] init];
    }
    return _grid;
}

-(CardMatchingGame *) game
{
    if (!_game) _game = [self createGame];
    return _game;
}

-(CardMatchingGame *) createGame
{
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:[CardGameViewController cardsCount] usingDeck:[self createDeck]];
    return game;
}


- (Deck *)createDeck
{
    return nil;
}
- (IBAction)tapCardView:(UITapGestureRecognizer *)sender {
    if(![sender.view isKindOfClass:CardView.class]) return;
    
    NSUInteger chosenViewIndex = [self.cardViews indexOfObject:sender.view];
    
    [self.game chooseCardAtIndex:chosenViewIndex];
    [self updateUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGridBounds];
    
    
    [self updateUI];
}



-(void)updateUI
{
    for (CardView *cardView in self.cardViews){
        NSUInteger cardViewIndex = [self.cardViews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardViewIndex];
        
        cardView.chosen = card.isChosen;
        cardView.hidden = card.isMatched;
        

    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
//    [self.view setNeedsLayout];
//    if(self.game.matchMode==2)
//    {
//        [self.matchModeSwitch setSelectedSegmentIndex:0];
//    }else{
//        [self.matchModeSwitch setSelectedSegmentIndex:1];
//    }
}



- (void) drawCardView:(CardView*) cardView atIndex:(NSUInteger) i{
    NSUInteger column = i / self.grid.rowCount;
    NSUInteger row = i % self.grid.rowCount;
    [cardView setFrame:[self.grid frameOfCellAtRow:row inColumn:column]];

    [cardView setBackgroundColor:[UIColor clearColor]];
    [self.gridFrame addSubview:cardView];
    [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapCardView:)]];
//    [cardView setUserInteractionEnabled:YES];
    [self.cardViews addObject:cardView];
//    [cardView setNeedsDisplay];
}

- (IBAction)touchRedealButton:(UIButton *)sender {
    self.game = [self createGame];
    [self updateUI];
}
//- (IBAction)TouchMatchModeControl:(UISegmentedControl *)sender {
//    if(sender.selectedSegmentIndex ==0)
//    {
//        [self.game setMatchMode:2];
//    }else{
//        [self.game setMatchMode:3];
//    }
//}




// #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController]
//     if([segue.identifier isEqualToString:self.historySegueIdentifier]){
//         HistoryViewController* dest = (HistoryViewController*)[segue destinationViewController];
//         dest.history = self.history;
//     }
// // Pass the selected object to the new view controller.
// }



@end
