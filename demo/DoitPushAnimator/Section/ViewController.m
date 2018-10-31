//
//  ViewController.m
//  DoitPushAnimator
//
//  Created by 罗泰 on 2018/10/31.
//  Copyright © 2018 chenwang. All rights reserved.
//

#import "ViewController.h"
#import "CWDoitAnimatorManager.h"
#import "NextViewController.h"
#import "UINavigationController+DoitAnimation.h"

@interface ViewController ()
@property (nonatomic, strong) CWDoitAnimatorManager             *animatorManager;
@property (nonatomic, weak) IBOutlet UIButton                   *testButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testButton.layer.cornerRadius = CGRectGetWidth(self.testButton.frame) * 0.5;
    self.testButton.layer.masksToBounds = YES;
    self.testButton.backgroundColor = UIColor.cyanColor;
    self.view.backgroundColor = UIColor.whiteColor;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (IBAction)buttonClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:[sb instantiateViewControllerWithIdentifier:@"NextViewController"]
                                         animated:YES
                                             doit:YES
                                             rect:self.testButton.frame];
}

- (CWDoitAnimatorManager *)animatorManager {
    if(!_animatorManager)
    {
        self.animatorManager = [[CWDoitAnimatorManager alloc] init];
    }
    return _animatorManager;
}

@end
