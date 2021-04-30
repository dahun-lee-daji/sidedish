//
//  ViewController.swift
//  SideDishApp
//
//  Created by 오킹 on 2021/04/20.
//

import UIKit
import Toast_Swift
import Combine

class ViewController: UIViewController, ViewChangable {

    @IBOutlet weak var dishCollectionView: UICollectionView!
    
    var menuListViewModel: MenuListViewModel!
    private var subscriptions = Set<AnyCancellable>()
    var dataSource : UICollectionViewDiffableDataSource<Dishes,Dish>!
    let dishCollectionViewDelegate = DishCollectionViewDelegate()
    var snapshot = NSDiffableDataSourceSnapshot<Dishes,Dish>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dishCollectionViewDelegate.set(delegate: self)
        dishCollectionViewDelegate.menuListViewModel = menuListViewModel
        bind()
        dishCollectionView.delegate = dishCollectionViewDelegate
        dataSource = DiffableProvider(targetView: self.view).configureDataSource(collectionView: dishCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func pushNextView(dishId: String) {
        performSegue(withIdentifier: "MenuDetailSegue", sender: .some(dishId))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MenuDetailSegue" {
            guard let vc = segue.destination as? MenuDetailController else {
                return
            }
            let string = sender as? String
            vc.dishId = string
            
        }
    }

    private func addDataToSnapshot (dishes: [Dishes]) {
        let dishesArray = dishes as Array<Dishes>
        
        guard let dishes = dishesArray.first else {
            return
        }
        self.snapshot.appendSections(dishesArray)
        self.snapshot.appendItems(dishes.dishes, toSection: dishes)
        self.dataSource.apply(self.snapshot)
    }
    
    func bind() {
        menuListViewModel.$main
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                //error
            }, receiveValue: { mainDishes in
                self.addDataToSnapshot(dishes: mainDishes)
            })
            .store(in: &subscriptions)
        
        menuListViewModel.$soup
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                //error
            }, receiveValue: { soupDishes in
                self.addDataToSnapshot(dishes: soupDishes)
            })
            .store(in: &subscriptions)
        
        menuListViewModel.$side
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                //error
            }, receiveValue: { sideDishes in
                self.addDataToSnapshot(dishes: sideDishes)
            })
            .store(in: &subscriptions)
    }
    
}

protocol ViewChangable {
    func pushNextView(dishId: String) -> Void
}
