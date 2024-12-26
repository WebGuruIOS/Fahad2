//
//  OrderListTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 27/09/21.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var orderListView: UIView!
   
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        orderListView.layer.cornerRadius = 3
        orderListView.layer.masksToBounds = false
        orderListView.layer.shadowColor = UIColor.lightGray.cgColor
        orderListView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        orderListView.layer.shadowRadius = 5.0
        orderListView.layer.shadowOpacity = 0.5
    }
    func homeSetUP(_ cateDetails: OrderListResponseData){
        nameLabel.text = cateDetails.orderNo ?? ""
        priceLabel.text = "$\(cateDetails.orderTotal ?? "")"
        typeLabel.text = cateDetails.productName
        let imgUrl:String = cateDetails.productImage ?? ""
        let stringWithoutSpaces = imgUrl.replacingOccurrences(of: " ", with: "%20")
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:stringWithoutSpaces) {
                self.imgView.kf.setImage(with: imageUrl)

       }
    }
    }

    
}
