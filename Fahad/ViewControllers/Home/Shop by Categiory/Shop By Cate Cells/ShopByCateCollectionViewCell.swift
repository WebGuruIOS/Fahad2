//
//  ShopByCateCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 16/08/21.
//

import UIKit

class ShopByCateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var firstView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        firstView.clipsToBounds = true
//        firstView.layer.cornerRadius = 140
//       firstView.layer.maskedCorners = [.layerMaxXMinYCorner]
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
       // roundCorners(corners: [.topRight], radius: 540.0)
       // roundCorners(corners: [.topLeft], radius: 5.0)
    }
    func homeSetUP(_ cateDetails: Categories){
        nameLabel.text = cateDetails.name ?? "''"
        let data = cateDetails.thumb ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imageview.kf.setImage(with: imageUrl)
            
       }
        }
    }
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
