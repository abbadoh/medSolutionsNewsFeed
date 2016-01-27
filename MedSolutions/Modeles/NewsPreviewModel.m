//
//  NewsPreviewModel.m
//  medSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "NewsPreviewModel.h"

@implementation NewsPreviewModel

- (NSString*)getTimeAndDateOfCreation {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"HH:mm dd.MM";
    return [format stringFromDate:[dateFormatter dateFromString:self.createdAt]];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"newsId": @"id",
             @"title": @"title",
             @"imageUrl": @"image",
             @"newsDescription": @"description",
             @"createdAt": @"created_at",
             @"thumbnailUrl": @"thumbnail"
             };
}

@end
