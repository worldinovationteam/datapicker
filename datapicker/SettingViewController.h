//
//  SettingViewController.h
//  datapicker
//
//  Created by shun-ichiro sugamura on 2014/07/04.
//  Copyright (c) 2014年 shun-ichiro sugamura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataSource;
    NSString *nickNameString;
    
}

@property(nonatomic) NSString *nickNameString_;

@end
