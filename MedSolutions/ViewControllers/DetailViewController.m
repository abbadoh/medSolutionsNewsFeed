//
//  DetailViewController.m
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "DetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModelManager.h"
#import "NewsModel.h"
#import "SpotlightView.h"
#import "TTTAttributedLabel.h"

@interface DetailViewController () <SpotlightViewDelegate, TTTAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *newsSoucreUrlLabel;

@property (weak, nonatomic) IBOutlet SpotlightView *leftSpotlightViewContainer;
@property (strong, nonatomic) SpotlightView * leftSpotlightView;
@property (weak, nonatomic) IBOutlet SpotlightView *rightSpotlightViewContainer;
@property (strong, nonatomic) SpotlightView *rightSpotlightView;

@property (strong, nonatomic) NewsModel * news;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setNewsPreview:(id)newDetailItem {
    if (_newsPreview != newDetailItem) {
        _newsPreview = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    [self initSpotlights];
    
    if (self.newsPreview) {
        [self.mainImageView sd_setImageWithURL:self.newsPreview.imageUrl];
        self.title = self.newsPreview.title;
        

        [[ModelManager manager] getNewsDesctiptionForNewsWithId:self.newsPreview.newsId completion:^(OVCResponse *response, NewsErrorModel *error) {
            if (response) {
                self.news = response.result;
                self.textLabel.text = [self.news getDataModel].text;
                self.dateLabel.text = [self.newsPreview getTimeAndDateOfCreation];
                
                NSRange range = [self.newsSoucreUrlLabel.text rangeOfString:self.newsSoucreUrlLabel.text];
                [self.newsSoucreUrlLabel addLinkToURL:[self.news getDataModel].sourceUrl withRange:range]; // Embedding a custom link in a substring                
                
                [self.leftSpotlightView initWithNewsPreviewModel:[self.news getFirstSpotlight]];
                [self.rightSpotlightView initWithNewsPreviewModel:[self.news getSecondSpotligt]];
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
}

-(void)initSpotlights {
    SpotlightView *leftSpotlightView = [[[NSBundle mainBundle] loadNibNamed:@"SpotlightView" owner:self options:nil] lastObject];
    leftSpotlightView.frame = self.leftSpotlightViewContainer.frame;
    self.leftSpotlightView = leftSpotlightView;
    [self.leftSpotlightViewContainer addSubview: self.leftSpotlightView];
    self.leftSpotlightView.delegate = self;
    
    SpotlightView *rightSpotlightView = [[[NSBundle mainBundle] loadNibNamed:@"SpotlightView" owner:self options:nil] lastObject];
    rightSpotlightView.frame = self.leftSpotlightViewContainer.frame;
    self.rightSpotlightView = rightSpotlightView;
    [self.rightSpotlightViewContainer addSubview: self.rightSpotlightView];
    self.rightSpotlightView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SpotlightViewDelegate

-(void)onSpotlighViewWithModelTap:(NewsPreviewModel*)model {
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    DetailViewController * controller = [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    
    controller.newsPreview = model;
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    
    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark - TTTAttributedLabelDelegate 

-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [[UIApplication sharedApplication] openURL:url];
}

@end
