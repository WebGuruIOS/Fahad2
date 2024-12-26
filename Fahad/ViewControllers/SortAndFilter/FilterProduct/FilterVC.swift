//
//  FilterVC.swift
//  Fahad
//
//  Created by Prince on 26/03/22.
//

import UIKit
import RangeSeekSlider

class FilterVC: UIViewController{
    
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var max_Price: UILabel!
    
    @IBOutlet weak var tbl_CategoryTableView: UITableView!
    @IBOutlet weak var vw_ApplyBgView: UIView!
    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    
 //   var categoryViewModel2:CategoryViewModel2!
    var imgView = UIImageView()
    var categoryViewModel2:CategoryViewModel2!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tbl_CategoryTableView.register(UINib(nibName: "OthersTVCell", bundle: nil), forCellReuseIdentifier: "OthersTVCell")
        tbl_CategoryTableView.estimatedRowHeight = 100
        tbl_CategoryTableView.rowHeight = UITableView.automaticDimension
        tbl_CategoryTableView.separatorStyle = .none
        tbl_CategoryTableView.dataSource = self
        tbl_CategoryTableView.delegate = self
        
        setup()
        
    }
   
    private func setup() {
        // standard range slider
        rangeSlider.delegate = self
        rangeSlider.minValue = 1.0
       // self.minPrice.text = min
        rangeSlider.maxValue = 10000.0
        rangeSlider.lineHeight = 3.0
        rangeSlider.numberFormatter.positivePrefix = "$"
        rangeSlider.numberFormatter.locale = Locale(identifier: "en_US")
        rangeSlider.minLabelFont = UIFont(name:"ChalkboardSE-Regular", size: 15.0)!
        rangeSlider.maxLabelFont = UIFont(name: "ChalkboardSE-Regular", size: 15.0)!

    }

    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func act_Apply(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FilterVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if categoryViewModel2?.categorylist.count != 0{
            for _ in 0...(categoryViewModel2.categorylist.count - 1){
                categoryViewModel2.array.append(true)
            }
        }
        
        return categoryViewModel2.categorylist.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        imgView = UIImageView(frame: CGRect(x: tableView.frame.size.width-40, y: 10, width: 30, height: 30))
        imgView.image = UIImage(named: "Arrow")
         let label = UILabel(frame: CGRect(x: 10, y: 7, width: tableView.frame.size.width - 80, height: 20))
         label.font = label.font.withSize(16)
         label.textColor = .black
        label.text = categoryViewModel2.categorylist[section].title
         let button = UIButton(frame:CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
         button.tag = section
       //  button.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)
         view.addSubview(label)
         view.addSubview(button)
        view.addSubview(imgView)
        if categoryViewModel2.categorylist[section].subCategory.count == 0{
            imgView.isHidden = true
        }
       //  view.backgroundColor = MyHelper.hexStringToUIColor(hex: "#D9D9D9")
         return view
     }
    
    
    // NEW CODE
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoryViewModel2.array[section]{
            return 0
        }else{
            return categoryViewModel2.categorylist[section].subCategory.count
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OthersTVCell", for: indexPath) as! OthersTVCell
        cell.selectionStyle = .none
        if let _data = categoryViewModel2.categorylist[indexPath.section].subCategory[indexPath.item] as SubCategoryData?{
            cell.labelUnderline.text = _data.title
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _data = categoryViewModel2.categorylist[indexPath.section].subCategory[indexPath.item] as SubCategoryData?{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
            //secVC.cateId = subCateId
            secVC.cateId = _data.id
            secVC.extraParam = "appapi/product/category_wise_product"
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
 
}

extension FilterVC: RangeSeekSliderDelegate{

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
        }

    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}


