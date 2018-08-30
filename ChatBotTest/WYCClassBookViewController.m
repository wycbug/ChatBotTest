//
//  WYCClassBookViewController.m
//  ChatBotTest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCClassBookViewController.h"
#import "ClassBook.h"
#import "DateModle.h"
#import "WYCClassBookView.h"

#define DateStart @"2018-03-05"
@interface WYCClassBookViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
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
    _model = [[ClassBook alloc]init];
    [_model getClassBookArray:@"2017210129" title:self.title];
    
//    DateModle *date = [[DateModle alloc]init];
//    [date initCalculateDate:DateStart];
//    
//    
//    [_scrollView layoutIfNeeded];
//    
//    WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake(0*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
//    [view initView:YES];
//    [view addBtn];
//    NSArray *dateArray = @[];
//    [view addBar:dateArray isFirst:YES];
//    [_scrollView addSubview:view];
//    
//    @autoreleasepool {
//        for (int i = 0; i < date.dateArray.count; i++) {
//            WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake((i+1)*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
//            [view initView:NO];
//            [view addBtn];
//            [view addBar:date.dateArray[i] isFirst:NO];
//            [_scrollView addSubview:view];
//        }
//        
//        [_scrollView layoutSubviews];
//        _scrollView.contentSize = CGSizeMake(date.dateArray.count * _scrollView.frame.size.width, 0);
//        _scrollView.pagingEnabled = YES;
//    }
//    [_rootView addSubview:_scrollView];
//    [self.view addSubview:_rootView];
    
    //NSLog(@"%@",date.dateArray[3]);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DataLoadSuccessful {
   // NSLog(@"week1:%@",_model.classBookArray[0]);
    
    
    
}

- (void)DataLoadFailure{
    
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
