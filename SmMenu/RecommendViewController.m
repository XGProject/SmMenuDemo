//
//  RecommendViewController.m
//  SmMenu
//
//  Created by 厦航 on 16/4/6.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "RecommendViewController.h"

@interface RecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *CollectionView;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor colorWithRed:34/255.0 green:188/255.0 blue:86/255.0 alpha:1.0];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.CollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];

    self.CollectionView.delegate = self;
    self.CollectionView.dataSource = self;
    [self.view addSubview:self.CollectionView];
    [self.CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"aCell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

/*这是返回SectionTitle的方法*/
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor redColor];
        reusableview = headerView;
    }
    return reusableview;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width-65)/5, 50);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aCell = @"aCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:aCell forIndexPath:indexPath];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.cornerRadius = 5;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,(self.view.frame.size.width-40)/5, 40)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"哈啊哈";
    label.textAlignment = UITextAlignmentCenter;
    [cell addSubview:label];
    
    return cell;
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
