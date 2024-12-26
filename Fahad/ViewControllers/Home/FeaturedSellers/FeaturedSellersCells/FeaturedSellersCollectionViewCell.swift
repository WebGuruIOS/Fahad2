//
//  FeaturedSellersCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 16/08/21.
//

import UIKit

class FeaturedSellersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        mainview.layer.borderWidth = 1.0
    }
    func homeSetUP(_ cateDetails: Featured_seller){
        nameLabel.text = cateDetails.title ?? "''"
        let data = cateDetails.image ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imgView.kf.setImage(with: imageUrl)
            
       }
        }
    }
}
