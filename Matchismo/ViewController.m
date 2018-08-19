//
//  ViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "ViewController.h"

#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation ViewController
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playingCardView.chosen = !self.playingCardView.chosen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playingCardView.suit = @"♥️";
    self.playingCardView.rank = 13;
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)]];
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
