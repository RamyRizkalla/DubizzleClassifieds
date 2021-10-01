//Copyright © 2021 Ramy Rizkalla. All rights reserved.

#import "ImageCachingManager.h"

@interface ImageCachingManager()

@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) NSLock *lock;

@end


@implementation ImageCachingManager

static ImageCachingManager *_sharedObject = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
        ImageCacheConfiguration *configuration = [ImageCacheConfiguration defaultConfiguration];
        [self setupImageCacheWithConfiguration:configuration];
    }
    return self;
}

- (instancetype)initWithConfiguration:(ImageCacheConfiguration *)configuration
{
    self = [super init];
    if (self) {
        self.imageCache = [[NSCache alloc] init];
        [self setupImageCacheWithConfiguration:configuration];
    }
    return self;
}

- (void)setupImageCacheWithConfiguration:(ImageCacheConfiguration *)configuration {
    [self.imageCache setCountLimit:configuration.countLimit];
    [self.imageCache setTotalCostLimit:configuration.memoryLimit];
}

- (UIImage *)getImageWithKey:(NSString *)key {
    [self.lock lock];
    UIImage *image = [self.imageCache objectForKey:key];
    [self.lock unlock];
    return image;
}

- (void)insertImage:(UIImage *)image withKey:(NSString *)key {
    [self.lock lock];
    [self.imageCache setObject:image forKey:key];
    [self.lock unlock];
}

- (void)removeImageWithKey:(NSString *)key {
    [self.lock lock];
    [self.imageCache removeObjectForKey:key];
    [self.lock unlock];
}

- (void)removeAllImages {
    [self.lock lock];
    [self.imageCache removeAllObjects];
    [self.lock unlock];
}

@end
