//
//  DnHomeViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/7.
//  Copyright © 2016年 厦航. All rights reserved.
//
#define WINDOW_W [UIScreen mainScreen].bounds.size.width
#define carverAnimationDefalutTime 0.15
#define NAVIGATION_H self.navigationController.navigationBar.frame.size.height
#define WINDOW_H [UIScreen mainScreen].bounds.size.height


#import "DnHomeViewController.h"

@interface DnHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView    *tableViewOne;
@property (nonatomic,strong) UITableView    *tableViewTwo;

@property (nonatomic,strong) NSMutableArray *layersArray;
@property (nonatomic,strong) NSArray *menuArray;
@property (nonatomic,strong) UIView *menuView;

/*这是显示隐藏两个UITableView的方法*/
@property (nonatomic,assign) BOOL            tableViewOneShow;
@property (nonatomic,assign) BOOL            tableViewTwoShow;

/*储存选中UIButton的下标*/
@property (nonatomic,assign) NSInteger      lastSelectedIndex;
/*储存选中行的下标*/
@property (nonatomic,assign) NSInteger      lastSelectedCellIndex;

/*模拟UITableViewOne中的显示数据*/
@property (nonatomic,strong)NSMutableArray *tableViewOneArray;
/*这是储存tableViewTwo中可显示的所有数组*/
@property (nonatomic,strong)NSMutableArray *tableViewTwoArray;
/*这是存储点击tableViewOne中  tableViewTwo显示的单个数组*/
@property (nonatomic,strong)NSMutableArray *tableViewOneAndTwoArray;


@property (nonatomic,assign) CGFloat tableViewWidth;

/*关闭遮盖功能*/
@property (nonatomic,strong)UIColor *CarverViewColor;

/*遮盖的动画时间*/
@property (nonatomic,assign)CGFloat caverAnimationTime;




@end

@implementation DnHomeViewController

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point{
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.8;
    layer.fillColor = [UIColor blackColor].CGColor;
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position=point;
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
    
    self.tableViewTwoShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableViewOne.frame = CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
    }];
    self.tableViewOneShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2,CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width, 0);
    }];
    
    [self hiddenCarverView];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self createTableViewOne];
    [self createTableViewTwo];
    
  
}

- (void) initUI{
    self.lastSelectedIndex = -1;
    self.layersArray = [[NSMutableArray alloc]init];
    
   
    
    
    /*这是添加手势*/
//    self.view.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.1];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remover)];
//    tap.delegate = self;
//    [self.view addGestureRecognizer:tap];
    
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
    self.tableViewOne = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_H, self.view.frame.size.width, 0) style:UITableViewStylePlain];
    self.tableViewOne.scrollEnabled =YES;
    self.tableViewOne.separatorStyle = NO;
    self.tableViewOne.showsVerticalScrollIndicator = NO;
    self.tableViewOne.delegate = self;
    self.tableViewOne.dataSource =self;
    self.tableViewOne.autoresizesSubviews = NO;
    //[self.view addSubview:self.tableViewOne];
    [self.view insertSubview:self.tableViewOne belowSubview:self.menuView];
}

#pragma mark----创建tableTwo
- (void) createTableViewTwo{
    self.tableViewTwo = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0) style:UITableViewStylePlain];
    self.tableViewTwo.scrollEnabled =YES;
    self.tableViewTwo.separatorStyle = NO;
    self.tableViewTwo.showsVerticalScrollIndicator = NO;
    self.tableViewTwo.delegate = self;
    self.tableViewTwo.dataSource =self;
    self.tableViewTwo.autoresizesSubviews = NO;
//   [self.view addSubview:self.tableViewTwo];
    
    [self.view insertSubview:self.tableViewTwo belowSubview:self.menuView];
}

#pragma mark----表格数据初始化
- (void) createWithTableOneData:(NSInteger)dataOne{
    if (dataOne == 100) {
        self.tableViewOneArray = [[NSMutableArray alloc]initWithObjects:@"全局tableOne",@"全局tableOne",@"全局tableOne",@"全局tableOne",nil];
        
        NSArray *twoArray_1 = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5"];
        NSArray *twoArray_2 = @[@"测试一",@"测试二",@"测试三",@"测试四",@"测试五"];
        NSArray *twoArray_3 = @[@"测1",@"测2",@"测3",@"测4",@"测5"];
        NSArray *twoArray_4 = @[@"测一",@"测二",@"测三",@"测四",@"测五"];
        self.tableViewTwoArray = [[NSMutableArray alloc]initWithObjects:twoArray_1,twoArray_2,twoArray_3,twoArray_4,nil];
        self.tableViewOneAndTwoArray = [[NSMutableArray alloc]init];

        
        self.tableViewWidth = self.view.frame.size.width/2;
    }
    else if (dataOne == 101){
        self.tableViewOneArray = [[NSMutableArray alloc]initWithObjects:@"金服tableOne",@"金服tableOne",@"金服tableOne",@"金服tableOne",@"金服tableOne",@"金服tableOne", nil];
        self.tableViewWidth = self.view.frame.size.width;
        self.tableViewTwoArray = nil;
        self.tableViewOneAndTwoArray = nil;
    }
    else{
        self.tableViewOneArray = [[NSMutableArray alloc]initWithObjects:@"互联网tableOne",@"互联网tableOne",@"互联网tableOne",@"互联网tableOne",@"互联网tableOne",@"互联网tableOne", nil];
         self.tableViewWidth = self.view.frame.size.width;
        self.tableViewTwoArray = nil;
        self.tableViewOneAndTwoArray = nil;
    }
    
    
    
    
    [self.tableViewOne reloadData];

}



/*展示屏幕遮盖视图*/
- (void) showCarverView{
    //如果没有得到触摸屏幕的时间
    if (!self.caverAnimationTime) {
        self.caverAnimationTime = carverAnimationDefalutTime;
    }
//    self.view.frame =  CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, WINDOW_H-self.view.frame.origin.y);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.view.backgroundColor =  self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        
    }];
    
}

/*隐藏屏幕遮盖视图*/
- (void) hiddenCarverView{
    if(!self.caverAnimationTime){
        self.caverAnimationTime = carverAnimationDefalutTime;
    }
//    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.menuView.frame.size.height);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.view.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
    
}


- (void) showTableViewOneAndTwo:(NSInteger)index{
    
    
    self.lastSelectedIndex = index;
    [self createWithTableOneData:self.lastSelectedIndex];
    
    if (self.tableViewOneShow == NO) {
        self.tableViewOneShow = YES;
        
        //////////显示遮盖/////////////
        //[self showCarverView];
        
        CALayer *layer = self.layersArray[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        self.tableViewOne.frame = CGRectMake(0, NAVIGATION_H, self.tableViewWidth, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewOne.frame = CGRectMake( 0, NAVIGATION_H, self.tableViewWidth, 300);
        }];
    }
    else{
        CALayer *layer = self.layersArray[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        self.tableViewOneShow = NO;
        self.tableViewOne.frame = CGRectMake(0, NAVIGATION_H, self.tableViewWidth, 300);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewOne.frame = CGRectMake(0, NAVIGATION_H, self.tableViewWidth, 0);
        }];
        
        
        self.tableViewTwoShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
        }];
        
        /////////隐藏遮盖//////////
       // [self hiddenCarverView];
    }
    
   

}

- (void) showTableViewOne:(UIButton *)sender{
    if (self.lastSelectedIndex != sender.tag && self.lastSelectedIndex != -1) {
        CALayer *layer = self.layersArray[self.lastSelectedIndex - 100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewOne.frame = CGRectMake(0, 0, self.tableViewWidth, 0);
            self.tableViewTwo.frame = CGRectMake(0, NAVIGATION_H, self.view.frame.size.width, 0);
        } completion:^(BOOL finished) {
            self.tableViewTwoShow = NO;
            self.tableViewOneShow = NO;
            [self showTableViewOneAndTwo:sender.tag];
        }];
    }
    else{
        [self showTableViewOneAndTwo:sender.tag];
    }

}

- (void) showTableViewTwo:(BOOL)tableViewTwoShow{
    if (self.tableViewTwoShow == YES) {
        self.tableViewTwoShow = NO;
        //////////////显示遮盖、
        //[self showCarverView];
        
        
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 300);
        }];
        
    }
    else {
        ///////////显示遮盖///////
        //[self showCarverView];
        
        
        self.tableViewTwoShow = YES;
        self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
        }];
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableViewOne) {
        return self.tableViewOneArray.count;
    }
    else {
        return self.tableViewTwoArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableViewOne) {
        static NSString *Acell = @"Acell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Acell];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Acell];
        }
        cell.textLabel.text = self.tableViewOneArray[indexPath.row];
        //UITableViewCellAccessoryCheckmark
        //UITableViewCellAccessoryDisclosureIndicator
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        if (self.tableViewTwoArray != nil) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else {
        static NSString *Bcell = @"Bcell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Bcell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Bcell];
        }
        cell.textLabel.text = self.tableViewOneAndTwoArray[indexPath.row];
        
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.lastSelectedCellIndex = indexPath.row;
    __weak typeof(self) weakSelf = self;
    void (^complete) (void) = ^(void){
        CALayer *layer = self.layersArray [weakSelf.lastSelectedIndex-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        UIButton *btn = (id) [self.view viewWithTag:weakSelf.lastSelectedIndex];

        
        weakSelf.tableViewOneShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.tableViewOne.frame = CGRectMake(0, NAVIGATION_H, weakSelf.tableViewWidth, 0);
        }];
        
        weakSelf.tableViewTwoShow = NO;
        [UIView  animateWithDuration:0.2 animations:^{
            weakSelf.tableViewTwo.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(self.menuView.frame), self.view.frame.size.width/2, 0);
        }];
        
        
        //[weakSelf hiddenCarverView];
        
        if (weakSelf.tableViewOneAndTwoArray) {
            [btn setTitle:weakSelf.tableViewOneAndTwoArray [indexPath.row] forState:UIControlStateNormal];
            NSLog(@"您的点击是:%@    %@",self.tableViewOneArray[indexPath.row],self.tableViewOneAndTwoArray [indexPath.row]);
        }
        else{
            [btn setTitle:weakSelf.tableViewOneArray [indexPath.row] forState:UIControlStateNormal];
            NSLog(@"您的点击是:%@",self.tableViewOneArray [indexPath.row]);
        }
    };
    
    
    if (tableView == self.tableViewOne) {
        NSInteger i = indexPath.row;
        if (self.tableViewTwoArray) {
            self.tableViewOneAndTwoArray = self.tableViewTwoArray[i];
            [self.tableViewTwo reloadData];
            [self showTableViewTwo:self.tableViewTwoShow];
        }
        else{
            complete();
        }
    }
    else{
        complete();
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
