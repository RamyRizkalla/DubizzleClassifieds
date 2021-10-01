// Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

extension UIView {
    func addActivityIndicator(_ activityIndicator: UIActivityIndicatorView) {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
        view.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperView()
        addSubview(view)
        view.centerInSuperView()
    }

    func centerInSuperView() {
        guard let superview = superview else { return }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }

    func round() {
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
    }
}
