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

-(CGPoint) movePoint:(CGPoint)point byX:(NSUInteger)x byY: (NSUInteger) y{
    return CGPointMake(point.x+x, point.y+y);
}


#define PINCH_ANIMATION_DURATION 0.5

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    for(int i=0;i<self.cardsCount;i++)
    {
        CardView* cardView = self.cardViews[i];
        [UIView transitionWithView:cardView duration:PINCH_ANIMATION_DURATION options: UIViewAnimationOptionCurveEaseInOut animations:^{
            cardView.center = [self movePoint:self.gridFrame.center byX:i byY:i];
        } completion:^(BOOL fin){
            if(fin){
                [cardView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
                [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCardInStack:)]];
            }
        }
         ];
        
    }
}

 - (IBAction)pan:(UIPanGestureRecognizer *)sender{
     for(int i=0;i<self.cardsCount;i++)
     {
         CardView* cardView = self.cardViews[i];
         cardView.center = [self movePoint:[sender locationInView:self.gridFrame] byX:i byY:i];
         
     }
 }


- (IBAction)tapCardInStack:(UIPanGestureRecognizer *)sender{
    [self reDrawCards];
    for(CardView* cardView in self.cardViews){
        for( UIGestureRecognizer* gesture in cardView.gestureRecognizers)
        {
            if(![gesture isKindOfClass: UIPinchGestureRecognizer.class])
            {
                [cardView removeGestureRecognizer:gesture];
            }
        }
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCardView:)]];
    }
}


-( NSUInteger) defaultCardsCount{
    return 12;
}

- (NSUInteger) cardsCount{
    return _cardsCount;
}

- (CardView *)createCardViewForCard:(Card *)card{
    return nil;
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
    self.grid.minimumNumberOfCells = self.cardsCount;
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
    _cardsCount = [self defaultCardsCount];
    CardMatchingGame *game = [[CardMatchingGame alloc] initWithCardCount:[self cardsCount] usingDeck:[self createDeck]];
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
    _game = [self createGame];
    [self setGridBounds];

    [self dealAndDrawCards];
    
    
}

-(void) dealAndDrawCards{
    for(int i=0; i<[self cardsCount];i++){
        [self drawCardView:[self dealCard:[self.game cardAtIndex:i]] atIndex:i];
    }
}
-(CardView *) dealCard: (Card*)card{
    CardView * cardView = [self createCardViewForCard:card];
    
    [self.gridFrame addSubview:cardView];
    [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(tapCardView:)]];
    [cardView setBackgroundColor:[UIColor clearColor]];
    [self.cardViews addObject:cardView];
    return cardView;
}

-(void)removeAllFromGame{
    for (CardView *cardView in [self.cardViews copy]){
        [self removeFromGameCardView:cardView];
    }
}

-(void)removeMatchedFromGame{
    for (CardView *cardView in [self.cardViews copy]){
        if(cardView.matched){
            cardView.matched = NO;
            [self removeFromGameCardView:cardView];
        }
    }
    [self reDrawCards];
}
#define REMOVE_ANIMATION_DURATION 0.5

-(void)removeFromGameCardView:(CardView*) cardView{
    NSUInteger index = [self.cardViews indexOfObject:cardView];
    [self.game removeCardAtIndex:index];
    [self.cardViews removeObject:cardView];
    [cardView removeGestureRecognizer:[cardView.gestureRecognizers objectAtIndex:0]];
    self.cardsCount--;
    [UIView transitionWithView:cardView duration:REMOVE_ANIMATION_DURATION options: UIViewAnimationOptionCurveEaseInOut animations:^{
        cardView.center = CGPointMake(self.gridFrame.bounds.size.width+ cardView.bounds.size.width, -cardView.bounds.size.height);
    } completion:^(BOOL fin){
        if(fin){
            [cardView removeFromSuperview];
        }
    }
     ];
}


-(void) updateUI
{
self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

#define ADD_ANIMATION_DURATION 0.5

- (void) drawCardView:(CardView*) cardView atIndex:(NSUInteger) i{
    NSUInteger column = i % self.grid.columnCount;
    NSUInteger row = i / self.grid.columnCount;
    
    [UIView transitionWithView:cardView duration:ADD_ANIMATION_DURATION options: UIViewAnimationOptionCurveEaseInOut animations:^{
        [cardView setFrame:[self.grid frameOfCellAtRow:row inColumn:column]];
    } completion:^(BOOL fin){
        if(fin){
            [cardView setNeedsDisplay];
        }
    }
     ];

}

- (IBAction)touchRedealButton:(UIButton *)sender {
    [self removeAllFromGame];
    self.game = [self createGame];
    [self setGridBounds];

    [self dealAndDrawCards];
    [self updateUI];
}

- (void)viewDidLayoutSubviews{
    [self reDrawCards];
}

-(void)reDrawCards{
    [self setGridBounds];
    
    for(int i=0; i<[self.cardViews count];i++){
        [self drawCardView:self.cardViews[i] atIndex:i];
    }
}





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
