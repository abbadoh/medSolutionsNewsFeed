//
//  MasterViewController.m
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ModelManager.h"
#import "NewsPreviewModel.h"
#import "NewsPreviewTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIScrollView+SVInfiniteScrolling.h"

@interface MasterViewController ()

@property NSMutableArray<NewsPreviewModel*> *news;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.news = [NSMutableArray array];
    
    __weak typeof(self) wSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [wSelf loadMoreNewsWithCompletion:^{
            [wSelf.tableView.infiniteScrollingView stopAnimating];
        }];
    }];
    
    [self loadFirstNews];
}

-(void)loadFirstNews {
    [[ModelManager manager] getFirstNewsWithCompletion:^(OVCResponse * response, NewsErrorModel * error) {
        if (response) {
            [self addNewsToTableView:response.result];
        }
        else if (error) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:error.message
                                  message:nil
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles: nil];
            [alert show];
        }
    }];
}

-(void)loadMoreNewsWithCompletion:(void (^)())completion {
    [[ModelManager manager] getMoreNewsWithCompletion:^(OVCResponse *response, NewsErrorModel *error) {
        if (response) {
            [self addNewsToTableView:response.result];
        }
        else if (error) {
            if (error.errorCode == MDSErrorNoData) {
                self.tableView.showsInfiniteScrolling = NO;
            }
        }
        completion();
    }];
}

-(void)addNewsToTableView:(NSArray<NewsPreviewModel*>*)news {
    NSUInteger oldNewsCounter = self.news.count;
    [self.news addObjectsFromArray:news];
    NSMutableArray * paths = [NSMutableArray array];
    for (NSUInteger i = oldNewsCounter; i < self.news.count; ++i) {
        [paths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NewsPreviewModel *object = self.news[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        controller.newsPreview = object;
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsPreviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NewsPreviewModel * model = self.news[indexPath.row];
    cell.TitleLabel.text = model.title;
    cell.DateLabel.text = [model getTimeAndDateOfCreation];
    [cell.NewsPreviewImageView sd_setImageWithURL:model.imageUrl];
    
    return cell;
}

@end