//
//  SizeTableViewCell.swift
//  Fahad
//
//  Created by Kondalu on 28/09/21.
//

import UIKit
protocol ProductTableViewCellDelegate {
    func selectedItem(attributeName:String,subAttributeData:ProductOptionValue)
}
class SizeTableViewCell: UITableViewCell {
    var delegate:ProductTableViewCellDelegate?
    var objectArr = [ProductOptionValue]()
    var attributeId:String?
    @IBOutlet weak var productValueCV: UICollectionView!
    @IBOutlet weak var productNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 40)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.productValueCV.collectionViewLayout = flowLayout
        self.productValueCV.showsHorizontalScrollIndicator = false
        
        productValueCV.delegate = self
        productValueCV.dataSource = self
        productValueCV.register(UINib(nibName: "AttributeCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "AttributeCollectionViewCell")
           productValueCV.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SizeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objectArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productValueCV.dequeueReusableCell(withReuseIdentifier: "AttributeCollectionViewCell", for: indexPath) as! AttributeCollectionViewCell
        cell.valueLabel.text = objectArr[indexPath.item].name
        
        
        cell.valueLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.valueLabel.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        DispatchQueue.main.async {
//            self.delegate1?.selectedItem1(attributeName:self.sizelabel.text!,subAttributeData:self.obejectArr1[1],attributeId:self.attributeId!)
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as? AttributeCollectionViewCell
        cell?.valueLabel.textColor = .white
        cell?.valueLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        
        let productOptionValueId = objectArr[indexPath.row].productOptionValueId
        print("productOptionValueId:",productOptionValueId ?? "")
        let optionValueId = objectArr[indexPath.row].optionValueId
        print("optionValueId:",optionValueId ?? "")
        print("123",productOptionValueId ?? "")
        optionId = productOptionValueId ?? ""
       // cell?.attributeView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
       
       DispatchQueue.main.async {
            self.delegate?.selectedItem(attributeName:self.productNameLabel.text ?? "",subAttributeData:self.objectArr[indexPath.item])
        
            //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
       
       
      //  self.selectedIndexPath = indexPath
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? AttributeCollectionViewCell
        cell?.valueLabel.backgroundColor = .white
        cell?.valueLabel.textColor = .black
       // cell?.attributeView.backgroundColor = .white
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
