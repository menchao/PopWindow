//
//  PopWindow.m
//  PopWindow
//
//  Created by menchao on 16/5/28.
//  Copyright © 2016年 menchao. All rights reserved.
//

#import "PopWindow.h"

@interface PopWindow ()

@property (nonatomic,strong) UIWindow *window;

@property (nonatomic,strong) UIViewController *viewController;

@property (nonatomic,assign) CGRect  currentFrame;

@property (nonatomic,assign) CGPoint  originPoint;


@end


@implementation PopWindow


- (instancetype)init{
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         [self initialize];
    }
    return self;
}




- (void)initialize{
    self.viewController = [[UIViewController alloc] init];
     self.viewController.view.backgroundColor = [UIColor greenColor];
    self.rootViewController = self.viewController;
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanRecognizer:)];
    
    [self addGestureRecognizer:panRecognizer];
    
    self.layer.shadowRadius = 30.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.8;
    self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    
    self.currentFrame = self.frame;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    
    self.layer.masksToBounds = NO;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    
    self.layer.shadowOpacity = 0.5f;
    
    self.layer.shadowPath = shadowPath.CGPath;
   


    
}






-(void)layoutSubviews
{
    UIView *rootView = self.rootViewController.view;
    
   // CGRect contentRect = CGRectMake(kWindowResizeGutterSize, kWindowResizeGutterSize+kTitleBarHeight, self.bounds.size.width-(kWindowResizeGutterSize*2), self.bounds.size.height-kTitleBarHeight-(kWindowResizeGutterSize*2));
    
 //   NSLog(@"contentRect %@",NSStringFromCGRect(contentRect));
    
    //rootView.frame = contentRect;
    [self adjustMask];
}

-(BOOL)isOpaque
{
    return NO;
}


-(void)adjustMask
{
    CGRect contentBounds = self.rootViewController.view.bounds;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:contentBounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8.0, 8.0)].CGPath;
    
    maskLayer.frame = contentBounds;
    
    self.rootViewController.view.layer.mask = maskLayer;
    
     self.layer.shadowRadius = 30.0;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3;
}






#pragma mrak - event handle

-(void)didPanRecognizer:(UIPanGestureRecognizer *)recognizer{
    NSLog(@"didPanRecognizer state :%ld",(long)recognizer.state);
    UIWindow *window =  [UIApplication sharedApplication].windows[0];
    CGPoint gp = [recognizer locationInView:window];
    CGPoint point = [recognizer locationInView:self];
    if (UIGestureRecognizerStateBegan == recognizer.state) {
        self.originPoint = point;
    }else if(UIGestureRecognizerStateChanged == recognizer.state){
        self.frame = CGRectMake(gp.x-self.originPoint.x, gp.y-self.originPoint.y, self.frame.size.width, self.frame.size.height);
    }else if(UIGestureRecognizerStateEnded == recognizer.state){
        [self setNeedsDisplay];
    }
}





- (void)drawRect:(CGRect)rect {
    if (self.isKeyWindow)
    {
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSaveGState(currentContext);
        CGContextSetShadow(currentContext, CGSizeMake(-15, 20), 5);
        [super drawRect: rect];
        CGContextRestoreGState(currentContext);//
//        [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMidX(self.bounds)-kWindowResizeGutterKnobSize/2, CGRectGetMaxY(self.bounds)-kWindowResizeGutterKnobWidth-(kWindowResizeGutterSize-kWindowResizeGutterKnobWidth)/2, kWindowResizeGutterKnobSize, kWindowResizeGutterKnobWidth) cornerRadius:2] fill];
//        
//        [[UIBezierPath bezierPathWithRoundedRect:CGRectMake((kWindowResizeGutterSize-kWindowResizeGutterKnobWidth)/2, CGRectGetMidY(self.bounds)-kWindowResizeGutterKnobSize/2, kWindowResizeGutterKnobWidth, kWindowResizeGutterKnobSize) cornerRadius:2] fill];
//        
//        [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(CGRectGetMaxX(self.bounds)-kWindowResizeGutterKnobWidth-(kWindowResizeGutterSize-kWindowResizeGutterKnobWidth)/2, CGRectGetMidY(self.bounds)-kWindowResizeGutterKnobSize/2, kWindowResizeGutterKnobWidth, kWindowResizeGutterKnobSize) cornerRadius:2] fill];
    }
}


@end
