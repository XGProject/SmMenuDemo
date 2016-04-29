//
//  DlHomeViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/6.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "DlHomeViewController.h"
#import "NearbyViewController.h"
#import "SquareViewController.h"
#import "RecommendViewController.h"

#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define DEF_TABBAR_HEIGHT  self.tabBarController.tabBar.frame.size.height
#define DEF_NAVIGATION_HEIGHT   self.navigationController.navigationBar.frame.size.height
@interface DlHomeViewController ()<UIScrollViewDelegate>{
    NearbyViewController *nearbyVC;
    SquareViewController *squareVC;
    RecommendViewController *recommendVC;
    UIScrollView *mainScrollView;
    UIView *navView;
    UILabel *sliderLabel;
    UIButton *nearbyBtn;
    UIButton *squareBtn;
    UIButton *recommendBtn;
}
@end

@implementation DlHomeViewController
//懒加载三个VC
-(NearbyViewController *)nearbyVC{
    if (nearbyVC==nil) {
        nearbyVC = [[NearbyViewController alloc]init];
    }
    return nearbyVC;
}

-(SquareViewController *)squareVC{
    if (squareVC==nil) {
        squareVC = [[SquareViewController alloc]init];
        
    }
    return squareVC;
   
}


-(RecommendViewController *)recommendVC{
    if (recommendVC==nil) {
        recommendVC = [[RecommendViewController alloc]init];
        
    }
    return  recommendVC;
}
-(void)initUI{
    navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_NAVIGATION_HEIGHT)];
    nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nearbyBtn.frame = CGRectMake(30, 0, DEF_SCREEN_WIDTH/4, navView.frame.size.height);
    nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [nearbyBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [nearbyBtn setTitle:@"附近" forState:UIControlStateNormal];
    nearbyBtn.tag = 1;
    [navView addSubview:nearbyBtn];
    
    
    squareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    squareBtn.frame = CGRectMake(nearbyBtn.frame.origin.x+nearbyBtn.frame.size.width, nearbyBtn.frame.origin.y, DEF_SCREEN_WIDTH/4, navView.frame.size.height);
    squareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [squareBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [squareBtn setTitle:@"广场" forState:UIControlStateNormal];
    squareBtn.tag = 2;
    [navView addSubview:squareBtn];
    
    
    recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    recommendBtn.frame = CGRectMake(squareBtn.frame.origin.x+squareBtn.frame.size.width, squareBtn.frame.origin.y, DEF_SCREEN_WIDTH/4, navView.frame.size.height);
    recommendBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [recommendBtn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
    [recommendBtn setTitle:@"推荐" forState:UIControlStateNormal];
    recommendBtn.tag = 3;
    [navView addSubview:recommendBtn];
    
    
    sliderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40-2, DEF_SCREEN_WIDTH/4, 4)];
    sliderLabel.backgroundColor = [UIColor whiteColor];
    [navView addSubview:sliderLabel];
    self.navigationItem.titleView = navView;
   
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
}

-(UIButton *)theSeletedBtn{
    if (nearbyBtn.selected) {
        return nearbyBtn;
    }else if (squareBtn.selected){
        return squareBtn;
    }else if (recommendBtn.selected){
        return recommendBtn;
    }else{
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setMainScrollView];
}

-(void)setMainScrollView{
    mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT-DEF_TABBAR_HEIGHT)];
    mainScrollView.delegate = self;
    mainScrollView.backgroundColor = [UIColor whiteColor];
    mainScrollView.pagingEnabled = YES;
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainScrollView];
    
    NSArray *views = @[self.nearbyVC.view, self.squareVC.view,self.recommendVC.view];
    for (int i = 0; i < views.count; i++){
        //添加背景，把三个VC的view贴到mainScrollView上面
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(DEF_SCREEN_WIDTH* i, 0, mainScrollView.frame.size.width, mainScrollView.frame.size.height)];
        [pageView addSubview:views[i]];
        [mainScrollView addSubview:pageView];
    }
    mainScrollView.contentSize = CGSizeMake(DEF_SCREEN_WIDTH * (views.count), 0);
}

-(UIButton *)buttonWithTag:(NSInteger)tag{
    if (tag==1) {
        return nearbyBtn;
    }else if (tag==2){
        return squareBtn;
    }else if (tag==3){
        return recommendBtn;
    }else{
        return nil;
    }
}


-(void)sliderAction:(UIButton *)sender{
    [self sliderAnimationWithTag:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        mainScrollView.contentOffset = CGPointMake(DEF_SCREEN_WIDTH * (sender.tag - 1), 0);
    } completion:^(BOOL finished) {
      
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double index_ = scrollView.contentOffset.x / DEF_SCREEN_WIDTH;
    [self sliderAnimationWithTag:(int)(index_+0.5)+1];
}

#pragma mark - sliderLabel滑动动画
- (void)sliderAnimationWithTag:(NSInteger)tag{
    nearbyBtn.selected = NO;
    squareBtn.selected = NO;
    recommendBtn.selected = NO;
    UIButton *sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        sliderLabel.frame = CGRectMake(sender.frame.origin.x, sliderLabel.frame.origin.y, sliderLabel.frame.size.width, sliderLabel.frame.size.height);
        
    } completion:^(BOOL finished) {
        nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        squareBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        recommendBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [nearbyBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4] forState:UIControlStateNormal];
        [squareBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4] forState:UIControlStateNormal];
        [recommendBtn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4] forState:UIControlStateNormal];
        
          //触摸button的高亮效果
        [sender setShowsTouchWhenHighlighted:YES];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }];
    
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
