//
//  HomeApplianceCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit

class HomeApplianceCollectionViewCell: UICollectionViewCell{

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var oldpriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    override func awakeFromNib(){
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = false
     }
    func homeSetUP(_ cateDetails: Home_appliances){
        nameLabel.text = cateDetails.name ?? ""
        let tax = cateDetails.tax ?? ""
        let price = cateDetails.price ?? ""
        let newString = price.replacingOccurrences(of: "USD", with: "")
        let dd = "USD"
        let rr = tax + " \(dd)"
      
        if price == rr{
            oldpriceLabel.text = ""
            lineLabel.isHidden = true
           
        }else{
            oldpriceLabel.text = newString
            lineLabel.isHidden = false
        }
        newPriceLabel.text = cateDetails.tax ?? ""
       
        let data = cateDetails.thumb ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
            self.imageview.kf.setImage(with: imageUrl)
            
       }
    }
    }
  
    @IBAction func favButtonAction(_ sender: UIButton){
        
    }
}
extension String {
    mutating func replace(_ originalString:String, with newString:String) {
        self = self.replacingOccurrences(of: originalString, with: newString)
    }
}
