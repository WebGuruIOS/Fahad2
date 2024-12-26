//
//  WishlistTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit

class WishlistTableViewCell: UITableViewCell {

    
   
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var wishlistView: UIView!
    @IBOutlet weak var cartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        wishlistView.layer.cornerRadius = 10
        wishlistView.layer.masksToBounds = false
        wishlistView.layer.shadowColor = UIColor.lightGray.cgColor
        wishlistView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        wishlistView.layer.shadowRadius = 5.0
        wishlistView.layer.shadowOpacity = 0.5
    }
    func homeSetUP(_ cateDetails: WishlistResponseData){
        nameLabel.text = cateDetails.name ?? ""
        let tax = cateDetails.tax ?? ""
        let price = cateDetails.price ?? ""
         if tax == price{
            oldPriceLabel.text = ""
            lineLabel.isHidden = true
           
        }else{
            oldPriceLabel.text = cateDetails.price ?? ""
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
