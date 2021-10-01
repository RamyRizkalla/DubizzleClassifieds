//Copyright © 2021 Ramy Rizkalla. All rights reserved.

#import "ImageCacheConfiguration.h"

@implementation ImageCacheConfiguration

+ (instancetype)defaultConfiguration {
    return [[ImageCacheConfiguration alloc] initWithCountLimit: 100 andMemoryLimit: 1024 * 1024 * 100];
}

- (instancetype)initWithCountLimit:(NSUInteger)countLimit andMemoryLimit:(NSUInteger)memoryLimit {
    self = [super init];

    if (self) {
        self.countLimit = countLimit;
        self.memoryLimit = memoryLimit;
    }
    return self;
}

@end
