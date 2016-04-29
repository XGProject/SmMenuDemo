//
//  SquareViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/6.
//  Copyright © 2016年 厦航. All rights reserved.
//


#import "SquareViewController.h"
#import "animateViewController.h"
@interface SquareViewController (){
    UIButton *_didButton;

}


@end

@implementation SquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:201/255.0 green:63/255.0 blue:114/255.0 alpha:1.0];
    _didButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 100, 50)];
    _didButton.backgroundColor = [UIColor whiteColor];
    [_didButton setTitle:@"点击" forState:UIControlStateNormal];
    [self.view addSubview:_didButton];
    
    [_didButton addTarget:self action:@selector(viewClick) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) viewClick{
    animateViewController *animateView = [[animateViewController alloc]init];
    
    [self presentViewController:animateView animated:YES completion:nil];

}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    return nil;
}

//- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
//    if (operation == UINavigationControllerOperationPush) {
////        return [HYBControllerTransition transitionWithType:kControllerTransitionPush duration:0.75];
//    } else {
////        return [HYBControllerTransition transitionWithType:kControllerTransitionPop duration:0.75];
//    }
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
