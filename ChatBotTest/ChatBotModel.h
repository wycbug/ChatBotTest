//
//  TuLingBotModel.h
//  XunFeAPITest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"
@interface ChatBotModel : NSObject


@property (nonatomic, copy)NSString *result;
- (void)networkLoadData:(NSString *)urlStr title:(NSString *)title input:(NSString *)input userId:(NSString *)uesrId;
@end
