//
//  ProductSearchTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 28/09/21.
//

import UIKit
import Cosmos
class ProductSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
   
    @IBOutlet weak var lineLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 3
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        mainView.layer.shadowRadius = 5.0
        mainView.layer.shadowOpacity = 0.5
     //  ratingView.isUserInteractionEnabled = false
        
    }
    func homeSetUP(_ cateDetails: SearchResponseData){
//        newPriceLabel.text = cateDetails.price ?? ""
//        oldPriceLabel.text = cateDetails.price ?? ""
////        if let long = cateDetails.rating as? Double{
////         ratingView.rating = long
////        }
        nameLabel.text = cateDetails.name ?? ""
        let tax = cateDetails.tax ?? ""
        let price = cateDetails.price ?? ""
        let dd = "USD"
        let rr = tax + " \(dd)"
      
        if price == tax{
            oldPriceLabel.text = ""
            lineLabel.isHidden = true
           
        }else{
            oldPriceLabel.text = cateDetails.price ?? ""
            lineLabel.isHidden = false
        }
        newPriceLabel.text = cateDetails.tax ?? ""
      
        let placeholderImg = UIImage(named: "surf")
        let data = cateDetails.thumb ?? ""
        if let imageUrl:URL = URL(string:"\(data)") {
            imgView?.kf.setImage(with: imageUrl,placeholder: placeholderImg)
        }
        }
    
}
