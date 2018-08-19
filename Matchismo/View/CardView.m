//
//  CardView.m
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "CardView.h"

@implementation CardView


- (void)setChosen:(BOOL)chosen {
    _chosen = chosen;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat) cornerScaleFactor {return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat) cornerRaduis { return CORNER_RADIUS * [self cornerScaleFactor];}
- (CGFloat) cornerOffset {return [self cornerRaduis] / 3.0; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRaduis]];
    [roundedRect addClip];
    
    [[UIColor whiteColor]setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}


@end
