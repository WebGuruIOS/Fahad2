//
//  ProductSearchViewController.swift
//  Fahad
//
//  Created by Kondalu on 28/09/21.
//

import UIKit

class ProductSearchViewController: UIViewController {

    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var mainCartView: UIView!{
        didSet{
            mainCartView.clipsToBounds = true
            mainCartView.layer.cornerRadius = mainCartView.frame.size.width / 2
            }
        }
    
    @IBOutlet weak var searchTV: UITableView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var vw_NoDataFoundView: UIView!
    
    var searchListArr = [SearchResponseData]()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTV.delegate = self
        searchTV.dataSource = self
        searchTV.register(UINib(nibName: "ProductSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductSearchTableViewCell")
        searchTF.placeholder = "Search Product"
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        self.setNeedsStatusBarAppearanceUpdate()
        self.vw_NoDataFoundView.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
   }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchListArr.removeAll()
        searchListData()
    }
    func searchListData(){
        let parameters:[String:Any] = ["product_name":"\(searchTF.text ?? "")","customer_id":"\(customerId)","currency_code":"USD","language_id":"\(languageID)"]
        ProductSearchDataResponce.AddUserData(api: "appapi/product/product_search", parameters: parameters) { (data) in
            if data != nil{
               if let data = data?.responseData{
                        for i in 0..<data.count{
                        self.searchListArr.append(data[i])
                            self.vw_NoDataFoundView.isHidden = true
                        }
               }
                DispatchQueue.main.async {
                    self.searchTV.reloadData()
                    if self.searchListArr.count == 0{
                        self.vw_NoDataFoundView.isHidden = false
                        ApiService.shared.showAlert(title: "", msg: "No Data Found" )
                    }
                   
                }
            }
         }
      }
}

extension ProductSearchViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchListArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTV.dequeueReusableCell(withIdentifier: "ProductSearchTableViewCell", for: indexPath) as! ProductSearchTableViewCell
        cell.homeSetUP(searchListArr[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        updateProfileVC.productId = searchListArr[indexPath.row].product_id ?? ""
        updateProfileVC.imageString = searchListArr[indexPath.row].thumb ?? ""
        updateProfileVC.sellerId = "1"
        self.navigationController?.pushViewController(updateProfileVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 120
    }
    

}
