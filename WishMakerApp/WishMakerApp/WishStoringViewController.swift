//
//  WishStoringViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 31.10.2023.
//

import UIKit

final class WishStoringViewController: UIViewController, UISheetPresentationControllerDelegate, UITextFieldDelegate {
    
    //MARK: - fields
    private let wishMakerView = WishMakerViewController()
    private let table: UITableView = UITableView(frame: .zero)
    private let defaults = UserDefaults.standard
    private var wishArray: [String] = []
    
    private var editingRow: Int = Constants.defaultEditingRowFlag
    
    let addWishTextField: UITextField = UITextField()
    let addWishButton: UIButton = UIButton(type: .system)
    let clearTableButton: UIButton = UIButton(type: .system)
    
    var wraps: [UIView] = []
    
    @available(iOS 15.0, *)
    var wishStoringController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    // MARK: - viewDidLoad func
    override func viewDidLoad() {
        wishArray = (defaults.array(forKey: Constants.wishArrayKey) as? [String] ?? [])
        view.backgroundColor = generateRandomColor()
        
        if #available(iOS 15.0, *) {
            sheetPresentationController?.delegate = self
            sheetPresentationController?.prefersGrabberVisible = true
        }
        
        addWishTextField.delegate = self
        
        configureAddWishTextField()
        configureAddWishButton()
        configureClearTableButton()
        configureTable()
    }
    
    //MARK: - configure addWish textView
    private func configureAddWishTextField() {
        let editingRowBool = editingRow != Constants.defaultEditingRowFlag
        
        addWishTextField.attributedPlaceholder = NSAttributedString(
            string: editingRowBool ? Constants.editWishTextFieldPlaceholder : Constants.addWishTextFieldPlaceholder,
            attributes: [.foregroundColor: UIColor.gray])
        addWishTextField.textColor = .black
        addWishTextField.textAlignment = .center
        addWishTextField.backgroundColor = Constants.viewColor
        addWishTextField.layer.cornerRadius = Constants.buttonsCornerRadius
        
        view.addSubview(addWishTextField)
        addWishTextField.setHeight(Constants.buttonsHeightAnchor)
        addWishTextField.pinHorizontal(to: view, Constants.leadingAnchor)
        addWishTextField.pinTop(to: view.topAnchor, Constants.titleTopAnchor)
    }
    
    //MARK: - configure addWish button
    private func configureAddWishButton() {
        let editingRowBool = editingRow != Constants.defaultEditingRowFlag
        
        addWishButton.setTitle(editingRowBool ? Constants.editWishButtonTitle : Constants.addWishButtonTitle, for: .normal)
        addWishButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        addWishButton.setTitleColor(.black, for: .normal)
        addWishButton.backgroundColor = Constants.viewColor
        addWishButton.layer.cornerRadius = Constants.buttonsCornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonsHeightAnchor)
        addWishButton.pinHorizontal(to: view, Constants.leadingAnchor)
        addWishButton.pinTop(to: addWishTextField.bottomAnchor, Constants.buttonsBottomAnchor)
    }
    
    //MARK: - configure clearTable button
    private func configureClearTableButton() {
        clearTableButton.setTitle(Constants.clearTableButtonTitle, for: .normal)
        clearTableButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: Constants.buttonsTitleFontSize)
        clearTableButton.setTitleColor(.black, for: .normal)
        clearTableButton.backgroundColor = Constants.viewColor
        clearTableButton.layer.cornerRadius = Constants.buttonsCornerRadius
        clearTableButton.addTarget(self, action: #selector(clearTableButtonPressed), for: .touchUpInside)
        
        view.addSubview(clearTableButton)
        clearTableButton.setHeight(Constants.buttonsHeightAnchor)
        clearTableButton.pinHorizontal(to: view, Constants.leadingAnchor)
        clearTableButton.pinTop(to: addWishButton.bottomAnchor, Constants.buttonsBottomAnchor)
    }
    
    //MARK: - configure table
    private func configureTable() {
        table.backgroundColor = view.backgroundColor
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        view.addSubview(table)
        table.pinTop(to: clearTableButton.bottomAnchor, Constants.tableTopAnchor)
        table.pinBottom(to: view.bottomAnchor, Constants.tableBottomAnchor)
        table.pinHorizontal(to: view, Constants.tableHOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
    }
    
    //MARK: - clearTable button was pressed
    @objc
    private func clearTableButtonPressed() {
        if wishArray.count != 0 {
            editingRow = Constants.defaultEditingRowFlag
            
            configureAddWishTextField()
            configureAddWishButton()
            
            wishArray.removeAll()
            defaults.set(wishArray, forKey: Constants.wishArrayKey)
            table.reloadData()
        }
    }
    
    //MARK: - addWish button was pressed
    @objc
    private func addWishButtonPressed() {
        let textFieldText: String = addWishTextField.text!
        if textFieldText != Constants.defaultWishTextField {
            if editingRow != Constants.defaultEditingRowFlag {
                wishArray[editingRow] = textFieldText
                editingRow = Constants.defaultEditingRowFlag
            } else {
                wishArray.append(textFieldText)
            }
            
            configureAddWishTextField()
            configureAddWishButton()
            
            addWishTextField.text = Constants.defaultWishTextField
            defaults.set(wishArray, forKey: Constants.wishArrayKey)
            table.reloadData()
        }
    }
    
    //MARK: - Return button on keyboards was pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - deleting row method
    func deleteRow(rowIndex: Int) {
        editingRow = Constants.defaultEditingRowFlag
        
        configureAddWishTextField()
        configureAddWishButton()
        
        wishArray.remove(at: rowIndex)
        defaults.set(wishArray, forKey: Constants.wishArrayKey)
        table.reloadData()
    }
    
    //MARK: - editing row method
    func editRow(rowIndex: Int) {
        //self.wraps[rowIndex].backgroundColor = UIColor(red: 189/255, green: 230/255, blue: 181/255, alpha: 1)
        
        editingRow = rowIndex
        
        configureAddWishTextField()
        configureAddWishButton()
        
        addWishTextField.text = Constants.defaultWishTextField
        defaults.set(wishArray, forKey: Constants.wishArrayKey)
        table.reloadData()
    }
}

//MARK: - WishStoringViewController extension
extension WishStoringViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WrittenWishCell.reuseId,
            for: indexPath
        )
        
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wraps.append(wishCell.wrap)
        
        wishCell.deleteButtonTapAction = { [weak self] in
            self?.deleteRow(rowIndex: indexPath.row)
        }
        wishCell.editButtonTapAction = { [weak self] in
            self?.editRow(rowIndex: indexPath.row)
        }
        
        wishCell.configure(wish: wishArray[indexPath.row], rowIndex: indexPath.row)
        
        return wishCell
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
