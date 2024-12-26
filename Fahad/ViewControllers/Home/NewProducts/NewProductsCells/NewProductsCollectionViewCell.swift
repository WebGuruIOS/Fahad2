//
//  NewProductsCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 16/08/21.
//

import UIKit

class NewProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
   @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.cornerRadius = 10
        mainview.layer.masksToBounds = false
    }
    func homeSetUP(_ cateDetails: New_product){
        nameLabel.text = cateDetails.name ?? ""
        let tax = cateDetails.tax ?? ""
        let price = cateDetails.price ?? ""
        let newString = price.replacingOccurrences(of: "USD", with: "")
        let dd = "USD"
        let rr = tax + " \(dd)"
      
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
