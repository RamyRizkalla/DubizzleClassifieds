// Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

extension UITableView {
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withIdentifier: "\(Cell.self)", for: indexPath) as? Cell ?? Cell()
    }

    func registerCell<Cell: UITableViewCell>(ofType cellType: Cell.Type) {
        let cellTypeName = String(describing: cellType)

        if Bundle.main.path(forResource: cellTypeName, ofType: "nib") != nil {
            register(UINib(nibName: cellTypeName, bundle: .main), forCellReuseIdentifier: cellTypeName)
        } else {
            register(cellType, forCellReuseIdentifier: cellTypeName)
        }
    }
}
