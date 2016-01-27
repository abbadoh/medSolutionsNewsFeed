//
//  NewsPreviewErrorModel.h
//  MedSolutions
//
//  Created by Gumo on 24/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Overcoat/Overcoat.h>

typedef enum {
    MDSErrorUnknown,
    MDSErrorNoData,
    MDSErrorNoInternetConnection
} MDSErrorCode;

@interface NewsErrorModel : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString * message;
@property (assign, nonatomic, readonly) MDSErrorCode errorCode;
@property (copy, nonatomic, readonly) NSNumber * code;


- (instancetype)initWithErrorDictionary:(NSDictionary *)dictionary error:(NSError **)error;
- (instancetype)initWithServerError:(NSError*)error;

@end
