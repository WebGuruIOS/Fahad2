//
//  SortAndFilterViewController.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit


class SortAndFilterViewController: UIViewController {

    @IBOutlet weak var vw_noDataBgView: UIView!
    @IBOutlet weak var img_NoData: UIImageView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var mainCartView: UIView!{
        didSet{
            mainCartView.clipsToBounds = true
            mainCartView.layer.cornerRadius = mainCartView.frame.size.width / 2
            }
        }
    var cateId = String()
    
    @IBOutlet weak var vw_PriceBgView: UIView!
    @IBOutlet weak var tbl_SortPriceTblView: UITableView!
    
    @IBOutlet weak var sortAndFiterVC: UICollectionView!
    var sortlistArr = [SortResponseData]()
    var extraParam = String()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var wishId = String()
    var sortId = String()
    var sortArrList = [[String:Any]]()

    
    @IBOutlet weak var vw_SortBgView: UIView!
    
   // var sortArrList = ["Popularity","Price - Low to High","Price - High to Low","Newest"]
    
   // var dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        //ScrollImages
      //  tbl_Price_TblView.delegate = self
       // tbl_Price_TblView.dataSource = self
        self.vw_noDataBgView.isHidden = false
       
        
        sortId = "0"
        sortAndFiterVC.delegate = self
        sortAndFiterVC.dataSource = self
        sortAndFiterVC.register(UINib(nibName: "SortAndFilterCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SortAndFilterCollectionViewCell")
        if cateId.isEmpty == true{
            sortlistData()
        }else{
            catesortlistData()
        }
        
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        
        let sortBgTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideSortBgView))
        vw_SortBgView.isUserInteractionEnabled = true
        sortBgTapGestureRecognizer.numberOfTapsRequired = 2
       vw_SortBgView.addGestureRecognizer(sortBgTapGestureRecognizer)
        
        
        //vw_PriceBgView.gestureRecognizers?.forEach(vw_PriceBgView.removeGestureRecognizer)
        
        self.setNeedsStatusBarAppearanceUpdate()
       print("All product:",extraParam)
        self.vw_PriceBgView.isHidden = true
        sortArrList = [["filterCond":"Popularity".localiz()],["filterCond":"Price - Low to High".localiz()],["filterCond":"Price - High to Low".localiz()],["filterCond":"Newest".localiz()]]
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
   }
    
    @objc func hideSortBgView(){
        self.vw_SortBgView.isHidden = true
        self.vw_PriceBgView.isHidden = true
        
   }
    @IBAction func sortButtonAction(_ sender: UIButton) {
        
        self.vw_SortBgView.isHidden = false
        self.vw_PriceBgView.isHidden = false
//        print("jsdfghjgjhghj")
//        dropDown.dataSource = ["Sort Asending","High-To-Low","Low-To-High","Sort Desending"]
//        dropDown.dataSource1 = ["0","1","2","3"]
//          dropDown.anchorView = sender  //5
//           dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
//           dropDown.show() //7
//       dropDown.selectionAction = { [weak self] (index: Int, item: String, item1: String) in //8
//             guard let _ = self else { return }
//           sender.setTitle(item, for: .normal)
//           self?.sortId = item1
//        if self?.cateId.isEmpty == true{
//            self?.sortlistArr.removeAll()
//            self?.sortlistData()
//            self?.catesortlistData()
//        }else{
//            self?.catesortlistData()
//            self?.sortlistArr.removeAll()
//        }
//           }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func act_Filter(_ sender: Any) {
        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       // self.navigationController?.navigationBar.isHidden = true
    }
    //brand
    func sortlistData(){
        print("sort id is\(sortId)")
        //let currCode = "USD"
        //let finalCurrCode = Int(currCode)
        
        let parameters:[String:Any] = ["customer_id":"\(customerId)","currency_code":"USD","language_id":"\(languageID)","sort":"\(sortId)","is_filter":"0","range_start":"0","range_end":"24000","category_id":""]
        SortDataResponce.AddUserData(api: "\(extraParam)", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                
               //Banner Slider
                if let data1 = data?.responseData{
                    for i in 0..<data1.count{
                        DispatchQueue.main.async {
                            self.sortlistArr.append(data1[i])
                        }
                   }
                }
               switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                        if self.sortlistArr.isEmpty == true{
                            ApiService.shared.showAlert(title: "", msg: "No data Found".localiz() )
                        }
                        self.sortAndFiterVC.reloadData()
                    }
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong".localiz() )
                default:
                    ApiService.shared.showAlert(title: "", msg: "No Product Found".localiz() )
                }
            }
        }
    }
    func catesortlistData(){
        let parameters:[String:Any] = ["customer_id":"","currency_code":"USD","language_id":"\(languageID)","sort":"\(sortId)","is_filter":"0","range_start":"0","range_end":"24000","category_id":"\(cateId)","brand":""]
        SortDataResponce.AddUserData(api: "\(extraParam)", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                
               //Banner Slider
                if let data1 = data?.responseData{
                    for i in 0..<data1.count{
                        DispatchQueue.main.async {
                            self.sortlistArr.append(data1[i])
                            self.vw_noDataBgView.isHidden = true
                        }
                   }
                }
               switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                        if self.sortlistArr.isEmpty == true{
                            ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                            self.vw_noDataBgView.isHidden = false
                        }
                        self.sortAndFiterVC.reloadData()
                    }
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                }
            }
        }
    }
    @objc func bestSellrProductfavButton(sender:UIButton){
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = sortAndFiterVC.cellForItem(at: indexPath) as? SortAndFilterCollectionViewCell
        let parameters:[String:Any] = ["product_id": "\(sortlistArr[sender.tag].productId ?? "")","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    if data?.responseStatus == "0"{
                        cell?.whiteButton.isHidden = false
                        cell?.redFavButton.isHidden = true
                    }else{
                        cell?.whiteButton.isHidden = true
                        cell?.redFavButton.isHidden = false
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)".localiz() )
                    DispatchQueue.main.async {
                        self.sortlistArr.removeAll()
                        self.sortlistData()
                        self.catesortlistData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
}
extension SortAndFilterViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sortAndFiterVC{
            return sortlistArr.count
        }
        else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = sortAndFiterVC.dequeueReusableCell(withReuseIdentifier: "SortAndFilterCollectionViewCell", for: indexPath) as! SortAndFilterCollectionViewCell
        cell.homeSetUP(sortlistArr[indexPath.row])
        cell.redFavButton.tag = indexPath.row
        cell.whiteButton.tag = indexPath.row
        wishId = "\(sortlistArr[indexPath.row].isWishlist ?? "")"
        cell.redFavButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
        cell.whiteButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
         print("wishId",wishId)
        if wishId == "0"{
            cell.whiteButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.isHidden = false
            cell.redFavButton.isHidden = true
        }else if wishId == "1"{
            cell.redFavButton.addTarget(self, action: #selector(bestSellrProductfavButton(sender:)), for: .touchUpInside)
            cell.whiteButton.isHidden = true
            cell.redFavButton.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            secVC.productId = sortlistArr[indexPath.row].productId ?? ""
            secVC.sellerId = "1"
        secVC.imageString = sortlistArr[indexPath.row].thumb ?? ""
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var columnCount = Int()
        if sortlistArr.count == 1{
           columnCount = 1
        }else{
           columnCount = 2
        }
        
        let width  = (Int(view.frame.width) - 20) / columnCount
            return CGSize(width: width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == sortAndFiterVC{
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }else{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
}

extension SortAndFilterViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortArrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tbl_SortPriceTblView.dequeueReusableCell(withIdentifier: "SortPriceCell", for: indexPath) as! SortCustCell
        let dict:[String:Any] = sortArrList[indexPath.row]
        cell.lbl_PriceSort.text = dict["filterCond"] as? String
        
           cell.selectionStyle = .none
           return  cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict:[String:Any] = sortArrList[indexPath.row]
        let selectedValue = dict["filterCond"] as? String
        self.vw_SortBgView.isHidden = true
        self.vw_PriceBgView.isHidden = true
        print("SelectedValue:",selectedValue)
    }
    
   
}
