//  Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

struct ClassifiedsListTableViewCellData {
    var name: String
    var price: String
    var iconPath: String
}

class ClassifiedsListTableViewCell: UITableViewCell, ImageLoadable {
    @IBOutlet private var itemImageView: UIImageView!
    @IBOutlet private var itemLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    var model: ClassifiedsListTableViewCellData! {
        didSet {
            setData(model)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        itemImageView.round()
    }

    private func setData(_ data: ClassifiedsListTableViewCellData) {
        itemLabel.text = data.name
        priceLabel.text = data.price
        setImage(from: data.iconPath)
    }

    private func setImage(from stringPath: String) {
        activityIndicator.startAnimating()
        loadImage(from: stringPath) { [weak self] image in
            self?.itemImageView.image = image ?? Images.imageUnavailable
            self?.activityIndicator.stopAnimating()
        }
    }
}
