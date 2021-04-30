//
//  DiffableProvider.swift
//  SideDishApp
//
//  Created by 이다훈 on 2021/04/22.
//

import UIKit
import Toast_Swift

class DiffableProvider  {
    
    private let targetView : UIView
    
    init(targetView: UIView) {
        self.targetView = targetView
    }
    
    private var toasterCloser = Dictionary<Int, () -> Void>()
    
    func configureDataSource(collectionView : UICollectionView) -> UICollectionViewDiffableDataSource<Dishes,Dish> {
        let dataSource = UICollectionViewDiffableDataSource<Dishes,Dish> (collectionView: collectionView, cellProvider: { collectionView, indexPath, dishData in
            
            let cell = self.configureCell(collectionView: collectionView, indexPath: indexPath, dishData: dishData)
            
            return cell
        })
        
        dataSource.supplementaryViewProvider = { [unowned self]
            (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: configureHeader(dataSource: dataSource), for: indexPath)
        }
        
        return dataSource
    }
    
    private func configureCell(collectionView: UICollectionView, indexPath: IndexPath, dishData: Dish) -> UICollectionViewCell {

        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration(), for: indexPath, item: dishData)
        
        return cell
    }
    
    func cellRegistration() -> UICollectionView.CellRegistration<DishCell, Dish> {
        let cellRegistration = UICollectionView.CellRegistration<DishCell,Dish>.init(cellNib: UINib.init(nibName: DishCell.reuseIdentifier, bundle: nil), handler: { cell, indexPath, dishData in
            
            DispatchQueue.main.async {
                cell.dishImage.layer.cornerRadius = 15
                cell.dishImage.image = ViewPlasticSurgery.shared.createImage(url: dishData.image)
            }
            DispatchQueue.main.async {
                cell.title.text = "\(dishData.title)"
                cell.body.text = "\(dishData.dishDescription)"
                
                cell.charge.attributedText = ViewPlasticSurgery.shared.convertCharge(normal: dishData.normalPrice, selling: dishData.sellingPrice)
                
                ViewPlasticSurgery.shared.removeResidualBadges(stackView: cell.eventStackView)
                if let badgeArray = ViewPlasticSurgery.shared.createBadges(badgeString: dishData.badge) {
                    for badge in badgeArray {
                        cell.eventStackView.addArrangedSubview(badge)
                    }
                }
            }
        })
        
        return cellRegistration
    }
    
    private func configureHeader(dataSource: UICollectionViewDiffableDataSource<Dishes,Dish>) -> UICollectionView.SupplementaryRegistration
    <UICollectionViewListCell> {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) {
            [unowned self] (headerView, elementKind, indexPath) in
            
            let headerItem = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            var configuration = headerView.defaultContentConfiguration()
            configuration.text = headerItem.name
            
            configuration.textProperties.font = .boldSystemFont(ofSize: 22)
            configuration.textProperties.color = .black
            
            headerView.backgroundColor = .white
            
            self.addCloser(headerSection: headerView, sectionData: headerItem)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(recognizer:)))
            headerView.addGestureRecognizer(tap)
            headerView.contentConfiguration = configuration
        }
        return headerRegistration
    }
    
    private func addCloser(headerSection: UIView, sectionData: Dishes) {
        self.toasterCloser[headerSection.hash] = {
            let mainView = self.targetView 
            let message = "상품 \(sectionData.dishes.count)개 있어요!"
            
            mainView.hideAllToasts()
            mainView.makeToast(message, duration: 1.0, point: CGPoint(x: mainView.center.x , y: mainView.center.y / 2), title: nil, image: nil, style: ToastManager.shared.style, completion: nil)
        }
    }
    
    
    
    @objc private func handleTapGesture(recognizer: UITapGestureRecognizer) {
        guard let targetHeader = recognizer.view else {
            return
        }
        
        guard let toaster = toasterCloser.first(where: {
            $0.key == targetHeader.hash
        }) else {
            return
        }
        toaster.value()
    }
    
}
