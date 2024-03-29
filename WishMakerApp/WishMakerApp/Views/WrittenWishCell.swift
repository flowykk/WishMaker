//
//  WrittenWishCell.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 31.10.2023.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    
    //MARK: - fields
    static let reuseId: String = Constants.wishCellReuseId
    private let wishLabel: UILabel = UILabel()
    
    private let wishDeleteButton: UIButton = UIButton()
    private let wishEditButton: UIButton = UIButton()
    private let scheduleWishButton: UIButton = UIButton()
    
    private let wishStoringView = WishStoringViewController()
        
    var deleteButtonTapAction: (() -> Void)?
    var editButtonTapAction: (() -> Void)?
    var scheduleButtonTapAction: (() -> Void)?
    
    let wrap: UIView = UIView()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.wishCellError)
    }
    
    // MARK: - configure wishLabel and buttons
    func configure(wish: String, rowIndex: Int) {
        wishLabel.text = wish
        wishLabel.textColor = .black
        
        wishDeleteButton.setImage(UIImage(systemName: Constants.wishDeleteIcon)?.withTintColor(
            .red,
            renderingMode: .alwaysOriginal
        ), for: .normal)
        wishDeleteButton.setTitleColor(.white, for: .normal)
        wishDeleteButton.addTarget(self, action: #selector(wishDeleteButtonPressed), for: .touchUpInside)
        wishDeleteButton.tag = rowIndex
        
        wishEditButton.setImage(UIImage(systemName: Constants.wishEditIcon), for: .normal)
        wishEditButton.setTitleColor(.white, for: .normal)
        wishEditButton.addTarget(self, action: #selector(wishEditButtonPressed), for: .touchUpInside)
        
        scheduleWishButton.setImage(UIImage(systemName: Constants.scheduleWishIcon)?.withTintColor(
            .systemGreen,
            renderingMode: .alwaysOriginal
        ), for: .normal)
        scheduleWishButton.setTitleColor(.white, for: .normal)
        scheduleWishButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - configure UI
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        wrap.backgroundColor = .white
        wrap.layer.cornerRadius = Constants.wrapRadius
        
        contentView.addSubview(wrap)
        wrap.pinHorizontal(to: self, Constants.wrapHOffset)
        wrap.pinTop(to: self, Constants.wrapTopAnchor)
        
        wrap.addSubview(wishDeleteButton)
        wishDeleteButton.imageView?.setHeight(Constants.controlWishButtonWidth)
        wishDeleteButton.imageView?.setWidth(Constants.controlWishButtonWidth)
        wishDeleteButton.pinRight(to: wrap.trailingAnchor, Constants.wishDeleteButtonRightAnchor)
        wishDeleteButton.pinCenterY(to: wrap)
        
        wrap.addSubview(wishEditButton)
        wishEditButton.imageView?.setHeight(Constants.controlWishButtonWidth)
        wishEditButton.imageView?.setWidth(Constants.controlWishButtonWidth)
        wishEditButton.pinRight(to: wishDeleteButton.leadingAnchor, Constants.wishEditButtonRightAnchor)
        wishEditButton.pinCenterY(to: wrap)
        
        wrap.addSubview(scheduleWishButton)
        scheduleWishButton.imageView?.setHeight(Constants.controlWishButtonWidth)
        scheduleWishButton.imageView?.setWidth(Constants.controlWishButtonWidth)
        scheduleWishButton.pinRight(to: wishEditButton.leadingAnchor, Constants.wishEditButtonRightAnchor)
        scheduleWishButton.pinCenterY(to: wrap)
        
        wrap.addSubview(wishLabel)
        wishLabel.pinVertical(to: wrap, Constants.wishLabelOffset)
        wishLabel.pinLeft(to: wrap.leadingAnchor, Constants.wishLabelLeftAnchor)
        wishLabel.pinRight(to: wrap.trailingAnchor, Constants.wishLabelRightAnchor)
    }
    
    // MARK: - wishDelete button was pressed
    @objc
    private func wishDeleteButtonPressed() {
        deleteButtonTapAction?()
    }
    
    // MARK: - wishEdit button was pressed
    @objc
    private func wishEditButtonPressed() {
        editButtonTapAction?()
    }
    
    // MARK: - scheduleWish button was pressed
    @objc
    private func scheduleWishButtonPressed() {
        scheduleButtonTapAction?()
    }
}

