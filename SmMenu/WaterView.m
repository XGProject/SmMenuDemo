//
//  WaterView.m
//  SmMenu
//
//  Created by 厦航 on 16/4/25.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "WaterView.h"

@interface WaterView (){
    float a;
    float b;
    BOOL jia;
}


@end


@implementation WaterView
/*初始化本类*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        a = 1.5;
        b = 0;
        jia = NO;
    
        [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(AnimateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
