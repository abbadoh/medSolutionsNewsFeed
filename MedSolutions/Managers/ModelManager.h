//
//  ModelManager.h
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/Overcoat.h>
#import "NewsErrorModel.h"

@interface ModelManager : OVCHTTPSessionManager

//+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary;
- (void)getFirstNewsWithCompletion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion;
- (void)getMoreNewsWithCompletion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion;
- (void)getNewsDesctiptionForNewsWithId:(NSNumber*)newsId completion:(void (^)(OVCResponse * response, NewsErrorModel * error))completion;


@end
