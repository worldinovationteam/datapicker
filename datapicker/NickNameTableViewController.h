//
//  NickNameTableViewController.h
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/14.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NickNameDelegate;


@interface NickNameTableViewController : UITableViewController<UITextFieldDelegate>
{
    NSArray *dataSource;
    UITextField *nickNameTextfld;
    NSString *nickNameString;
   
}

@property(nonatomic ,assign) id<NickNameDelegate> delegate;

@end



@protocol NickNameDelegate <NSObject>

-(void)nicknametableviewcontroller:(NickNameTableViewController *)nicknametableviewcontroller didClose:(NSString*)message;

@end
