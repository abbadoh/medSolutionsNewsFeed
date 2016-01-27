//
//  ModelManager.m
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "ModelManager.h"
#import "NewsModel.h"
#import "NewsDataModel.h"
#import "NewsPreviewModel.h"
#import "MDSResponse.h"

static NSString * const SECRET_KEY = @"secret_key";
static NSString * const SECRET_VALUE = @"API-KEY";

static NSString * const BASE_URL = @"http://medsolutions.uxp.ru/";
static NSString * const GET_NEWS_URL = @"api/v1/news?limit=8&page=%ld";
static NSString * const GER_NEWS_DESCRIPTION_URL = @"api/v1/news/%@";

@interface ModelManager()

@property (assign, nonatomic) NSInteger pageCounter;

@end

@implementation ModelManager

+ (instancetype)manager
{
    static ModelManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ModelManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [_sharedClient.requestSerializer setValue:SECRET_KEY forHTTPHeaderField:SECRET_VALUE];
    });
    return _sharedClient;
}

+ (Class)responseClassesByResourcePath {
    return @{
             @"api/v1/news": [MDSResponse class],
             @"api/v1/news/#" : [OVCResponse class]
             };
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"api/v1/news": [NewsPreviewModel class],
             @"api/v1/news/#" : [NewsModel class]
             };
}

- (void)getFirstNewsWithCompletion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion {
    self.pageCounter = 1;
    [self loadNewsWithCompletion:completion];
}

- (void)getMoreNewsWithCompletion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion {
    self.pageCounter++;
    [self loadNewsWithCompletion:completion];
}

-(void)loadNewsWithCompletion:(void (^)( OVCResponse * response, NewsErrorModel * error))completion {
    [self GET:[NSString stringWithFormat:GET_NEWS_URL, self.pageCounter] parameters:nil completion:^(OVCResponse *response, NSError *error) {
        [self handleServerResponse:response error:error completion:completion];
    }];
}

- (void)getNewsDesctiptionForNewsWithId:(NSNumber*)newsId completion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion {
    [self GET:[NSString stringWithFormat:GER_NEWS_DESCRIPTION_URL, newsId] parameters:nil completion:^(OVCResponse *response, NSError *error) {
        [self handleServerResponse:response error:error completion:completion];
    }];
}

- (void)handleServerResponse:(OVCResponse*)response error:(NSError*)error completion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion {
    if (error) {
        NewsErrorModel * newsError = nil;
        if (response) {
            NSError *errorPointer;
            newsError = [[NewsErrorModel alloc] initWithErrorDictionary:response.result error:&errorPointer];
        }
        else {
            newsError = [[NewsErrorModel alloc]initWithServerError:error];
        }
        completion(nil, newsError);
    }
    else {
        completion(response, nil);
    }
}

@end
