//
//  WishEventCell.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    
    //MARK: - fields
    static let reuseId: String = Constants.wishEventCellReuseId
    
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
        startDateLabel.text = "\(Constants.defaultStartDateLabel): \(event.startDate!.removeTimeFromDate)"
        endDateLabel.text = "\(Constants.defaultEndDateLabel): \(event.endDate!.removeTimeFromDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        wrapView.layer.cornerRadius = Constants.eventCellWrapCornerRadius
        wrapView.backgroundColor = .white
        
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.eventCellWrapOffset)
    }
    
    //MARK: - configure titleLabel
    private func configureTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.eventCellWishTitleFontSize)
        titleLabel.textColor = .black
        
        wrapView.addSubview(titleLabel)
        titleLabel.pinTop(to: wrapView, Constants.eventCellWishTitleTopAnchor)
        titleLabel.pinCenterX(to: wrapView)
    }
    
    //MARK: - configure descriptionLabel
    private func configureDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.eventCellWishDescriptionFontSize)
        descriptionLabel.textColor = .black
        
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.eventCellWishDescriptionTopAnchor)
        descriptionLabel.pinCenterX(to: wrapView)
    }
    
    //MARK: - configure startDateLabel
    private func configureStartDateLabel() {
        startDateLabel.font = UIFont.systemFont(ofSize: Constants.eventCellStartDateLabelFontSize)
        startDateLabel.textColor = .black
        
        wrapView.addSubview(startDateLabel)
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.eventCellStartDateLabelTopAnchor)
        startDateLabel.pinLeft(to: wrapView.leadingAnchor, Constants.eventCellStartDateLabelLeftAnchor)
    }
    
    //MARK: - configure endDateLabel
    private func configureEndDateLabel() {
        endDateLabel.font = UIFont.systemFont(ofSize: Constants.eventCellEndDateLabelFontSize)
        endDateLabel.textColor = .black
        
        wrapView.addSubview(endDateLabel)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.eventCellEndDateLabelTopAnchor)
        endDateLabel.pinLeft(to: wrapView.leadingAnchor, Constants.eventCellEndDateLabelLeftAnchor)
    }
    
    //MARK: - configure delete button
    private func configureDeleteButton() {
        deleteButton.setTitle(Constants.eventCellDeleteButtonTitle, for: .normal)
        deleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = .systemRed
        deleteButton.layer.cornerRadius = Constants.eventCellDeleteButtonCornerRadius
        deleteButton.addTarget(self, action: #selector(eventDeleteButtonPressed), for: .touchUpInside)

        wrapView.addSubview(deleteButton)
        deleteButton.setHeight(Constants.eventCellDeleteButtonHeight)
        deleteButton.pinHorizontal(to: wrapView, Constants.eventCellDeleteButtonHOffset)
        deleteButton.pinTop(to: endDateLabel.bottomAnchor, Constants.eventCellDeleteButtonTopAnchor)
    }
    
    //MARK: - wishDelete button was pressed
    @objc
    private func eventDeleteButtonPressed() {
        deleteButtonTapAction?()
    }
}
