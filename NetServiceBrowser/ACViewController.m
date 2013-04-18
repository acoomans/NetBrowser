//
//  ACViewController.m
//  NetServiceBrowser
//
//  Created by Arnaud Coomans on 4/17/13.
//  Copyright (c) 2013 acoomans. All rights reserved.
//

// see https://developer.apple.com/library/mac/#documentation/networking/Conceptual/NSNetServiceProgGuide/Articles/BrowsingForServices.html#//apple_ref/doc/uid/20001077-SW4

#import "ACViewController.h"
#import "MLTableAlert.h"

@interface ACViewController ()

@end

@implementation ACViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.netServices = [[NSMutableArray alloc] init];
        self.searching = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)showServices {
    
    //NSLog(@"%@", self.netServices);
    
	self.tableAlert = [MLTableAlert tableAlertWithTitle:@"Net Services"
                                 cancelButtonTitle:@"Cancel"
                                      numberOfRows:^NSInteger(NSInteger section) {
                                          return [self.netServices count];
                                      } andCells:^UITableViewCell *(MLTableAlert *alert, NSIndexPath *indexPath) {
                                          static NSString *cellIdentifier = @"cellIdentifier";
                                          UITableViewCell *cell = [alert.table dequeueReusableCellWithIdentifier:cellIdentifier];
                                          if (cell == nil)
                                              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                                          
                                          cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.netServices[indexPath.row] name]];
                                          
                                          return cell;
                                      }];
	self.tableAlert.height = 350;
	
	[self.tableAlert configureSelectionBlock:^(NSIndexPath *indexPath) {
        NSNetService *netService = self.netServices[indexPath.row];
        self.label.text = [NSString stringWithFormat:@"%@ (%@)",
                           netService.name,
                           netService.type
                           ];
	} andCompletionBlock:^{
        self.label.text = @"";
	}];
    
	[self.tableAlert show];
    
}

#pragma mark - actions

- (IBAction)browseButtonTapped:(id)sender {
    self.netServiceBrowser = [[NSNetServiceBrowser alloc] init];
    [self.netServiceBrowser setDelegate:self];
    [self.netServiceBrowser searchForServicesOfType:@"_test._tcp" inDomain:@""];
}


#pragma mark - NSNetServiceBrowserDelegate

- (void)netServiceBrowserWillSearch:(NSNetServiceBrowser *)browser {
    self.searching = YES;
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)browser {
    self.searching = NO;
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser
             didNotSearch:(NSDictionary *)errorDict {
    self.searching = NO;
    NSLog(@"Error code: %@", [errorDict objectForKey:NSNetServicesErrorCode]);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser
           didFindService:(NSNetService *)aNetService
               moreComing:(BOOL)moreComing {
    
    [self.netServices addObject:aNetService];
    if (!moreComing) {
        [self showServices];
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser
         didRemoveService:(NSNetService *)aNetService
               moreComing:(BOOL)moreComing {
    
    [self.netServices removeObject:aNetService];
    if (!moreComing) {
        [self showServices];
    }
}

@end