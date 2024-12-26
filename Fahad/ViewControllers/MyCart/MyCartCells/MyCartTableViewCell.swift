//
//  MyCartTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 20/08/21.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.cornerRadius = 10
        mainView.layer.masksToBounds = false
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        mainView.layer.shadowRadius = 5.0
        mainView.layer.shadowOpacity = 0.5
    }

    func homeSetUP(_ cateDetails: MyCartResponseData){
        nameLabel.text = cateDetails.name ?? ""
        let tax = cateDetails.orginalPrice ?? ""
        let price = cateDetails.price ?? ""
         if tax == price{
            oldPriceLabel.text = ""
            lineLabel.isHidden = true
           
        }else{
            oldPriceLabel.text = cateDetails.orginalPrice ?? ""
            lineLabel.isHidden = false
        }
        newPriceLabel.text = cateDetails.price ?? ""
        countLabel.text = cateDetails.quantity ?? ""
        let data = cateDetails.thumb ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imgView.kf.setImage(with: imageUrl)
                
       }
      }
    }
   
}
