//
//  animateViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/19.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "animateViewController.h"

@interface animateViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation animateViewController{
    UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;
    CGFloat percent;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    /*给self.view一个触摸手势*/
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGes:)];
    [self.view addGestureRecognizer:pan];
    
    UIButton *returnButton = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 100, 50)];
    [returnButton setTitle:@"返回" forState:UIControlStateNormal];
    returnButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:returnButton];
    
    [returnButton addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) panGes:(UIPanGestureRecognizer *)gesture{
    CGFloat yOffset = [gesture translationInView:self.view].y;
    percent = yOffset /1800;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
        //这句必须加上！！
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [percentDrivenInteractiveTransition updateInteractiveTransition:percent];
    }else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded){
        [percentDrivenInteractiveTransition finishInteractiveTransition];
        //这句也必须加上！！
        percentDrivenInteractiveTransition = nil;
    }
}


- (void) returnClick:(UIButton *) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
