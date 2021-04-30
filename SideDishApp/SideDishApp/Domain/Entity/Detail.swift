//
//  Detail.swift
//  SideDishApp
//
//  Created by 이다훈 on 2021/04/30.
//

import Foundation

struct Detail: Codable {
    private(set) var dishId: String
    private(set) var topImage: String
    private(set) var thumbImages: String
    private(set) var productDescription: String
    private(set) var point: String
    private(set) var deliveryInfo: String
    private(set) var deliveryFee: String
    private(set) var normalPrice: String
    private(set) var sellingPrice: String
    private(set) var detailSection: String
    
    init(dishId: String, topImage: String, thumbImages: String, productDescription: String, point: String, deliveryInfo: String, deliveryFee: String, normalPrice: String, sellingPrice: String, detailSection: String) {
        self.dishId = dishId
        self.topImage = topImage
        self.thumbImages = thumbImages
        self.productDescription = productDescription
        self.point = point
        self.deliveryInfo = deliveryInfo
        self.deliveryFee = deliveryFee
        self.normalPrice = normalPrice
        self.sellingPrice = sellingPrice
        self.detailSection = detailSection
    }
    
    init() {
        self.init(dishId: "", topImage: "", thumbImages: "", productDescription: "", point: "", deliveryInfo: "", deliveryFee: "", normalPrice: "", sellingPrice: "", detailSection: "")
    }
}
