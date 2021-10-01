//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

extension UICollectionView {
    func dequeueCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell ?? Cell()
    }

    func registerCell<Cell: UICollectionViewCell>(ofType cellType: Cell.Type) {
        let cellTypeName = String(describing: cellType)

        if Bundle.main.path(forResource: cellTypeName, ofType: "nib") != nil {
            register(UINib(nibName: cellTypeName, bundle: .main), forCellWithReuseIdentifier: cellTypeName)
        } else {
            register(cellType, forCellWithReuseIdentifier: cellTypeName)
        }
    }
}
