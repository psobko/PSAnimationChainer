//
//  PSAnimationChainer.h
//  PSAnimationChainer
//
//  Created by psobko on 5/29/15.
//  Copyright (c) 2015 psobko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PSAnimationChainer : NSObject

typedef void(^animationBlock)(BOOL);

@property (assign, nonatomic) CGFloat defaultDuration;
@property (readonly, nonatomic) BOOL isAnimating;

-(void)addAnimations:(void (^)(void))animations;

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                      animations:(void (^)(void))animations;

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                     animations:(void (^)(void))animations
                     completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);


-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                          delay:(NSTimeInterval)delay
         usingSpringWithDamping:(CGFloat)dampingRatio
          initialSpringVelocity:(CGFloat)velocity
                        options:(UIViewAnimationOptions)options
                     animations:(void (^)(void))animations
                     completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);

-(void)startAnimating;

@end
