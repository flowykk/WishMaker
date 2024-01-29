//
//  WishCalendarViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import UIKit

class WishCalendarViewController: UIViewController {
    let titleLabel = UILabel()
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        configureTitleLabel()
        configureCollection()
    }
    
    private func configureTitleLabel() {
        titleLabel.text = "Your events"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5)
    }
    
    private func configureCollection() {
        view.backgroundColor = generateRandomColor()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 25
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        //collectionView.contentInset = UIEdgeInsets(top: 0, left: 4, bottom: 100, right: 3)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, -35)
        collectionView.pinTop(to: titleLabel.bottomAnchor, 20)
        
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
                wishTitle: "Test",
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
        return CGSize(width: collectionView.bounds.width - 25, height: 200)
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
