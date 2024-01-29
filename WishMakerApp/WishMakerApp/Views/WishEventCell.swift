//
//  WishEventCell.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    static let reuseId: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cell configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        wrapView.layer.cornerRadius = 15
        wrapView.backgroundColor = .white
        
        addSubview(wrapView)
        wrapView.pin(to: self, 3)
    }
    
    //MARK: - configure titleLabel
    private func configureTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = .black
        
        wrapView.addSubview(titleLabel)
        titleLabel.pinTop(to: wrapView, 15)
        titleLabel.pinCenterX(to: wrapView)
    }
    
    //MARK: - configure descriptionLabel
    private func configureDescriptionLabel() {
        descriptionLabel.font = UIFont(name: "SFMono-Regular", size: 16)
        descriptionLabel.textColor = .black
        
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 5)
        descriptionLabel.pinCenterX(to: wrapView)
    }
    
    //MARK: - configure startDateLabel
    private func configureStartDateLabel() {
        startDateLabel.font = UIFont(name: "SFMono-Regular", size: 13)
        startDateLabel.textColor = .black
        
        wrapView.addSubview(startDateLabel)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, 20)
        startDateLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
    
    //MARK: - configure endDateLabel
    private func configureEndDateLabel() {
        endDateLabel.font = UIFont(name: "SFMono-Regular", size: 13)
        endDateLabel.textColor = .black
        
        wrapView.addSubview(endDateLabel)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, 5)
        endDateLabel.pinLeft(to: wrapView.leadingAnchor, 15)

    }
}
