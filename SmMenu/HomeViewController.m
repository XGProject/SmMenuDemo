//
//  HomeViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/6.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "HomeViewController.h"
#import "NearbyViewController.h"
#import "SquareViewController.h"
#import "RecommendViewController.h"

#import "WJSliderScrollView.h"
#import "WJSliderView.h"
@interface HomeViewController ()
@property(nonatomic,strong)WJSliderScrollView *scrollView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"有毒的home";
    NearbyViewController *near = [[NearbyViewController alloc]init];
    SquareViewController *square = [[SquareViewController alloc]init];
    RecommendViewController *recommend = [[RecommendViewController alloc]init];
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    UILabel *label3 = [UILabel new];
    
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    label3.textAlignment = NSTextAlignmentCenter;
    
    
    label1.text = @"广场";
    label2.text = @"天堂";
    label3.text = @"地狱";
    
    
    
    self.scrollView = [[WJSliderScrollView alloc]initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-self.navigationController.navigationBar.frame.size.height) itemArray:@[label1,label2,label3] contentArray:@[near.view,square.view,recommend.view]];
    [self.view addSubview:self.scrollView];

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
