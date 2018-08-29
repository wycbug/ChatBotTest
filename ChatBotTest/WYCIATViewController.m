//
//  WYCIATViewController.m
//  XunFeAPITest
//
//  Created by 王一成 on 2018/8/29.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import "WYCIATViewController.h"
#import "IFlyMSC/IFlyMSC.h"
#import "WYCISRDataHelper.h"
@interface WYCIATViewController ()<IFlySpeechRecognizerDelegate>
//不带界面的识别对象
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
/**生成的字符*/
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutlet UIButton *pressToSpeech;
@property(nonatomic,strong) NSString *resultStringFromJson;
/**当前是否可以进行录音*/
@property(nonatomic,assign) BOOL isStartRecord;
/**是否已经开始播放*/
@property(nonatomic,assign) BOOL ishadStart;

@end

@implementation WYCIATViewController

#pragma mark - 懒加载

-(IFlySpeechRecognizer *)iFlySpeechRecognizer
{
    if (!_iFlySpeechRecognizer) {
        //创建语音识别对象
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        //设置识别参数
        //设置为听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        //asr_audio_path 是录音文件名，设置 value 为 nil 或者为空取消保存，默认保存目录在 Library/cache 下。
        [_iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        //设置最长录音时间:60秒
        [_iFlySpeechRecognizer setParameter:@"-1" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置语音后端点:后端点静音检测时间，即用户停止说话多长时间内即认为不再输入， 自动停止录音
        [_iFlySpeechRecognizer setParameter:@"10000" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置语音前端点:静音超时时间，即用户多长时间不说话则当做超时处理
        [_iFlySpeechRecognizer setParameter:@"5000" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"2000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //设置语言
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        //设置方言
        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        //设置代理
        _iFlySpeechRecognizer.delegate = self;
    }
    return _iFlySpeechRecognizer;
}


#pragma mark - 系统方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.isStartRecord = YES;
    //初始化字符串,否则无法拼接
    self.resultStringFromJson = @"";
    [self.view addSubview:_resultLabel];

    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressActionFromLongPressBtn:)];
    longpress.minimumPressDuration = 0.1;
    [_pressToSpeech addGestureRecognizer:longpress];
}


#pragma mark - 自定义方法

-(void)longPressActionFromLongPressBtn:(UILongPressGestureRecognizer *)longPress
{
  
    CGPoint currentPoint = [longPress locationInView:longPress.view];
    
    if (self.isStartRecord) {
        self.resultStringFromJson = @"";
        
        //启动识别服务
        [self.iFlySpeechRecognizer startListening];
        self.isStartRecord = NO;
        self.ishadStart = YES;
    
    }
    //如果上移的距离大于20,就提示放弃本次录音
    if (currentPoint.y < -20) {
   
        self.ishadStart = NO;
        [_pressToSpeech setTitle:@"取消录音" forState:UIControlStateNormal];
    }
    else
    {
        if (self.ishadStart == NO) {
            
            self.ishadStart = YES;
        }
    }
    if (longPress.state == UIGestureRecognizerStateEnded) {
        self.isStartRecord = YES;
        if (currentPoint.y < -60) {
            [self.iFlySpeechRecognizer cancel];
        }
        else
        {
            [self.iFlySpeechRecognizer stopListening];
        }
       
    }
    
}


//IFlySpeechRecognizerDelegate协议实现
//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    //持续拼接语音内容
    self.resultStringFromJson = [self.resultStringFromJson stringByAppendingString:[WYCISRDataHelper stringFromJson:resultString]];
    NSLog(@"self.resultStringFromJson = %@",self.resultStringFromJson);
    _resultLabel.text = _resultStringFromJson;
}
//识别会话结束返回代理
- (void)onError: (IFlySpeechError *) error{
    NSLog(@"error = %@",[error description]);
}

//停止录音回调
-(void)onEndOfSpeech
{
    self.isStartRecord = YES;
    [_pressToSpeech setTitle:@"长按开始语音识别" forState:UIControlStateNormal];
}

//开始录音回调
-(void)onBeginOfSpeech
{
    //    NSLog(@"onbeginofspeech");
}

//音量回调函数
-(void)onVolumeChanged:(int)volume
{
    
}

//会话取消回调
-(void)onCancel
{
    NSLog(@"取消本次录音");
    [_pressToSpeech setTitle:@"长按开始语音识别" forState:UIControlStateNormal];
    _resultLabel.text = @"";
}


@end

