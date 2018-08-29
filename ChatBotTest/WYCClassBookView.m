//
//  WYCClassBookView.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassBookView.h"
#import "Masonry.h"
#import "UIColor+Hex.h"
@interface WYCClassBookView()

@property (nonatomic, strong) UIView *bar;
@property (nonatomic, strong) UIView *month;
@property (nonatomic, strong) UIView *dayBar;
@end
@implementation WYCClassBookView

-(void)initView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    _month = [[UIView alloc]init];
    _month.backgroundColor = [UIColor redColor];
    
    _dayBar = [[UIView alloc]init];
    _dayBar.backgroundColor = [UIColor clearColor];
  
    
    
    
    _bar = [[UIView alloc]init];
    _bar.backgroundColor = [UIColor colorWithHexString:@"#EEF6FD"];
   
    [_bar addSubview:_month];
    [_bar addSubview:_dayBar];
    
    [self addSubview:_bar];
    
    
    
    
    
    [_month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_bar.mas_top).offset(0);
        make.left.equalTo(self->_bar.mas_left).offset(0);
        make.bottom.equalTo(self->_bar.mas_bottom).offset(0);
        make.width.mas_equalTo(31*autoSizeScaleX);
        
    }];
    
    [_dayBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_bar.mas_top).offset(0);
        make.left.equalTo(self->_month.mas_right).offset(0);
        make.bottom.equalTo(self->_bar.mas_bottom).offset(0);
        make.right.equalTo(self->_bar.mas_right).offset(0);
        
    }];
   
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(49*autoSizeScaleY);
        
    }];
    
}
-(void)addBar:(NSDictionary *)date{
    [_dayBar layoutIfNeeded];
    
    NSArray *day = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    for (int i = 0 ; i<7; i++) {
        
        UIView *dayItem = [[UIView alloc]init];
        CGFloat dayItemWidth = _dayBar.frame.size.width/7;
        CGFloat dayItemHeight = _dayBar.frame.size.height;
        //NSLog(@"w:%f",dayItemWidth);
        //NSLog(@"h:%f",dayItemHeight);
        [dayItem setFrame:CGRectMake(i*dayItemWidth, 0, dayItemWidth, dayItemHeight)];
        
        //添加星期几
        UILabel *weekLabel = [[UILabel alloc]init];
        weekLabel.text = day[i];
        weekLabel.font = [UIFont systemFontOfSize:12];
        weekLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        [weekLabel setFrame:CGRectMake(0, 0, dayItem.frame.size.width, dayItem.frame.size.height/2)];
        [dayItem addSubview:weekLabel];
        //添加日期
        UILabel *dayLabel = [[UILabel alloc]init];
        dayLabel.text = day[i];
        dayLabel.font = [UIFont systemFontOfSize:12];
        dayLabel.textColor = [UIColor colorWithHexString:@"#7097FA"];
        dayLabel.textAlignment = NSTextAlignmentCenter;
        [dayLabel setFrame:CGRectMake(0, dayItem.frame.size.height/2, dayItem.frame.size.width, dayItem.frame.size.height/2)];
        [dayItem addSubview:dayLabel];
        
        [_dayBar addSubview:dayItem];
    }
    [_dayBar layoutSubviews];
}


@end
