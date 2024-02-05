//
//  WishEventCell.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    
    //MARK: - fields
    static let reuseId: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()

    private let deleteButton: UIButton = UIButton()
        
    var deleteButtonTapAction: (() -> Void)?
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
        
        configureDeleteButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Cell configuration
    func configure(with event: WishEventItem) {
        titleLabel.text = event.wishEventTitle
        descriptionLabel.text = event.wishEventDescription
        startDateLabel.text = "Start Date: \(event.startDate!.removeTimeFromDate)"
        endDateLabel.text = "End Date: \(event.endDate!.removeTimeFromDate)"
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
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        descriptionLabel.textColor = .black
        
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 3)
        descriptionLabel.pinCenterX(to: wrapView)
    }
    
    //MARK: - configure startDateLabel
    private func configureStartDateLabel() {
        startDateLabel.font = UIFont.systemFont(ofSize: 14)
        startDateLabel.textColor = .black
        
        wrapView.addSubview(startDateLabel)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, 20)
        startDateLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
    
    //MARK: - configure endDateLabel
    private func configureEndDateLabel() {
        endDateLabel.font = UIFont.systemFont(ofSize: 14)
        endDateLabel.textColor = .black
        
        wrapView.addSubview(endDateLabel)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, 5)
        endDateLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
    
    //MARK: - configure delete button
    private func configureDeleteButton() {
        deleteButton.setTitle("Delete event", for: .normal)
        deleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = .systemRed
        deleteButton.layer.cornerRadius = 15
        deleteButton.addTarget(self, action: #selector(eventDeleteButtonPressed), for: .touchUpInside)

        wrapView.addSubview(deleteButton)
        deleteButton.setHeight(45)
        deleteButton.pinHorizontal(to: wrapView, 13)
        deleteButton.pinTop(to: endDateLabel.bottomAnchor, 11)
    }
    
    //MARK: - wishDelete button was pressed
    @objc
    private func eventDeleteButtonPressed() {
        deleteButtonTapAction?()
    }
}
