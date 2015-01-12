//
//  ViewController.m
//  KeyAnimation
//
//  Created by GabrielMassana on 12/01/2015.
//  Copyright (c) 2015 GabrielMassana. All rights reserved.
//
//  Original Animation URL: https://astlyr.files.wordpress.com/2012/09/realization_gif_by_scaredypoopants-d5e9au5.gif
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) UIImageView *animationImageView;

@end

@implementation ViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imagesArray = [self getImagesArray];
    [self.view addSubview:self.animationImageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self animateImages];
}

#pragma mark - Subviews

- (UIImageView *)animationImageView
{
    if (!_animationImageView)
    {
        _animationImageView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    
    return _animationImageView;
}

#pragma mark - ImageArray

- (NSArray *)getImagesArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index <= 16; index++)
    {
        NSString *imageName = [NSString stringWithFormat:@"frame_%03ld", (long)index];
        [array addObject:(id)[UIImage imageNamed:imageName].CGImage];
    }

    return array;
}

#pragma mark - AnimateImageArray

- (void)animateImages
{
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    keyframeAnimation.values = self.imagesArray;
    
    keyframeAnimation.repeatCount = 1.0f;
    keyframeAnimation.duration = 4.0;
    
    keyframeAnimation.delegate = self;
    
//    keyframeAnimation.removedOnCompletion = YES;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.fillMode = kCAFillModeForwards;
    
    CALayer *layer = self.animationImageView.layer;
    
    [layer addAnimation:keyframeAnimation
                 forKey:@"flingAnimation"];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
        [self.view.layer removeAllAnimations];
        [self.animationImageView.layer removeAnimationForKey:@"flingAnimation"];
    }
}

#pragma mark - MemoryManagement

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
