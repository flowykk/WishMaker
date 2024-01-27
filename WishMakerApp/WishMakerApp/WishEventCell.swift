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
        addSubview(wrapView)
        wrapView.pin(to: self, 40)
        wrapView.setWidth(40)
        wrapView.setHeight(40)
        wrapView.layer.cornerRadius = 15
        wrapView.backgroundColor = .blue
    }
    
    private func configureTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        titleLabel.textColor = .green
        
        addSubview(titleLabel)
        titleLabel.pinTop(to: wrapView, 15)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        descriptionLabel.textColor = .green
        
        addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 15)
    }
    
    private func configureStartDateLabel() {
        startDateLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        startDateLabel.textColor = .green
        
        addSubview(startDateLabel)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, 15)
    }
    
    private func configureEndDateLabel() {
        endDateLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        endDateLabel.textColor = .green
        
        addSubview(endDateLabel)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, 15)
    }
}
