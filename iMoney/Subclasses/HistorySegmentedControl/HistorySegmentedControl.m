//
//  HistorySegmentedControl.m
//  fastFitnessUpdate
//
//  Created by Avid on 2/19/16.
//  Copyright © 2016 Ion Postolachi. All rights reserved.
//

#import "HistorySegmentedControl.h"

@implementation HistorySegmentedControl

const static CGFloat kViewHeight = 35;

- (void) layoutSubviews {
    
    [super layoutSubviews];
    CGRect frame = self.frame;
    [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kViewHeight)];
}

-(void)setSegmentsColor {
    
    [self setBackgroundImage:[self imageWithColor:RGBColor(241, 241, 241, 1)]
                    forState:UIControlStateNormal
                  barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:[self imageWithColor:RGBColor(42, 3, 70, 1)]
                    forState:UIControlStateSelected
                  barMetrics:UIBarMetricsDefault];
    
    [self setBackgroundImage:[self imageWithColor:RGBColor(42, 3, 70, 0.5)]
                    forState:UIControlStateHighlighted
                  barMetrics:UIBarMetricsDefault];
    
    [self setDividerImage:[self imageWithColor:[UIColor clearColor]]
      forLeftSegmentState:UIControlStateNormal
        rightSegmentState:UIControlStateNormal
               barMetrics:UIBarMetricsDefault];
}

-(void)setFonts{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    NSDictionary *atributesNormalState = @{NSFontAttributeName : font,
                                           NSForegroundColorAttributeName : [UIColor colorWithRed:103/255.0 green:103/255.0 blue:103/255.0 alpha:1]};
    NSDictionary *atributesSelected    = @{NSFontAttributeName : font,
                                           NSForegroundColorAttributeName : [UIColor whiteColor]};
    [self setTitleTextAttributes:atributesNormalState
                        forState:UIControlStateNormal];
    
    [self setTitleTextAttributes:atributesSelected
                        forState:UIControlStateSelected];
}

- (CGSize) intrinsicContentSize {
    
    CGSize defaultSize = [super intrinsicContentSize];
    return CGSizeMake(defaultSize.width, kViewHeight);
}

- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
