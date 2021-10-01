//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

struct ImageCollectionViewCellData {
    var urlStringPath: String
    var indexIndicator: String
}

class ImageCollectionViewCell: UICollectionViewCell, ImageLoadable {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageIndicatorLabel: PaddingLabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageIndicatorLabel.round()
    }

    var model: ImageCollectionViewCellData! {
        didSet {
            load(urlStringPath: model.urlStringPath)
            imageIndicatorLabel.text = model.indexIndicator
        }
    }

    private func load(urlStringPath: String) {
        activityIndicator.startAnimating()
        loadImage(from: urlStringPath) { [weak self] image in
            self?.imageView.image = image ?? Images.imageUnavailable
            self?.activityIndicator.stopAnimating()
        }
    }
}
