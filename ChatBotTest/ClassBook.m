//
//  ClassBook.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "ClassBook.h"
#import "HttpClient.h"
#define URL @"https://wx.idsbllp.cn/api/kebiao"
@implementation ClassBook


- (void)getClassBookArray:(NSString *)stu_Num title:(NSString *)title {
    
    NSDictionary *parameters = @{@"stu_num":stu_Num};
    
   [[HttpClient defaultClient] requestWithPath:URL method:HttpRequestPost parameters:parameters prepareExecute:nil progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        //获取测试用dic
        //NSLog(@"%@Modle连接成功",title);
        NSArray *array = [responseObject objectForKey:@"data"];
        self->_classBookArray = [[NSMutableArray alloc]init];
        [self transform:array];
        //NSLog(@"classbookArray:%@",array);
        self->_nowWeek = [responseObject objectForKey:@"nowWeek"];
        //NSLog(@"week1:%@",self->_classBookArray[0]);
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadSuccess",title] object:nil];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //NSLog(@"%@Modle连接失败",title);
        NSLog(@"%@LoadErrorCode:%@",title,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadFailure",title] object:nil];
        
    }];
    
}
-(void)transform:(NSArray*)array{
    
    for (int weeknum = 1; weeknum <= 25; weeknum++) {
        NSMutableArray *tmp = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < array.count; i++) {
            //NSLog(@"%lu",(unsigned long)array.count);
            NSArray *week = [array[i] objectForKey:@"week"];
            
            
            for (int j = 0;j < week.count; j++) {
                //NSLog(@"%lu",(unsigned long)week.count);
                NSNumber *k = week[j];
                //NSLog(@"%@",k);
                if (weeknum == k.intValue) {
                    [tmp addObject:array[i]];
                }
            }
            
            
        }
        //NSLog(@"%lu",(unsigned long)tmp.count);
        [_classBookArray addObject:tmp];
        
    }
    
}



@end
