//
//  NearbyViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/6.
//  Copyright © 2016年 厦航. All rights reserved.
//
//
#define WINDOW_W [UIScreen mainScreen].bounds.size.width
#define NAVIGATION_H self.navigationController.navigationBar.frame.size.height
#define WINDOW_H [UIScreen mainScreen].bounds.size.height


#import "NearbyViewController.h"
#import "touchViewViewController.h"
@interface NearbyViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>{
    UITableView *_tableView;
    NSArray *array;
}

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:18/255.0 green:146/255.0 blue:114/255.0 alpha:1.0];
    
    self.view.backgroundColor = [UIColor whiteColor];
    array = @[@"Touch1",@"Touch2",@"Touch3"];
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
    //实现3Dtouch触摸的协议
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
    [self check3dtouch];
}

/*判断3DTouch是否可用*/
-(void)check3dtouch
{
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        NSLog(@"3DTouch 可用");
    }else{
        NSLog(@"3DTouch 不可用");
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

#pragma mark ----UIViewControllerPreviewingDelegate（按压屏幕显示一个ViewController）
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    touchViewViewController *touchView = [[touchViewViewController alloc]initWithTitle:@"厦航"];
    touchView.preferredContentSize = CGSizeMake(0.0f,500.f);
    touchView.view.backgroundColor = [UIColor blueColor];
    return touchView;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    
    [self showViewController:viewControllerToCommit sender:self];
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
