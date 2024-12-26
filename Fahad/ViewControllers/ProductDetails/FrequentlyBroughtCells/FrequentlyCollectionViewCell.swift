//
//  FrequentlyCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 23/08/21.
//

import UIKit

class FrequentlyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = false
    }
    func homeSetUP(_ cateDetails: ProductRelated){
        nameLabel.text = cateDetails.name ?? ""
        newPriceLabel.text = cateDetails.tax ?? ""
        oldPriceLabel.text = cateDetails.price ?? ""
        let data = cateDetails.thumb ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imgView.kf.setImage(with: imageUrl)
            
       }
    }
    }
}
