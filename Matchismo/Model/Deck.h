//
//  Deck.h
//  Matchismo
//
//  Created by Anass Alzurba on 05/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *) drawRandomCard;
@end
