//
//  TuLingBotModel.m
//  XunFeAPITest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "ChatBotModel.h"
#import <AFNetworking.h>
@implementation ChatBotModel


- (void)networkLoadData:(NSString *)urlStr title:(NSString *)title input:(NSString *)input userId:(NSString *)userId{
    NSDictionary *dic = @{@"question":input,
                          @"userId":userId,
                          @"type":@0,
                          @"appSecret":@"zQOv4Hi75aTH1bBIjHFt",
                          @"appKey":@"RotQBhNi5R2K",
                          @"platform":@"custom"};
    
    
    [[HttpClient defaultClient] requestWithPath:urlStr method:HttpRequestPost parameters:dic prepareExecute:nil progress:^(NSProgress *progress) {

    } success:^(NSURLSessionDataTask *task, id responseObject) {


        

        NSString *str = [responseObject objectForKey:@"result"];
        //NSLog(@"str:%@",str);
        self->_result = str;
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadSuccess",title] object:nil];

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
   
        NSLog(@"%@LoadErrorCode:%@",title,error);
        [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat: @"%@DataLoadFailure",title] object:nil];

    }];

    
}

@end
