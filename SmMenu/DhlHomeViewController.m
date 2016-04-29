//
//  DhlHomeViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/12.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "DhlHomeViewController.h"
#define WINDOW_W [UIScreen mainScreen].bounds.size.width
#define NAVIGATION_H self.navigationController.navigationBar.frame.size.height
#define WINDOW_H [UIScreen mainScreen].bounds.size.height

@interface DhlHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>{
}


@property (nonatomic,strong)UIView *menuView;
@property (nonatomic,strong)NSArray *menuArray;
@property (nonatomic,strong)NSMutableArray *layersArray;

@property (nonatomic,strong)UITableView *tableViewOne;
@property (nonatomic,strong)UITableView *tableViewTwo;
@property (nonatomic,assign) BOOL        tableViewOneShow;
@property (nonatomic,assign) BOOL        tableViewTwoShow;

@property (nonatomic,assign)NSInteger lastSelectedIndex;//储存中的button的tag值

/*存储两个表格显示数据*/
@property (nonatomic,strong)NSMutableArray *dataArrayOne;
@property (nonatomic,strong)NSMutableArray *dataArrayTwo;

/**
 * 关闭遮盖功能
 */
@property (nonatomic,strong)UIColor *CarverViewColor;

/**
 * 遮盖的动画时间
 */
@property (nonatomic,assign)CGFloat caverAnimationTime;



@end

@implementation DhlHomeViewController


- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.8;
    layer.fillColor = [UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:0xcc/255.0].CGColor;
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = point;
    return layer;
}

- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position{
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, 20, 20);
    layer.backgroundColor = color.CGColor;
    return layer;
}

- (void)remover{
    CALayer *layer = self.layersArray[self.lastSelectedIndex-100];
    layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
    
    self.tableViewOneShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
    }];
    self.tableViewTwoShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2,CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
    }];
    
    [self hideCarverView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self createTableViewOne];
    [self createTableViewTwo];
    self.title = @"wgusfds";
    self.dataArrayOne = [[NSMutableArray alloc]initWithObjects:@"测试数据1", @"测试数据2",@"测试数据3",@"测试数据4",@"测试数据5",@"测试数据6",@"测试数据7",@"测试数据8",@"测试数据9",@"测试数据10",@"测试数据11",nil];
    
    self.dataArrayTwo = [[NSMutableArray alloc]initWithObjects:@"显示数据1",@"显示数据2",@"显示数据3",@"显示数据4",@"显示数据5",@"显示数据6", nil];
}

- (void) initUI{
    self.lastSelectedIndex = -1;
    self.layersArray = [[NSMutableArray alloc]init];
    
    /*这是添加手势*/
    self.view.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remover)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
    
    
    /*这是创建导航栏底层视图*/
    self.menuView = [[UIView alloc]initWithFrame:CGRectMake(0, NAVIGATION_H+20, self.view.frame.size.width, 50)];
    self.menuView.userInteractionEnabled = YES;
    [self.view addSubview:self.menuView];
    
    self.menuArray = @[@"全局",@"金服",@"互联网"];
    NSInteger num = self.menuArray.count;
  
    for(int i = 0 ; i < num ; i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.menuView.frame.size.width/num*i, 0, self.menuView.frame.size.width/num, self.menuView.frame.size.height)];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.9] forState:UIControlStateNormal];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:self.menuArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(showTableViewOne:) forControlEvents:UIControlEventTouchUpInside];
        
        CGPoint layersPoint = CGPointMake(self.menuView.frame.size.width/num-10, self.menuView.frame.size.height/2);
        CALayer *layers = [self createBgLayerWithColor:[UIColor clearColor] andPosition:layersPoint];
        CGPoint indicatorPoint = CGPointMake(10,10);
        
        CAShapeLayer *indicator = [self createIndicatorWithColor:[UIColor lightGrayColor] andPosition:indicatorPoint];
        [layers addSublayer:indicator];
        

        /*将所有的layer装入这个数组*/
        [button.layer addSublayer:layers];
        [self.layersArray addObject:layers];
        [self.menuView addSubview:button];
    }
    CGFloat btnW = (self.view.frame.size.width-num+1)/num;
    for (int i = 0; i < num; i++) {
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake((btnW+1)*i+btnW, self.menuView.frame.size.height/5, 1, self.menuView.frame.size.height/10*6.5)];
        lineLb.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
        if (i == num - 1) {
            lineLb.hidden = YES;
        }
        [self.menuView addSubview:lineLb];
    }
    
    /*上下边框线*/
    UILabel *VlineLbTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.menuView.frame.size.width, 1)];
    VlineLbTop.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *VlineLbBom = [[UILabel alloc]initWithFrame:CGRectMake(0, self.menuView.frame.size.height, self.menuView.frame.size.width, 1)];
    VlineLbBom.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    
    [self.menuView addSubview:VlineLbTop];
    [self.menuView addSubview:VlineLbBom];
}

#pragma Mark————创建tableOne
- (void) createTableViewOne{
    self.tableViewOne = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0) style:UITableViewStylePlain];
    self.tableViewOne.scrollEnabled =YES;
    self.tableViewOne.separatorStyle = NO;
    self.tableViewOne.showsVerticalScrollIndicator = NO;
    self.tableViewOne.delegate = self;
    self.tableViewOne.dataSource =self;
    
    [self.view addSubview:self.tableViewOne];
}

#pragma mark----创建tableTwo
- (void) createTableViewTwo{
    self.tableViewTwo = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0) style:UITableViewStylePlain];
    self.tableViewTwo.scrollEnabled =YES;
    self.tableViewTwo.separatorStyle = NO;
    self.tableViewTwo.showsVerticalScrollIndicator = NO;
    self.tableViewTwo.delegate = self;
    self.tableViewTwo.dataSource =self;
    [self.view addSubview:self.tableViewTwo];
}

#pragma mark----显示第一个Table
- (void) showTableViewOne:(UIButton *)sender{
    //这个只会在第一次点击进入下面的代码。
    if (self.lastSelectedIndex != sender.tag && self.lastSelectedIndex !=-1) {
        CALayer *layer = self.layersArray [self.lastSelectedIndex - 100];
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
        } completion:^(BOOL finished) {
            self.tableViewOneShow = NO;
            self.tableViewTwoShow = NO;
            [self showTableViewOneAndTwo:sender.tag];
        }];
    }
    else {
        [self showTableViewOneAndTwo:sender.tag];
    }
}

#pragma mark----显示第二个Table的方法。
//- (void) showTableViewTwo:(BOOL) tableViewTwoShow{
//    if (self.tableViewTwoShow == YES) {
//        [self showCarverView];
//        [UIView animateWithDuration:0.2 animations:^{
//            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 300);
//        }];
//    }
//    else {
//        [self showCarverView];
//        self.tableViewTwoShow = YES;
//        self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
//        [UIView animateWithDuration:0.2 animations:^{
//            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.accessibilityFrame.size.width/2, 300);
//        }];
//    
//    }
//
//}


#pragma mark----需要显示两个Table的方法。
- (void) showTableViewOneAndTwo:(NSUInteger)index{
    NSLog(@"%ld",index);
    if (self.tableViewOneShow == NO) {
        self.tableViewOneShow = YES;
        [self showCarverView];
        
        CALayer *layer = self.layersArray[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        //设置tableViewOne的frame 高度为0
        self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 300);
        }];
    }
    else {
        CALayer *layer = self.layersArray[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        self.tableViewOneShow = NO;
        
        self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 300);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
        }];
        /*在tableViewTwo没有显示的时候 frame 高度0*/
        self.tableViewTwoShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
        }];
        
        [self hideCarverView];
    }
    self.lastSelectedIndex = index;
    
}

#pragma mark ---显示遮盖视图
- (void)showCarverView{
    if (!self.caverAnimationTime) {
        self.caverAnimationTime = 0.15;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, WINDOW_H-self.view.frame.origin.y);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.view.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
}
#pragma mark ---隐藏遮盖视图
- (void)hideCarverView{
    if (!self.caverAnimationTime) {
        self.caverAnimationTime = 0.15;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width
                            , self.menuView.frame.size.height);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.view.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
}


#pragma mark -----UITableViewDelegate--------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableViewOne) {
       return  self.dataArrayOne.count;
    }
    else {
       return  self.dataArrayTwo.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.tableViewOne){
        static NSString *Acell = @"Acell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Acell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Acell];
        }
        cell.textLabel.text = _dataArrayOne [indexPath.row];
        return cell;
    }
    else {
        static NSString *Bcell = @"Bcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Bcell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Bcell];
        }
        cell.textLabel.text = _dataArrayTwo [indexPath.row];
        return cell;
    }
    
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
