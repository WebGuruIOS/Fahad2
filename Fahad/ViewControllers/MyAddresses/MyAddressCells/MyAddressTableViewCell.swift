//
//  MyAddressTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 19/08/21.
//

import UIKit

class MyAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var pinCodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var streetAdressLabel: UILabel!
    @IBOutlet weak var adressnameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        addressView.layer.cornerRadius = 10
        addressView.layer.masksToBounds = false
        addressView.layer.shadowColor = UIColor.lightGray.cgColor
        addressView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        addressView.layer.shadowRadius = 5.0
        addressView.layer.shadowOpacity = 0.5
    }

   
    func homeSetUP(_ cateDetails: MyAdressResponseData){
        let firstName = cateDetails.firstname ?? ""
        let lastname = cateDetails.lastname ?? ""
        let name = ("\(firstName) "  +  lastname)
        self.nameLabel.text = name
        let add1 = cateDetails.address1 ?? ""
        let add2 = cateDetails.address2 ?? ""
        let address = ("\(add1) "  +  add2)
        self.adressnameLabel.text = address
        streetAdressLabel.text = cateDetails.strAddress ?? ""
        stateLabel.text = cateDetails.city ?? ""
        countryLabel.text = cateDetails.country ?? ""
        pinCodeLabel.text = cateDetails.postcode ?? ""
        mobileLabel.text = cateDetails.phone ?? ""
        }
    
    
}
