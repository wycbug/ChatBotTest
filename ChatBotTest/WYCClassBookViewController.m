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
#import "SegmentView.h"
#import "WYCClassBookView.h"
#import "WYCScrollViewBar.h"

#define DateStart @"2018-03-05"
@interface WYCClassBookViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (nonatomic, strong) ClassBook *model;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, strong) UINavigationItem *navigationItem;
@property (nonatomic, assign) BOOL hiddenScrollViewBar;
@property (nonatomic, strong) WYCScrollViewBar *scrollViewBar;
@end

@implementation WYCClassBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index = 0;
    _hiddenScrollViewBar = YES;
    
    _titleArray = @[@"整学期",@"第一周",@"第二周",@"第三周",@"第四周",@"第五周",@"第六周",@"第七周",@"第八周",@"第九周",@"第十周",@"第十一周",@"第十二周",@"第十三周",@"第十四周",@"第十五周",@"第十六周",@"第十七周",@"第十八周",@"第十九周",@"第二十周",@"第二十一周",@"第二十二周",@"第二十三周",@"第二十四周",@"第二十五周"];
    [self changeNavigationItemTitle];
    _navigationItem = [[UINavigationItem alloc]init];
    [self buildMyNavigationbar];
    self.navigationItem = _navigationItem;
    
    _scrollViewBar = [[WYCScrollViewBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 39*autoSizeScaleY) andArray:_titleArray];
    
    _scrollViewBar.hidden = _hiddenScrollViewBar;
    
    [self.view addSubview:_scrollViewBar];
    
   
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadSuccessful)
                                                 name:[NSString stringWithFormat:@"%@DataLoadSuccess",self.title] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadFailure)
                                                 name:[NSString stringWithFormat:@"%@DataLoadFailure",self.title] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateScrollViewOffSet)
                                                 name:@"ScrollViewBarChanged" object:nil];
    if (!_model) {
        _model = [[ClassBook alloc]init];
        [_model getClassBookArray:@"2017210129" title:self.title];
    }
    
    
    
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
    NSArray *dateArray = @[];
    [view addBar:dateArray isFirst:YES];
    [view addBtn:_model.classBookArray[0]];
    [view chackBigLesson];
    [_scrollView addSubview:view];
    
    @autoreleasepool {
        for (int i = 0; i < date.dateArray.count; i++) {
            WYCClassBookView *view = [[WYCClassBookView alloc]initWithFrame:CGRectMake((i+1)*_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
            [view initView:NO];
            [view addBar:date.dateArray[i] isFirst:NO];
            [view addBtn:_model.classBookArray[i]];
            [view chackBigLesson];
            [_scrollView addSubview:view];
        }
    }
    [_scrollView layoutSubviews];
    _scrollView.contentSize = CGSizeMake(date.dateArray.count * _scrollView.frame.size.width, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    
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
    NSLog(@"index:%ld",_index);
   // NSLog(@"index:%ld",(long)_index);
    [self changeNavigationItemTitle];
    [self buildMyNavigationbar];
    [_scrollViewBar changeIndex:_index];
    
}

-(void)changeNavigationItemTitle{
    
    _titleText = _titleArray[_index];
    
}
- (void)buildMyNavigationbar{
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"加号"] style:UIBarButtonItemStylePlain target:self action:@selector(addNote)];
    self.navigationItem.rightBarButtonItem = right;
    
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-40, 0, 80, 40)];
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleView.frame.size.width/2-30, 0, 60, titleView.frame.size.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = _titleText;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.userInteractionEnabled = YES;
    UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSegmentView)];
    [titleLabel addGestureRecognizer:tapGesture];
    [titleView addSubview:titleLabel];
    
    
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:CGRectMake(titleView.frame.size.width/2+30, 0, 9, titleView.frame.size.height)];
    //展开是下箭头，不展开是上箭头
    if (_hiddenScrollViewBar) {
        [detailBtn setImage:[UIImage imageNamed:@"下箭头"] forState:UIControlStateNormal];
    }else{
    [detailBtn setImage:[UIImage imageNamed:@"上箭头"] forState:UIControlStateNormal];
    }
    [detailBtn addTarget: self action:@selector(showSegmentView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview: detailBtn];
    
    _navigationItem.titleView = titleView;
}

-(void)showSegmentView{
    if (_hiddenScrollViewBar) {
        _hiddenScrollViewBar = NO;
        _scrollViewBar.hidden = _hiddenScrollViewBar;
        [self buildMyNavigationbar];
        [self updateScrollViewFame];
        
    }else{
        _hiddenScrollViewBar = YES;
        _scrollViewBar.hidden = _hiddenScrollViewBar;
        [self buildMyNavigationbar];
         [self updateScrollViewFame];
    }
    
}
-(void)updateScrollViewFame{
    if (_hiddenScrollViewBar) {
        [_rootView setFrame:CGRectMake(0, 0, _rootView.frame.size.width, _rootView.frame.size.height)];
        [_rootView layoutIfNeeded];
        [_rootView layoutSubviews];
        for (int i = 0; i < _scrollView.subviews.count; i++) {
            WYCClassBookView *view = _scrollView.subviews[i];
            [view changeScrollViewContentSize:CGSizeMake(0, 606*autoSizeScaleY)];
            [view layoutIfNeeded];
            [view layoutSubviews];
        }
    }else{
        [_rootView setFrame:CGRectMake(0, _scrollViewBar.frame.size.height, _rootView.frame.size.width, _rootView.frame.size.height)];
        [_rootView layoutIfNeeded];
        [_rootView layoutSubviews];
        for (int i = 0; i < _scrollView.subviews.count; i++) {
            WYCClassBookView *view = _scrollView.subviews[i];
            [view changeScrollViewContentSize:CGSizeMake(0, 606*autoSizeScaleY + _scrollViewBar.frame.size.height)];
            [view layoutIfNeeded];
            [view layoutSubviews];
        }
    }
}
-(void)updateScrollViewOffSet{
    _index = _scrollViewBar.index;
    [UIView animateWithDuration:0.2f animations:^{
        self->_scrollView.contentOffset = CGPointMake(self->_index*self->_scrollView.frame.size.width,0);
    } completion:nil];
   
}
-(void)addNote{
    
    _scrollViewBar.index = _scrollViewBar.index + 1;
    NSLog(@"barindex:%ld",_scrollViewBar.index);
    [_scrollViewBar changeIndex:_index];
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
