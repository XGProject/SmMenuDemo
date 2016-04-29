//
//  touchViewViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/18.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "touchViewViewController.h"

@interface touchViewViewController ()

@end

@implementation touchViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        
        [self loadLabelWithTitle:title];
        
    }
    
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)loadLabelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    label.text = @"test";
    [self.view addSubview:label];
    
}
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction * action1 = [UIPreviewAction actionWithTitle:@"选项11" style:0 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"我是选项一");
    }];
    
    UIPreviewAction * action2 = [UIPreviewAction actionWithTitle:@"选项22" style:1 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"我是选项二");
    }];
    
    UIPreviewAction * action3 = [UIPreviewAction actionWithTitle:@"选项33" style:2 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"我是选项三");
    }];
    
    
    
    
    NSArray * actions = @[action1,action2,action3];
    
    return actions;
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
