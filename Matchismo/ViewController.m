//
//  ViewController.m
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "ViewController.h"

#import "SetCardView.h"
#import "SetCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end

@implementation ViewController
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.setCardView.chosen = !self.setCardView.chosen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.setCardView.shape = 2;
    self.setCardView.number = 3;
    self.setCardView.color = [SetCard validColors][0];
    self.setCardView.shading = 1;
    
//    [self.setCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.setCardView action:@selector(pinch:)]];
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
