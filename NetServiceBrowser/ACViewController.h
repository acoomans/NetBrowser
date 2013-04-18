//
//  ACViewController.h
//  NetServiceBrowser
//
//  Created by Arnaud Coomans on 4/17/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLTableAlert;

@interface ACViewController : UIViewController <NSNetServiceBrowserDelegate>

@property (strong, nonatomic) NSNetServiceBrowser *netServiceBrowser;
@property (strong, nonatomic) NSMutableArray *netServices;
@property (assign, nonatomic) BOOL searching;
@property (assign, nonatomic) MLTableAlert *tableAlert;
@property (assign, nonatomic) IBOutlet UILabel *label;

@end
