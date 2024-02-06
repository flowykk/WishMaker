//
//  WishCalendarViewController.swift
//  ddrakhmanovPW2
//
//  Created by Данила on 25.01.2024.
//

import UIKit
import CoreData

class WishCalendarViewController: UIViewController {
    
    //MARK: - fields
    private static var events = [WishEventItem]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let calendarManager = CalendarManager()
    
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    //MARK: - viewDidLoad func
    override func viewDidLoad() {
        getAllItems()
        configureUI()
    }
    
    //MARK: - function for getting all user's events
    func getAllItems() {
        do {
            WishCalendarViewController.events = try context.fetch(WishEventItem.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    //MARK: - function for creating new event
    func createItem(
        wishEventTitle: String,
        wishEventDescription: String,
        startDate: Date,
        endDate: Date
    ) {
        let newItem = WishEventItem(context: context)
                
        newItem.wishEventTitle = wishEventTitle
        newItem.wishEventDescription = wishEventDescription
        newItem.startDate = startDate
        newItem.endDate = endDate
        
        let _ = calendarManager.create(eventModel: CalendarEventModel(
            title: wishEventTitle,
            startDate: startDate,
            endDate: endDate)
        )

        saveToContext()
    }
    
    
    //MARK: - function for deleteing existing event
    func deleteItem(item: WishEventItem) {
        context.delete(item)
        
        saveToContext()
    }
    
    //MARK: - function to save date to context
    func saveToContext() {
        do {
            try context.save()
            getAllItems()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: - dunction to delete event from context
    func deleteEvent(rowIndex: Int) {
        deleteItem(item: WishCalendarViewController.events[rowIndex])
    }
    
    //MARK: - configure UI
    private func configureUI() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addEventButtonPressed)
            ), UIBarButtonItem(
                barButtonSystemItem: .refresh,
                target: self,
                action: #selector(refreshEventsButtonPressed)
            )]
                                              
        
        configureTitleLabel()
        configureCollection()
    }
    
    //MARK: - configure title
    private func configureTitleLabel() {
        titleLabel.text = Constants.wishCalendatTitleText
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.wishCalendarTitleLabelFontSize)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        titleLabel.pinCenterX(to: view)
        titleLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.wishCalendarTitleLabelTopAnchor)
    }
    
    // MARK: - configure collectionView
    private func configureCollection() {
        view.backgroundColor = UIColor.generateRandomColor()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = Constants.collectionViewCornerRadius
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.layoutMinimumInteritemSpacing
            layout.minimumLineSpacing = Constants.layoutMinimumLineSpacing
            layout.invalidateLayout()
        }
        
        view.addSubview(collectionView)
        collectionView.pinHorizontal(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.collectionViewBottomAnchor)
        collectionView.pinTop(to: titleLabel.bottomAnchor, Constants.collectionViewTopAnchor)
        
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseId
        )
    }
    
    //MARK: - add event right bar button pressed
    @objc
    private func addEventButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    //MARK: - refresh events right bar button pressed
    @objc
    private func refreshEventsButtonPressed() {
        getAllItems()
    }
}

//MARK: - extensions for WishCalendarViewController
extension WishCalendarViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return WishCalendarViewController.events.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let event = WishCalendarViewController.events[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseId,
            for: indexPath
        )
        
        guard let wishEventCell = cell as? WishEventCell else {
            return cell
        }
        
        wishEventCell.deleteButtonTapAction = { [weak self] in
            self?.deleteEvent(rowIndex: indexPath.row)
        }
        
        wishEventCell.configure(with: event)
        
        return wishEventCell
    }
}

extension WishCalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - Constants.collectionViewWidthBound, height: Constants.collectionViewHeight)
    }
}
