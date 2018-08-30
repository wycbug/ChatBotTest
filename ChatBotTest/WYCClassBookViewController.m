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
@interface WYCClassBookViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (nonatomic, strong) ClassBook *model;
@property (nonatomic, assign) NSInteger index;
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
    if (!_model) {
        _model = [[ClassBook alloc]init];
        [_model getClassBookArray:@"2017210129" title:self.title];
    }
    
    
    _scrollView.delegate = self;
    _index = 0;
    [self changeNavigationItem];
    //NSLog(@"%@",date.dateArray[3]);
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)DataLoadSuccessful {
   // NSLog(@"week1:%@",_model.classBookArray[0]);
    DateModle *date = [[DateModle alloc]init];
    [date initCalculateDate:DateStart];
    
    
    [_scrollView layoutIfNeeded];
    
    WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake(0*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    [view initView:YES];
    [view addBtn:_model.classBookArray[0]];
    NSArray *dateArray = @[];
    [view addBar:dateArray isFirst:YES];
    [_scrollView addSubview:view];
    
    @autoreleasepool {
        for (int i = 0; i < date.dateArray.count; i++) {
            WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake((i+1)*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
            [view initView:NO];
            [view addBtn:_model.classBookArray[i]];
            [view addBar:date.dateArray[i] isFirst:NO];
            [_scrollView addSubview:view];
        }
        
        [_scrollView layoutSubviews];
        _scrollView.contentSize = CGSizeMake(date.dateArray.count * _scrollView.frame.size.width, 0);
        _scrollView.pagingEnabled = YES;
    }
    [_rootView addSubview:_scrollView];
    [self.view addSubview:_rootView];

    
    
}

- (void)DataLoadFailure{
    UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"网络错误" message:@"数据加载失败" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [controller addAction:act1];
    
    [self presentViewController:controller animated:YES completion:^{
        
    }];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _index = (long)roundf(scrollView.contentOffset.x/_scrollView.frame.size.width);
   // NSLog(@"index:%ld",(long)_index);
    [self changeNavigationItem];
    
}

-(void)changeNavigationItem{
    NSArray *title = @[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周",@"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"];
    self.title = title[_index];
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
