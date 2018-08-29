//
//  WYCChatBotViewController..m
//  XunFeAPITest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCChatBotViewController.h"
#import "ChatBotModel.h"
#define URL @"http://cloud.xiaoi.com/apiDebug/apiDebug!ask.do"
#define UserID @"api-quhycgct"
@interface WYCChatBotViewController ()
@property (nonatomic, strong)  ChatBotModel *model;
@property (strong, nonatomic) IBOutlet UITextField *input;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, copy) NSString *userID;
@end

@implementation WYCChatBotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(DataLoadSuccessful)
                                                 name:[NSString stringWithFormat:@"%@DataLoadSuccess",self.title] object:nil];
    
    _model = [[ChatBotModel alloc]init];
    
//    _userID = @"api-quhycgct";
    
    
    
    //NSLog(@"result:%@",_model.dic);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)send:(UIButton *)sender {
    
    if ([_input.text isEqualToString:@""]) {
        UIAlertController *controller=[UIAlertController alertControllerWithTitle:@"参数错误" message:@"不能发送空消息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act1=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [controller addAction:act1];
        
        [self presentViewController:controller animated:YES completion:^{
            
        }];
    }else{
    [_model networkLoadData:URL title:self.title input:_input.text userId:UserID];
    }
}

- (void)DataLoadSuccessful {
// NSLog(@"result:%@",_model.result);
    _resultLabel.text = _model.result;
    _input.text = @"";
}

- (void)DataLoadFailure{
   NSLog(@"failresult:%@",_model.result);
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
