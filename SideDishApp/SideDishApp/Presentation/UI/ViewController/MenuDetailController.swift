//
//  MenuDetail.swift
//  SideDishApp
//
//  Created by 오킹 on 2021/04/29.
//

import UIKit
import Combine

class MenuDetailController: UIViewController {
    
    @IBOutlet weak var topImageStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var orderFeeLabel: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryDescription: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var totalOrderFeeLabel: UILabel!
    
    var dishData: Dish!
    let menuDetailViewModel = MenuDetailViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    func bind() {
        menuDetailViewModel
            .$detail
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                //error
            }, receiveValue: { detail in
                guard let navi = self.navigationController else {
                    return
                }
                navi.isNavigationBarHidden = false
                navi.navigationBar.topItem?.title = self.dishData.title
//                self.topImageStackView
                self.titleLabel.text = self.dishData.title
                self.dishDescriptionLabel.text = detail.productDescription
                self.orderFeeLabel.text = detail.sellingPrice == "" ? detail.normalPrice : detail.sellingPrice
//                self.badgeStackView
                self.pointLabel.text = detail.point
                self.deliveryDescription.text = detail.deliveryInfo
                self.deliveryFee.text = detail.deliveryFee
                
//                guard let orderNumber = Int(self.orderNumberLabel.text ?? "0") else {
//                    return
//                }
//                guard let orderFee = Int(self.orderFeeLabel.text ?? "0") else {
//                    return
//                }
                
//                self.totalOrderFeeLabel.text = String(describing: orderNumber * orderFee) + "원"
                
            })
            .store(in: &subscriptions)
    }
    
    @IBAction func subtractStock(_ sender: Any) {
    }
    
    @IBAction func putInStock(_ sender: Any) {
    }
    
    @IBAction func order(_ sender: Any) {
    }

}
