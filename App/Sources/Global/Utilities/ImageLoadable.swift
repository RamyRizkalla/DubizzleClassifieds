//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import Foundation

protocol ImageLoadable {
    func loadImage(from urlStringPath: String, completion: @escaping (UIImage?) -> Void)
}

extension ImageLoadable {
    func loadImage(from urlStringPath: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlStringPath) else { return }
        let imageCache = ImageCachingManager.shared()
        if let image = imageCache?.getImageWithKey(urlStringPath) {
            completion(image)
        } else {
            ApiManager.shared.downloadImage(from: url) { data in
                if let data = data, let image = UIImage(data: data) {
                    imageCache?.insert(image, withKey: urlStringPath)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
