//
//  NewsPreviewErrorModel.m
//  MedSolutions
//
//  Created by Gumo on 24/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "NewsErrorModel.h"

static NSInteger const ERROR_CODE_SERVER_NO_INTERNET_CONNECTION = -1009;
static NSInteger const ERROR_CODE_API_NO_DATA = 404;

@implementation NewsErrorModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"message" : @"message",
             @"code" : @"code"
             };
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self == nil) return nil;
    _errorCode = [self errorCodeWithCodeNumber:self.code];
    return self;
}

- (instancetype)initWithServerError:(NSError *)error {
    self = [super init];
    if (self) {
        _code = [NSNumber numberWithInteger:error.code];
        _message = error.localizedDescription;
        _errorCode = [self errorCodeWithServerCodeNumber:error.code];
    }
    return self;
}

- (instancetype)initWithErrorDictionary:(NSDictionary *)dictionary error:(NSError **)error {
    return [self initWithDictionary:[dictionary objectForKey:@"error"] error:error];
}

-(MDSErrorCode)errorCodeWithServerCodeNumber:(NSInteger)codeNumber {
    switch (codeNumber) {
        case ERROR_CODE_SERVER_NO_INTERNET_CONNECTION:
            return MDSErrorNoInternetConnection;
            break;
        default:
            return MDSErrorUnknown;
            break;
    }
}

-(MDSErrorCode)errorCodeWithCodeNumber:(NSNumber*)codeNumber {
    switch ([codeNumber integerValue]) {
        case ERROR_CODE_API_NO_DATA:
            return MDSErrorNoData;
            break;
        default:
            break;
    }
    return MDSErrorUnknown;
}

@end
