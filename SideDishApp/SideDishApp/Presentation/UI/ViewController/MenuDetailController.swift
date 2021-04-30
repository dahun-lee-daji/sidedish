//
//  MenuDetail.swift
//  SideDishApp
//
//  Created by 오킹 on 2021/04/29.
//

import UIKit
import Combine

class MenuDetailController: UIViewController {
    
    @IBOutlet weak var topImageScroolViewWidth: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var orderFeeLabel: UILabel!
    @IBOutlet weak var badgeStackView: UIStackView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var deliveryDescription: UILabel!
    @IBOutlet weak var deliveryFee: UILabel!
    
    @IBOutlet weak var topImageScrollView: UIScrollView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var totalOrderFeeLabel: UILabel!
    
    @IBOutlet weak var detailSectionStackView: UIStackView!
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
                
                let thumbnailImageAdressArray = detail.thumbImages.components(separatedBy: ",")
                self.topImageScroolViewWidth.constant = CGFloat(thumbnailImageAdressArray.count * 375)
                self.topImageScroolViewWidth.isActive = true
                self.topImageScrollView.subviews.first(where: {
                    ObjectIdentifier(type(of: $0)) == ObjectIdentifier(type(of: UIImageView()))
                })?.removeFromSuperview()
                for imageAdress in thumbnailImageAdressArray {
                    let image = ViewPlasticSurgery.shared.createImage(url: imageAdress)
                    let imageView = UIImageView.init(frame: CGRect.init(x: (self.topImageScrollView.subviews.count - 1) * 375, y: 0, width: 375, height: 376))
                    imageView.image = image
                    imageView.contentMode = .scaleAspectFit
                    self.topImageScrollView.addSubview(imageView)
                }
                
                self.titleLabel.text = self.dishData.title
                self.dishDescriptionLabel.text = detail.productDescription
                self.orderFeeLabel.text = detail.sellingPrice == "" ? detail.normalPrice : detail.sellingPrice
                
                ViewPlasticSurgery.shared.removeResidualBadges(stackView: self.badgeStackView)
                if let badgeArray = ViewPlasticSurgery.shared.createBadges(badgeString: self.dishData.badge) {
                    for badge in badgeArray {
                        self.badgeStackView.addArrangedSubview(badge)
                    }
                }
                
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
                for detailSectionAdress in
                    detail.detailSection.components(separatedBy: ",") {
                    let image = ViewPlasticSurgery.shared.createImage(url: detailSectionAdress)
                    let imageView = UIImageView.init(image: image)
                    self.detailSectionStackView.addArrangedSubview(imageView)
                }
                
                
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
