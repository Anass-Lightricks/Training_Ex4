//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString* suit;


- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
