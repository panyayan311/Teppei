//
//  EvalGraph.m
//  Teppei
//
//  Created by levanha711 on 2017/03/09.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "EvalGraph.h"

@implementation EvalGraph

- (void)setupData {
    
}

static const CGFloat radius = 100.0;
static const CGFloat pointRadius = 4.0;


- (void)drawGraph {
    [self drawPolygonwithRadius:radius];
    [self drawPolygonwithRadius:radius / 2.0];
    [self drawGraphCore];
    
}

- (void)drawGraphCore {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint centerPoint = [self getCenterPointGraph];
    [path moveToPoint:CGPointMake(centerPoint.x + radius * 0.3, centerPoint.y)];//[[self.listResult objectForKey:@"異文化理解"] doubleValue]
    [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y - radius * 0.1)];//[[self.listResult objectForKey:@"人間的魅力"] doubleValue]
    [path addLineToPoint:CGPointMake(centerPoint.x - radius * 0.44, centerPoint.y)];//[[self.listResult objectForKey:@"プレゼンス"] doubleValue]
    [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y + radius * 0.5)];//[[self.listResult objectForKey:@"ビジネス"] doubleValue]
    [path closePath];
    
    [self drawCircleAtPoint:CGPointMake(centerPoint.x + radius * 0.3, centerPoint.y)];
    [self drawCircleAtPoint:CGPointMake(centerPoint.x, centerPoint.y - radius * 0.1)];
    [self drawCircleAtPoint:CGPointMake(centerPoint.x - radius * 0.44, centerPoint.y)];
    [self drawCircleAtPoint:CGPointMake(centerPoint.x, centerPoint.y + radius * 0.5)];
    
    
    [[[UIColor alloc] initWithRed:182/255.0 green:99/255.0 blue:255/255.0 alpha:1] setStroke];
    [[[UIColor alloc] initWithRed:182/255.0 green:99/255.0 blue:255/255.0 alpha:0.7] setFill];
    [path stroke];
    [path fill];
    
}

- (void)drawCircleAtPoint:(CGPoint)point {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path addArcWithCenter:point radius:pointRadius startAngle:0.0  endAngle:2 * M_PI clockwise:true];
    [[[UIColor alloc] initWithRed:182/255.0 green:99/255.0 blue:255/255.0 alpha:1] setFill];
    [path fill];
}

- (NSInteger)getMaxNumberAnswers {
    return 0;
}

- (void)drawPolygonwithRadius:(CGFloat)radiusCurrent {
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint centerPoint = [self getCenterPointGraph];
    [path moveToPoint:CGPointMake(centerPoint.x + radiusCurrent, centerPoint.y)];
    [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y - radiusCurrent) ];
    [path addLineToPoint:CGPointMake(centerPoint.x - radiusCurrent, centerPoint.y)];
    [path addLineToPoint:CGPointMake(centerPoint.x, centerPoint.y + radiusCurrent)];
    [path closePath];
    
    [[UIColor blackColor] setStroke];
    [path stroke];
}



- (CGPoint)getCenterPointGraph {
    CGPoint point = CGPointMake(self.bounds.origin.x + self.bounds.size.width / 2.0, self.bounds.origin.y + self.bounds.size.height / 2.0);
    
    return point;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawGraph];
}


@end
