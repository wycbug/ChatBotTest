//
//  WYCClassBookView.h
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYCClassBookView : UIView

//+(instancetype)initWithDic:
-(void)initView:(BOOL)isFirst;
-(void)addBar:(NSArray *)date isFirst:(BOOL)isFirst;
-(void)addBtn:(NSArray *)array;
@end
