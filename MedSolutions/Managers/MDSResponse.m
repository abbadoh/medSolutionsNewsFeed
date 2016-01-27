//
//  MDSResponse.m
//  MedSolutions
//
//  Created by Gumo on 23/01/16.
//  Copyright © 2016 Gumo. All rights reserved.
//

#import "MDSResponse.h"

@implementation MDSResponse

+ (Class)responseClass {
    return [MDSResponse class];
}

+ (NSString *)resultKeyPathForJSONDictionary:(NSDictionary *)JSONDictionary {
    return @"data";
}

@end
