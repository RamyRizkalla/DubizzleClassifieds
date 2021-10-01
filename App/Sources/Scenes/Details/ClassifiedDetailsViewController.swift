//Copyright © 2021 Ramy Rizkalla. All rights reserved.

import UIKit

class ClassifiedDetailsViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var itemNameLabel: UILabel!

    private var classifiedModel: Classified {
        viewModel.model
    }

    var viewModel: ClassifiedDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupCollectionView()
        setupLabels()
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = Colors.themeRed
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.registerCell(ofType: ImageCollectionViewCell.self)
    }

    private func setupLabels() {
        priceLabel.text = classifiedModel.price
        itemNameLabel.text = classifiedModel.name
    }
}

extension ClassifiedDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfImages
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return configureImageCell(collectionView, at: indexPath)
    }

    private func configureImageCell(_ collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueCell(for: indexPath)
        let imageUrlPath = classifiedModel.imageUrls[indexPath.row]
        cell.model = ImageCollectionViewCellData(urlStringPath: imageUrlPath, indexIndicator: "\(indexPath.row + 1)/\(viewModel.numberOfImages)")
        return cell
    }
}

extension ClassifiedDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
}
