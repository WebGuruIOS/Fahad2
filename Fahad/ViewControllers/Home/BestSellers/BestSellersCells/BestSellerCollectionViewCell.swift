//
//  BestSellerCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit

class BestSellerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10.0
        mainView.layer.masksToBounds = false
    }
    func homeSetUP(_ cateDetails: Best_seller){
        nameLabel.text = cateDetails.name ?? ""
        let tax = cateDetails.tax ?? ""
        let price = cateDetails.price ?? ""
        let dd = "USD"
        let rr = tax + " \(dd)"
        let newString = price.replacingOccurrences(of: "USD", with: "")
        if price == rr{
            oldPriceLabel.text = ""
            lineLabel.isHidden = true
           
        }else{
            oldPriceLabel.text = newString
            lineLabel.isHidden = false
        }
        newPriceLabel.text = cateDetails.tax ?? ""
        let data = cateDetails.thumb ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imgView.kf.setImage(with: imageUrl)
       }
        }
    }
}
