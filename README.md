# CWDoitPushAnimation
圆形扩散push转场动画
#### 1.先看下效果图:
![demo.gif](https://upload-images.jianshu.io/upload_images/3096223-d31754da007617ae.gif?imageMogr2/auto-orient/strip)

#### 2.使用代码:
```
- (IBAction)buttonClick:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:[sb instantiateViewControllerWithIdentifier:@"NextViewController"]
                                         animated:YES
                                             doit:YES
                                             rect:self.testButton.frame];
}
```

#### 3.方法说明:
```
/**
 自定义push方法
 当doit为NO时,等效-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

 @param viewController 目标vc
 @param animated 是否执行动画
 @param doit YES: 自定义转场动画 NO: 系统自带动画
 @param rect 当doit为YES时,动画开始的起点frame
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                      doit:(BOOL)doit
                      rect:(CGRect)rect;
```
