//
//  DishCollectionViewDelegate.swift
//  SideDishApp
//
//  Created by 이다훈 on 2021/04/23.
//

import UIKit

class DishCollectionViewDelegate : NSObject, UICollectionViewDelegateFlowLayout {
    
    private var delegate: ViewChangable!
    
    var menuListViewModel: MenuListViewModel!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        var target = Dish(dishID: "", image: "", alt: "", deliveryType: "", title: "", dishDescription: "", normalPrice: "", sellingPrice: "", badge: "")
        switch indexPath.section {
        case 0:
            target = menuListViewModel.main[0].dishes[indexPath.row]
        case 1:
            target = menuListViewModel.soup[0].dishes[indexPath.row]
        case 2:
            target = menuListViewModel.side[0].dishes[indexPath.row]
        default:
         break
        }
        delegate.pushNextView(dishData: target)
        
    }
    
    func set(delegate: ViewChangable){
            self.delegate = delegate
        }
    
}
