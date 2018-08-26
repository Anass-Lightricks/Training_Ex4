//
//  SetCardView.m
//  Matchismo
//
//  Created by Anass Alzurba on 15/08/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#define SQUIGGLE 0
#define DIAMOND 1
#define OVAL 2

#define EMPTY  0
#define STRIPED  1
#define FILLED  2

- (void)setShape:(NSUInteger)shape{
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

- (void)setShading:(NSUInteger)shading{
    _shading = shading;
    [self setNeedsDisplay];
}



- (CGFloat) center:(CGFloat) length in:(CGFloat)totalLength{
    return (totalLength -length)/2.0;
}


 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
     [super drawRect:rect];
     
     for(NSValue* rectValue in [self make:self.number RectsInRect:rect]){
         CGRect rect = [rectValue CGRectValue];
         UIBezierPath* path = [self drawShape:self.shape InRect:rect];
         [self drawShading:self.shading withColor:self.color inPath:path];
         
         [self.color setStroke];
         [path stroke];
     }
     
     if(self.isChosen){
        UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRaduis]];
//         roundedRect.lineWidth = rect.size.width / 15.0;
         roundedRect.lineWidth = 5;
        [[UIColor blackColor] setStroke];
        [roundedRect stroke];
     }
 }

#define DISTANCE_BETWEEN_STRIPES 4

-(void)drawShading:(NSUInteger)shading withColor:(UIColor *)color inPath:(UIBezierPath *)beziePath
{
    switch (shading){
        case STRIPED:
        {
            [color setStroke];
            [self drawStripedShadingForPath:beziePath];
            break;
        }
        case FILLED:
        {
            [color setFill];
            [beziePath fill];
            break;
        }
        default:
            break;
    }
}

-(void)drawStripedShadingForPath:(UIBezierPath *)pathOfSymbol
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGRect bounds = [pathOfSymbol bounds];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    for (int i = 0; i < bounds.size.width; i += DISTANCE_BETWEEN_STRIPES)
    {
        [path moveToPoint:CGPointMake(bounds.origin.x + i, bounds.origin.y)];
        [path addLineToPoint:CGPointMake(bounds.origin.x + i, bounds.origin.y + bounds.size.height)];
    }
    
    [pathOfSymbol addClip];
    
    [path stroke];
    
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}


-(NSArray *)make:(NSUInteger) rectsCount RectsInRect:(CGRect) rect{
    NSMutableArray* rects = [[NSMutableArray alloc]initWithCapacity:rectsCount];
    
    CGFloat width = rect.size.width /2.0;
    CGFloat height = rect.size.height/6.0;
    
    CGFloat padding = rect.size.height/12.0;
    
    CGFloat x = [self center:width in:rect.size.width];
    
    switch (rectsCount){
        case 1:
        {
            CGFloat y1 = [self center:height in:rect.size.height];
            [rects addObject:[NSValue valueWithCGRect: CGRectMake(x, y1, width, height)]];
            break;
        }
        case 2:
        {
            CGFloat y1 = [self center:2*height + padding in:rect.size.height];
            CGFloat y2 = y1 + height + padding;
            [rects addObject:[NSValue valueWithCGRect: CGRectMake(x, y1, width, height)]];
            [rects addObject:[NSValue valueWithCGRect: CGRectMake(x, y2, width, height)]];
            break;
        }
        case 3:
        {
            CGFloat y1 = [self center:3*height + 2*padding in:rect.size.height];
            CGFloat y2 = y1 + height + padding;
            CGFloat y3 = y2 + height + padding;
            
            [rects addObject:[NSValue valueWithCGRect: CGRectMake(x, y1, width, height)]];
            [rects addObject:[NSValue valueWithCGRect: CGRectMake(x, y2, width, height)]];
            [rects addObject:[NSValue valueWithCGRect: CGRectMake(x, y3, width, height)]];
            break;
        }
        default:
            break;
    }
    return rects;
}

- (UIBezierPath *)drawShape:(NSUInteger) shape InRect:(CGRect)rect{
    switch (shape) {
        case SQUIGGLE:
            return [self drawSquiggleInRect:rect];
        case DIAMOND:
            return [self drawDiamondInRect:rect];
        case OVAL:
            return [self drawOvalInRect:rect];
        default:
            return nil;
    }

}

- (UIBezierPath *)drawOvalInRect:(CGRect) rect{
    return [UIBezierPath bezierPathWithOvalInRect:rect];
}

- (UIBezierPath *)drawSquiggleInRect:(CGRect) rect{
    return [self drawSquiggleAtPoint: CGPointMake(rect.origin.x + rect.size.width/2.0, rect.origin.y + rect.size.height/2.0)];
}

- (UIBezierPath *)drawDiamondInRect:(CGRect) rect{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(rect.origin.x+ 0, rect.origin.y+ rect.size.height/2.0)];
    [path addLineToPoint:CGPointMake(rect.origin.x+ rect.size.width/2.0,rect.origin.y+ 0)];
    [path addLineToPoint:CGPointMake(rect.origin.x+ rect.size.width,rect.origin.y+ rect.size.height/2.0)];
    [path addLineToPoint:CGPointMake(rect.origin.x+ rect.size.width/2.0,rect.origin.y+ rect.size.height)];
    [path closePath];
    return path;
}


#define SYMBOL_WIDTH_RATIO 0.5
#define SYMBOL_HEIGHT_RATIO 0.17

- (UIBezierPath *)drawSquiggleAtPoint:(CGPoint)point
{
    CGSize size = CGSizeMake(self.bounds.size.width * SYMBOL_WIDTH_RATIO, self.bounds.size.height * SYMBOL_HEIGHT_RATIO);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(104, 15)];
    [path addCurveToPoint:CGPointMake(63, 54) controlPoint1:CGPointMake(112.4, 36.9) controlPoint2:CGPointMake(89.7, 60.8)];
    [path addCurveToPoint:CGPointMake(27, 53) controlPoint1:CGPointMake(52.3, 51.3) controlPoint2:CGPointMake(42.2, 42)];
    [path addCurveToPoint:CGPointMake(5, 40) controlPoint1:CGPointMake(9.6, 65.6) controlPoint2:CGPointMake(5.4, 58.3)];
    [path addCurveToPoint:CGPointMake(36, 12) controlPoint1:CGPointMake(4.6, 22) controlPoint2:CGPointMake(19.1, 9.7)];
    [path addCurveToPoint:CGPointMake(89, 14) controlPoint1:CGPointMake(59.2, 15.2) controlPoint2:CGPointMake(61.9, 31.5)];
    [path addCurveToPoint:CGPointMake(104, 15) controlPoint1:CGPointMake(95.3, 10) controlPoint2:CGPointMake(100.9, 6.9)];
    
    [path applyTransform:CGAffineTransformMakeScale(0.9524*size.width/100, 0.9524*size.height/50)];
    [path applyTransform:CGAffineTransformMakeTranslation(point.x - size.width/2 - 3 * size.width /100, point.y - size.height/2 - 8 * size.height/50)];
    
    return path;
}

@end
