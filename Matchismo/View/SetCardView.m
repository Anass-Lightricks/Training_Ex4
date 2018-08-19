//
//  SetCardView.m
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView


- (void)setShape:(NSString *)shape{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setNumber:(NSUInteger)number{
    _number = number;
    [self setNeedsDisplay];
}

- (void)setColor:(UIColor *)color{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShading:(CGFloat)shading{
    _shading = shading;
    [self setNeedsDisplay];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
@end
