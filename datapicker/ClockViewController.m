//
//  ClockViewController.m
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/06/26.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ClockViewController.h"

#define SLIDEWIDTH  320
#define SLIDEHEIGHT  54

@interface ClockViewController() 

@end

@implementation ClockViewController
UILabel *clockLabel;


@synthesize arguments = _arguments;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //画像のセット
    //背景設定
    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    backGroundImage.image = [UIImage imageNamed:@"background.png"];
    [self.view addSubview:backGroundImage];
    
    //ロック解除スライダー
    UIView *unlockedsliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 480-SLIDEHEIGHT, SLIDEWIDTH, SLIDEHEIGHT)];
    [self.view addSubview:unlockedsliderView];
    
    UIImageView *sliderImage = [[UIImageView alloc] initWithFrame:unlockedsliderView.bounds];
    sliderImage.image = [UIImage imageNamed:@"unlockedslider.png"];
    [unlockedsliderView addSubview:sliderImage];
    
    
    //文字ラベル
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 13, 200, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    label.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mojihaikei.png"]];
    label.text = @"STOP ALERM";
    label.alpha = 0.5;
    [unlockedsliderView addSubview:label];
    
    
    
    //矢印スライダー画像
    arrowView = [[UIView alloc] initWithFrame:CGRectMake(24, 436, 56, 38)];
    [self.view addSubview:arrowView];

    
    UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:arrowView.bounds];
    arrowImage.image = [UIImage imageNamed:@"arrow.png"];
    [arrowView addSubview:arrowImage];
    
    
    
    //時計の画像
    UIView *clockareaView = [[UIView alloc] initWithFrame:CGRectMake(self.view.center.x-200/2, self.view.center.y-200/2 -55
                                                                     , 200, 200)];
    
    [self.view addSubview:clockareaView];
    
    UIImageView *mojibanImage = [[UIImageView alloc] initWithFrame:clockareaView.bounds];
    mojibanImage.image = [UIImage imageNamed:@"mojiban2.png"];
    [clockareaView addSubview:mojibanImage];
    
    //長針の画像
    choushinView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, 200, 10)];
    [clockareaView addSubview:choushinView];
    
    UIImageView *choushinImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 75, 10)];
    
    choushinImage.image = [UIImage imageNamed:@"choushin.png"];
    [choushinView addSubview:choushinImage];
    
    //短針の画像
    tanshinView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, 200, 10)];
    [clockareaView addSubview:tanshinView];
    
    UIImageView *tanshinImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 55, 10)];
    tanshinImage.image = [UIImage imageNamed:@"tanshin2.png"];
    [tanshinView addSubview:tanshinImage];
    
    //秒針の画像
    byoushinView = [[UIView alloc] initWithFrame:CGRectMake(0, 95, 200, 10)];
    [clockareaView addSubview:byoushinView];

    UIImageView *byoushinImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 1, 60, 8)];
    byoushinImage.image = [UIImage imageNamed:@"byoushin.png"];
    [byoushinView addSubview:byoushinImage];
    
    //シルエットの画像
    ningenView = [[UIView alloc] initWithFrame:CGRectMake(40, 330, 52, 80)];
    [self.view addSubview:ningenView];
    
    ningenImage = [[UIImageView alloc] initWithFrame:ningenView.bounds];
    ningenImage.image = [UIImage imageNamed:@"ningen1.png"];
    [ningenView addSubview:ningenImage];
    

    
    
    
    //ドラッグしたときの動作設定
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panAction:)];
    [arrowView addGestureRecognizer:pan];
    

    
    //タイマーのセット
    timer_ = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(checkTimeAndPlayMusic:)
                                   userInfo:nil
                                    repeats:YES];
    
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                              target:self
                                            selector:@selector(moveClock:)
                                            userInfo:nil
                                             repeats:YES];
    
    
    /*timer3 = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                              target:self
                                            selector:@selector(moveImage:)
                                            userInfo:nil
                                             repeats:YES];

    */
    
    
    
    //送られくる時間を確認する文字列表示
    UILabel *setString = [[UILabel alloc] initWithFrame:CGRectMake(90, 293, 160, 15)];
    setString.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fire.png"]];
    setString.text = @"アラーム設定時刻";
    [self.view addSubview:setString];
    
    
    UILabel *setTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 310, 160, 20)];
    setTimeLabel.textColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fire.png"]];
    setTimeLabel.text = _arguments;
    [self.view addSubview:setTimeLabel];
    
    
    //現在時刻を表示
    //clockLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 160, 20)];
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(fire)
                                   userInfo:nil
                                    repeats:YES];
    [self.view addSubview:clockLabel];
    [self fire];
    
    
    
    

    
    
    
}

//画像を動かす！
/*-(void)moveImage:(NSTimer*)timer{
    [UIView animateWithDuration:1000.0f
                          delay:0.5f options:UIViewAnimationOptionRepeat
                    animations:^{
                        CGAffineTransform t = CGAffineTransformMakeTranslation(100, 0);
                       ningenView.transform = CGAffineTransformTranslate(t, 100, 0);
                  } completion:^(BOOL finished){
                      nil;
                 }];
}*/




//時計を動かす処理
-(void)moveClock:(NSTimer*)timer{
    NSDate *date = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    unsigned flags = NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:date];
    int hour = [todayComponents hour];
    int min =  [todayComponents minute];
    int sec = [todayComponents second];
    
    
    choushinView.transform = CGAffineTransformMakeRotation(M_PI / 30 * min + M_PI /1800 *sec - M_PI_2);
    tanshinView.transform = CGAffineTransformMakeRotation(M_PI / 6 * (hour % 12) + M_PI / 360 *min  - M_PI_2);
    byoushinView.transform = CGAffineTransformMakeRotation(M_PI / 30 *sec - M_PI_2);
}




-(void)fire{
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    [format setTimeZone:[NSTimeZone defaultTimeZone]];
    clockLabel.text = [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
    [clockLabel sizeToFit];
}

//現在時刻とアラームの時間が合っているかチェックして音楽を流す関数
-(void)checkTimeAndPlayMusic:(NSTimer*)timer{
    NSDate *date = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    unsigned flags = NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    NSDateComponents *todayComponents = [calender components:flags fromDate:date];
    int hour = [todayComponents hour];
    int min =  [todayComponents minute];
    //int sec = [todayComponents second];
    NSString *nowTime = [NSString stringWithFormat:@"%02d:%02d",hour,min];
    NSString *setTime = _arguments;
    
    
    if ([nowTime isEqualToString:setTime]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"etranze" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        audio.currentTime = 148.0f;
        [audio prepareToPlay];
        [audio play];
        [timer_ invalidate];

    }
    
}


//ロック解除スライダーがドラッグされたときの処理
-(void)panAction:(UIPanGestureRecognizer *)sender{
    
    
    CGPoint p = [sender translationInView:arrowView];
    
    CGPoint movePoint = CGPointMake(arrowView.center.x + p.x, arrowView.center.y );
    if (movePoint.x - 52 <= 0) {
        movePoint.x = 52;
    }else if (320 - movePoint.x < 52){
        movePoint.x = 268;
    }
    
    arrowView.center = movePoint;
    
        
    [sender setTranslation:CGPointZero inView:arrowView];
    

    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (320 - arrowView.center.x == 52) {
            if ([audio isPlaying]) {
                [audio stop];
                [audio prepareToPlay];
                            }
            
            [timer_ invalidate];
            [self dismissViewControllerAnimated:YES completion:nil];

        }else{
            
            
        [UIView beginAnimations:NULL context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.01f];
        
        arrowView.frame = CGRectMake(24, 436, 56, 38);
        
            [UIView commitAnimations];
        }
    }
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
