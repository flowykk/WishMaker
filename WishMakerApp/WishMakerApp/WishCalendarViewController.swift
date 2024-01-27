//
//  WishCalendarViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import UIKit

class WishCalendarViewController: UIViewController {
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    
    override func viewDidLoad() {
        configureCollection()
    }
    
    private func configureCollection() {
        view.backgroundColor = generateRandomColor()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10) //Constants.contentInset
        /* Temporary line */
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
        /* Temporary line */
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5) //Constants.collectionTop)
        
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseId
        )
    }
}

extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
        WishEventCell.reuseId, for: indexPath)
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        wishEventCell.configure(
            with: WishEventModel(
                title: "Test",
                description: "Test description",
                startDate: "Start date",
                endDate: "End date"
            )
        )
        
        return wishEventCell
    }
}

extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Adjust cell size as needed
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}

//MARK: - generating random color method
private func generateRandomColor() -> UIColor {
    return UIColor(
        red: .random(in: Constants.colorMin...Constants.colorMax),
        green: .random(in: Constants.colorMin...Constants.colorMax),
        blue: .random(in: Constants.colorMin...Constants.colorMax),
        alpha: Constants.alphaValue
    )
}
