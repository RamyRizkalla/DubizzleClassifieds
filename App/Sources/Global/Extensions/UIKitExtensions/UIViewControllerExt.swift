//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

extension UIViewController {
    static func instantiate(from storyboard: String) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(identifier: "\(ClassifiedDetailsViewController.self)") as! Self
    }
}
