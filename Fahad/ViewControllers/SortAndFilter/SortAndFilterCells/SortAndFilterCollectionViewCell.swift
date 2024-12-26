//
//  SortAndFilterCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit

class SortAndFilterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var redImageview: UIImageView!
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var bucketButton: UIButton!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var productnameLabel: UILabel!
    @IBOutlet weak var redFavButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        sortView.layer.cornerRadius = 10
        sortView.layer.masksToBounds = false
    }
    func homeSetUP(_ cateDetails: SortResponseData){
        productnameLabel.text = cateDetails.name ?? ""
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
                self.redImageview.kf.setImage(with: imageUrl)
            
       }
        }
    }
}
