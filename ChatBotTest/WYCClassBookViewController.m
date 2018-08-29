//
//  WYCClassBookViewController.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassBookViewController.h"
#import "ClassBook.h"
#import "WYCClassBookView.h"

#define DateStart @"2018-11-05"
@interface WYCClassBookViewController ()
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (nonatomic, strong) ClassBook *model;
@end

@implementation WYCClassBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadSuccessful)
                                                 name:[NSString stringWithFormat:@"%@DataLoadSuccess",self.title] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadFailure)
                                                 name:[NSString stringWithFormat:@"%@DataLoadFailure",self.title] object:nil];
//    _model = [[ClassBook alloc]init];
//    [_model getClassBookArray:@"2017210129" title:self.title];
    WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:_rootView.bounds];
    [view initView];
    NSDictionary *dic = @{};
    [view addBar:dic];
    [_rootView addSubview:view];
    [self.view addSubview:_rootView];
    [self calculateDate];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DataLoadSuccessful {
    
    
   
    
}

- (void)DataLoadFailure{
    
}

-(void)calculateDate{
    //从字符串转换日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.d"];
    NSDate *resDate = [formatter dateFromString:DateStart];
    
    //提取月、日
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|
    NSCalendarUnitDay;//获取日期的元素。
    
    NSDateComponents *d = [cal components:unitFlags fromDate:resDate];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSInteger day  =  [d day];
    NSLog(@"y:%ld,m:%ld,d:%ld",(long)year,(long)month,(long)day);

    //NSString *data = [formatter stringFromDate:resDate];
    //NSLog(@"str:%@",data);
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
