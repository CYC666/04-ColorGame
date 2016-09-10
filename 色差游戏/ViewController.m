//
//  ViewController.m
//  色差游戏
//
//  Created by mac on 16/7/14.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ViewController.h"
#import "ColorGameView.h"

@interface ViewController () {
    NSLock *_lock;
    ColorGameView *_colorView;

}
@property (weak, nonatomic) IBOutlet UILabel *score;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lock = [[NSLock alloc] init];
    self.view.backgroundColor = [UIColor cyanColor];
    _colorView = [[ColorGameView alloc] initWithFrame:CGRectZero];
    //游戏还未开始，不能点击
    _colorView.userInteractionEnabled = NO;
    [self.view addSubview:_colorView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"count"
                                               object:nil];
    
}


- (IBAction)start:(UIButton *)sender {
    
    //开始计时，按钮不能再按下
    sender.enabled = NO;
    //能点击了
    _colorView.userInteractionEnabled = YES;
    //发送通知，刷新一下集合视图，使其初始为四个单元
    [[NSNotificationCenter defaultCenter] postNotificationName:@"start" object:nil];
    sender.tag = 4980;
    //时间重置60秒
    _time.text = @"60";
    //得分重置0分
    _score.text = @"0";
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(timerAction:)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)timerAction:(NSTimer *)timer {
    
    _time.text = [NSString stringWithFormat:@"%ld", [_time.text integerValue] - 1];
    if ([_time.text integerValue] < 0) {
        //关闭定时器，防止与下一个定时器重复
        [timer invalidate];
        _time.text = @"0";
        UIButton *button = [self.view viewWithTag:4980];
        //恢复按钮可按状态
        button.enabled = YES;
        //不能再点击了
        _colorView.userInteractionEnabled = NO;
        //游戏结束,弹出提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"游戏结束"
                                                                       message:_score.text
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"继续游戏"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     NSLog(@"继续游戏");
                                                 }]];
        [self presentViewController:alert animated:YES completion:nil];
        
    } 
    
}

- (void)receiveNotification:(NSNotification *)notification {
    _score.text = notification.object;
}





































@end
