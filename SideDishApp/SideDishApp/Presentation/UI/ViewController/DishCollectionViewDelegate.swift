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

        var dishId = String()
        switch indexPath.section {
        case 0:
            dishId = menuListViewModel.main[0].dishes[indexPath.row].dishID
        case 1:
            dishId = menuListViewModel.soup[0].dishes[indexPath.row].dishID
        case 2:
            dishId = menuListViewModel.side[0].dishes[indexPath.row].dishID
        default:
         break
        }
        delegate.pushNextView()
        
    }
    
    func set(delegate: ViewChangable){
            self.delegate = delegate
        }
    
}
