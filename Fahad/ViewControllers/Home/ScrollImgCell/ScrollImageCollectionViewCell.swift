//
//  ScrollImageCollectionViewCell.swift
//  Fahad
//
//  Created by Kondalu on 16/08/21.
//

import UIKit
import Kingfisher
class ScrollImageCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet weak var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func homeSetUP(_ cateDetails: BannerSlider){
       let data = cateDetails.image ?? ""
       DispatchQueue.main.async {
            if let imageUrl:URL = URL(string:"\(data)") {
                self.imageview.kf.setImage(with: imageUrl)
            
       }
        }
    }
}
