//Copyright © 2021 Ramy Rizkalla. All rights reserved.

#import <Foundation/Foundation.h>

@interface ImageCacheConfiguration : NSObject

@property (nonatomic) NSUInteger countLimit;
@property (nonatomic) NSUInteger memoryLimit;

+ (instancetype)defaultConfiguration;
- (instancetype)initWithCountLimit:(NSUInteger)countLimit andMemoryLimit:(NSUInteger)memoryLimit;

@end
