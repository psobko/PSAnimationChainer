//
//  PSAnimationChainer.m
//  PSAnimationChainer
//
//  Created by psobko on 5/29/15.
//  Copyright (c) 2015 psobko. All rights reserved.
//

#import "PSAnimationChainer.h"

@interface PSAnimationChainer ()

@property (strong, nonatomic) NSMutableArray *animationBlocks;
@property (copy, nonatomic) animationBlock (^runNextAnimationBlock)();

@end

@implementation PSAnimationChainer

#pragma mark - Initialization

-(id)init
{
    if(self = [super init])
    {
        _animationBlocks = [[NSMutableArray alloc] init];
        _defaultDuration = 0.35;
        __weak typeof(self) weakSelf = self;
        _runNextAnimationBlock = ^{
            animationBlock block = weakSelf.animationBlocks.count ? (animationBlock)[weakSelf.animationBlocks firstObject] : nil;
            if (block)
            {
                [weakSelf.animationBlocks removeObjectAtIndex:0];
                return block;
            }
            else
            {
                _isAnimating = NO;
                return ^(BOOL finished){};
            }
        };
    }
    
    return self;
}

#pragma mark - Animation Chaining

-(void)addAnimations:(void (^)(void))animations
{
    [self addAnimationsWithDuration:self.defaultDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:nil];
}

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                      animations:(void (^)(void))animations
{
    [self addAnimationsWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:nil];
}

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                      animations:(void (^)(void))animations
                      completion:(void (^)(BOOL finished))completion
{
    [self addAnimationsWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:animations
                         completion:completion];
}

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                           delay:(NSTimeInterval)delay
                         options:(UIViewAnimationOptions)options
                      animations:(void (^)(void))animations
                      completion:(void (^)(BOOL finished))completion
{
    __weak typeof(self) weakSelf = self;
    
    [self.animationBlocks addObject:^(BOOL finished){
        [UIView animateWithDuration:duration
                              delay:delay
                            options:options
                         animations:animations
                         completion:^(BOOL finished) {
                             if(completion)
                             {
                                 completion(finished);
                             }
                             weakSelf.runNextAnimationBlock()(finished);
                         }];
    }];
}

-(void)addAnimationsWithDuration:(NSTimeInterval)duration
                           delay:(NSTimeInterval)delay
          usingSpringWithDamping:(CGFloat)dampingRatio
           initialSpringVelocity:(CGFloat)velocity
                         options:(UIViewAnimationOptions)options
                      animations:(void (^)(void))animations
                      completion:(void (^)(BOOL finished))completion
{
    __weak typeof(self) weakSelf = self;
    [self.animationBlocks addObject:^(BOOL finished){
        [UIView animateWithDuration:duration
                              delay:delay
             usingSpringWithDamping:(CGFloat)dampingRatio
              initialSpringVelocity:(CGFloat)velocity
                            options:options
                         animations:animations
                         completion:^(BOOL finished) {
                             if(completion)
                             {
                                 completion(finished);
                             }
                             weakSelf.runNextAnimationBlock()(finished);
                         }];
    }];
}



#pragma mark - Animation Control

-(void)startAnimating
{
    _isAnimating = YES;
    self.runNextAnimationBlock()(YES);
}


@end
