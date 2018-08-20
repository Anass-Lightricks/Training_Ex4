//
//  CardView.h
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic,getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;



//protected
- (CGFloat) cornerScaleFactor;
- (CGFloat) cornerRaduis;
- (CGFloat) cornerOffset;


@end
