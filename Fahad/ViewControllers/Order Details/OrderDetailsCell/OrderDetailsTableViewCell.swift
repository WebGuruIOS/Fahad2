//
//  OrderDetailsTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 30/08/21.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var tableviewHeightCon: NSLayoutConstraint!
    @IBOutlet weak var newPricelabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var sizeTV: UITableView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imagview: UIImageView!
    var obejectArr = [PrdOption]()
    override func awakeFromNib() {
        super.awakeFromNib()
        sizeTV.delegate = self
        sizeTV.dataSource = self
        sizeTV.register(UINib(nibName: "OrderSizeTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderSizeTableViewCell")
        self.sizeTV.rowHeight  = UITableView.automaticDimension
        self.sizeTV.estimatedRowHeight = 80
    }
    func homeSetUP(_ cateDetails: Product){
        nameLabel.text = cateDetails.name ?? ""
        newPricelabel.text = cateDetails.price ?? ""
        oldPriceLabel.text = cateDetails.price ?? ""
        quantityLabel.text = "Quantity : \(cateDetails.quantity ?? "")"
        let data = cateDetails.productImage ?? ""
        let stringWithoutSpaces = data.replacingOccurrences(of: " ", with: "%20")
        if let imageUrl:URL = URL(string:stringWithoutSpaces) {
            imagview.kf.setImage(with: imageUrl)
        }
//        if let imageUrl:URL = URL(string:"\(data)") {
//            imagview.kf.setImage(with: imageUrl)
//        }
//
        
        /*
         typeLabel.text = cateDetails.productName
         let imgUrl:String = cateDetails.productImage ?? ""
         let stringWithoutSpaces = imgUrl.replacingOccurrences(of: " ", with: "%20")
        DispatchQueue.main.async {
             if let imageUrl:URL = URL(string:stringWithoutSpaces) {
                 self.imgView.kf.setImage(with: imageUrl)

        }
     }
         */
    }
}
extension OrderDetailsTableViewCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return obejectArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sizeTV.dequeueReusableCell(withIdentifier: "OrderSizeTableViewCell") as! OrderSizeTableViewCell
        cell.propertyNameLabel.text = "\(obejectArr[indexPath.row].name ?? "") :"
        cell.propertyValueLabel.text = obejectArr[indexPath.row].value ?? "nil"
        if obejectArr[indexPath.row].value == "nil"{
           
            tableviewHeightCon.constant = 0
        }else{
            tableviewHeightCon.constant = (30 * CGFloat(obejectArr.count))
        }
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if obejectArr.count == 0{
            return 0
        }else{
            return 30
        }
       
    }
    
}
