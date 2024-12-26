//
//  TrendingTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 16/08/21.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainview.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        mainview.layer.borderWidth = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
