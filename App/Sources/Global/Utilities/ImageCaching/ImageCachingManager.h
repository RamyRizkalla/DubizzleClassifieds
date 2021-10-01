//Copyright © 2021 Ramy Rizkalla. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageCacheConfiguration.h"

@interface ImageCachingManager: NSObject

+ (instancetype)sharedManager;
- (instancetype)initWithConfiguration:(ImageCacheConfiguration *)configuration;

- (UIImage *)getImageWithKey:(NSString *)key;
- (void)insertImage:(UIImage *)image withKey:(NSString *)key;
- (void)removeImageWithKey:(NSString *)key;
- (void)removeAllImages;

@end
