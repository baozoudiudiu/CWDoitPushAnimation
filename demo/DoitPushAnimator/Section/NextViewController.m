//
//  NextViewController.m
//  DoitPushAnimator
//
//  Created by 罗泰 on 2018/10/31.
//  Copyright © 2018 chenwang. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()
@property (nonatomic, weak) IBOutlet UIImageView                *imgView;
@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
