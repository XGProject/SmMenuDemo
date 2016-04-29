//
//  WJMenuViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/8.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "WJMenuViewController.h"
#import "WJDropdownMenu.h"
@interface WJMenuViewController ()<WJMenuDelegate>

@end

@implementation WJMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //清除导航栏自适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //数组的最大长度不能超过17，否者会崩溃
    NSArray *MainMenuArray = @[@"筛选",@"分类",@"区域"];
   
    NSArray *MenuArrayOne1 = @[@"减脂塑形",@"增肌指导",@"体能训练",@"习形体纠正",@"武术搏击",@"自重训练",@"力量训练",@"机械训练"];
    NSArray *MenuArrayOne = [NSArray arrayWithObject:MenuArrayOne1];
    
    
    NSArray *MenuArrayTwo_1=@[@"搏击",@"力量",@"肌肉",@"机械",@"瘦身"];
    NSArray *MenuArrayTwo_2=@[@[@"跆拳道",@"咏春拳",@"空手道",@"泰拳",@"日本拳",@"美国拳头"],@[@"举重",@"负重举"],@[@"胸肌",@"腹肌",@"三角肌",@"臀肌"],@[@"杠铃",@"哑铃"],@[@"跑步"]];
    NSArray *MenuArrayTwo = [NSArray arrayWithObjects:MenuArrayTwo_1,MenuArrayTwo_2,nil];
    
    
    NSArray *MenuArrayThree_1 = @[@"浦东",@"普陀",@"黄埔",@"嘉定",@"嘉兴",@"松江",@"江阴",@"长宁",@"闵行",@"静安",@"宝山",@"佘山",@"杨浦",@"昆山",@"新村",@"志丹",@"虹桥",@"金山"];
    NSArray *MenuArrayThree_2 = @[@[@"浦东咖啡馆",@"浦东茶铺",@"浦东香烟",@"浦东矿泉水",@"浦东徒弟",@"浦东电脑",@"浦东楼房",@"浦东鼠标",@"浦东手机",@"浦东耳机",@"浦东左面",@"浦东小面",@"浦东筷子",@"浦东盒饭",@"浦东大海",@"浦东糖果",@"浦东洗面奶",@"浦东擦汗",@"浦东cha",@"浦东擦汗"],@[@"普陀包子",@"普陀饺子"],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""],@[@""]];
    
    NSArray *MenuArrayThree = [NSArray arrayWithObjects:MenuArrayThree_1,MenuArrayThree_2, nil];
    
    
    
    //创建Menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    menu.delegate=self;
    [self.view addSubview:menu];
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置 不设置默认是 0.15
    menu.menuTitleFont = 16;      //  设置menuTitle字体大小 默认不设置是  11
    menu.tableTitleFont = 15;     //  设置tableTitle字体大小 默认不设置是 10
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
    // 三组菜单调用方法
    [menu createThreeMenuTitleArray:MainMenuArray FirstArr:MenuArrayOne SecondArr:MenuArrayTwo threeArr:MenuArrayThree];
 
}

#pragma mark --代理方法点击时候对应的Index
- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex andSecondIndex:(NSInteger)secondIndex{
    NSLog(@"刷选:-------%ld     分类:-------%ld     分类:-------%ld",MenuTitleIndex,firstIndex,secondIndex);
}

- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent andSecondContent:(NSString *)secondContent{
    NSLog(@"筛选:------------%@       分类:------------%@         分类:-----------%@",MenuTitle,firstContent,secondContent);

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
