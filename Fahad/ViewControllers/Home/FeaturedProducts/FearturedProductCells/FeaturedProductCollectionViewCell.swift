//
//  FeaturedProductCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 16/08/21.
//

import UIKit

class FeaturedProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var bucketView: UIView!{
        didSet{
            bucketView.clipsToBounds = true
            bucketView.layer.cornerRadius = bucketView.frame.size.width / 2
            }
        }
    
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var whiteFavButton: UIButton!
    @IBOutlet weak var redFavButton: UIButton!
    @IBOutlet weak var bucketButton: UIButton!
    @IBOutlet weak var newPriceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.cornerRadius = 10
        mainview.layer.masksToBounds = false
    }
    func homeSetUP(_ cateDetails: Featured_product){
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
                self.imgview.kf.setImage(with: imageUrl)
            
       }
        }
    }
}
import UIKit
class SharedClass: NSObject {//This is shared class
static let sharedInstance = SharedClass()

    //Show alert
    func alert(view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }

    private override init() {
    }
}
