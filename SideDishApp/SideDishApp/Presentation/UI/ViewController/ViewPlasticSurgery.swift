//
//  ViewPlasticSurgery.swift
//  SideDishApp
//
//  Created by 이다훈 on 2021/04/30.
//

import UIKit

class ViewPlasticSurgery {
    static var shared = ViewPlasticSurgery()
    
    private let colorDictionary = ["이벤트특가" : UIColor.init(displayP3Red: 130/255, green: 211/255, blue: 45/255, alpha: 1), "론칭특가" : UIColor.init(displayP3Red: 134/255, green: 198/255, blue: 255/255, alpha: 1)]
    
    func removeResidualBadges(stackView : UIStackView) {
        for subView in stackView.subviews {
            stackView.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
    
    func createBadges(badgeString: String) -> [UILabel]? {
        if badgeString == "" {
            return nil
        }
        
        let stringArray = badgeString.components(separatedBy: ",")
        var returnLabels = [UILabel]()
        
        for string in stringArray {
            returnLabels.append(self.createEventLabel(text: string))
        }
        
        return returnLabels
    }
    
    func createImage(url: String) -> UIImage {
        guard let imageURL = URL(string: url),
              let imageData = try? Data(contentsOf: imageURL),
              let image = UIImage(data: imageData) else
        {
            return UIImage()
        }
        return image
    }
    
    func createEventLabel(text : String) -> UILabel {

        var label : UILabel {
            let newLabel = UILabel()
            newLabel.text = "  \(text)  "
            newLabel.clipsToBounds = true
            newLabel.layer.cornerRadius = 5
            newLabel.backgroundColor = colorDictionary[text]
            newLabel.textColor = UIColor.white
            newLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            
            return newLabel
        }
        
        return label
    }
    
    func convertCharge(normal: String, selling: String) -> NSMutableAttributedString {
        let normalCharge = "\(String.insertComma(with: normal))원"
        let sellingCharge = "\(String.insertComma(with: selling))원"
        var attributedText : NSMutableAttributedString
        
        if selling != "" {
            let wholeString = normalCharge + " " + sellingCharge
            
            attributedText = wholeString.styleAsCharge(with: normalCharge, with: sellingCharge)
        } else {
            attributedText = normalCharge.styleAsCharge(with: "", with: normalCharge)
        }
        return attributedText
    }
}
