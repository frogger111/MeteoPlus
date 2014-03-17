// METransitionsViewController.m
// TransitionFun
//
// Copyright (c) 2013, Michael Enriquez (http://enriquez.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "LocalWeatherViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "SearchAPI.h"

@interface LocalWeatherViewController ()
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@end

@implementation LocalWeatherViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;

    NSDictionary *transitionData = self.transitions.all[1];
    id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
    if (transition == (id)[NSNull null]) {
        self.slidingViewController.delegate = nil;
    } else {
        self.slidingViewController.delegate = transition;
    }
    
    self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
    self.slidingViewController.customAnchoredGestures = @[];
    [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
    [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    

    [[RACObserve([SearchAPI api], currentWeatherCondition)
      deliverOn:RACScheduler.mainThreadScheduler] subscribeNext:^(WeatherCondition *weatherCondition) {
        
        self.tempLabel.text = [NSString stringWithFormat:@"%d°", weatherCondition.tempC];
        self.hiloLabel.text = [NSString stringWithFormat:@"%d°C / %d°F", weatherCondition.tempC, weatherCondition.tempF];
        
    }];
    
    UIImage *background = [UIImage imageNamed:@"bg1"];
    
    self.blureImageView.alpha = 0.7;
    [self.blureImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    
    self.tempLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    self.hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
    
    [[SearchAPI api] findCurrentLocation];
}


#pragma mark - Properties

- (METransitions *)transitions {
    if (_transitions) return _transitions;
    
    _transitions = [[METransitions alloc] init];
    
    return _transitions;
}

- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
    
    return _dynamicTransitionPanGesture;
}

- (IBAction)menuButtonTapped:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

@end
