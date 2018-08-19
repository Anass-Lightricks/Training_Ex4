//
//  SetCardView.h
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CardView.h"

@interface SetCardView : CardView


@property (strong,nonatomic) NSString* shape;
@property (nonatomic) NSUInteger  number;
@property (strong, nonatomic) UIColor* color;
@property (nonatomic) CGFloat shading;


@end
