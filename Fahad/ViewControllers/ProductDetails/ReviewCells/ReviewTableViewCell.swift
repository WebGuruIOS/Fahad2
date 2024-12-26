//
//  ReviewTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 28/09/21.
//

import UIKit
import Cosmos
class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingDespLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func homeSetUP(_ cateDetails: ProductReviews){
        ratingNameLabel.text = cateDetails.author
        if let long = cateDetails.rating{
            ratingView.rating = Double(long) ?? 0.0
        }
        ratingDespLabel.text = cateDetails.text ?? ""
    }

    
    
}
