//
//  ClockViewController.h
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/06/26.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface ClockViewController : UIViewController{
    NSString *_arguments;
    AVAudioPlayer *audio;
    NSTimer *timer_;
    NSTimer *timer2;
    NSTimer *timer3;
    UIView *arrowView;
    UIView *choushinView;
    UIView *tanshinView;
    UIView *byoushinView;
    UIView *ningenView;
    UIImageView *ningenImage;
    
}

@property(nonatomic) NSString *arguments;



@end
