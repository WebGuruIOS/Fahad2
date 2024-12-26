//
//  WishlistViewController.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit

class WishlistViewController: UIViewController {

    @IBOutlet weak var vw_NoDataBgView: UIView!
    @IBOutlet weak var cartMainView: UIView!{
        didSet{
            cartMainView.clipsToBounds = true
            cartMainView.layer.cornerRadius = cartMainView.frame.size.width / 2
            }
        }
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var wishlistTV: UITableView!
    var wishlistArr = [WishlistResponseData]()
    var wishIdArr = [String]()
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        //Trending Now
        wishlistTV.delegate = self
        wishlistTV.dataSource = self
        wishlistTV.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell") 
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
       // self.wishlistTV.rowHeight  = UITableView.automaticDimension
       // self.wishlistTV.estimatedRowHeight = 80
        }else{
           orderDetails()
        }
       
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default //lightContent
    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    func orderDetails(){
        let alertController = UIAlertController(title: "For use this features you need an account", message: "Do you want Login an account", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel" , style: .default) { (_ action) in
//            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//           self.navigationController?.pushViewController(updateProfileVC, animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
            wishIdArr.removeAll()
            wishlistArr.removeAll()
            wishListData()
        }else{
            orderDetails()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    // let parameters:[String:Any] = ["customer_id":"\(customerId)","currency_code":"USD","language_id":"\(languageID)"]
    func wishListData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)","currency_code":"USD","language_id":"\(languageID)"]
        WishListDataResponce.AddUserData(api: "appapi/wishlist/my_wishlist", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode

                   if let data = data?.responseData{
                        for i in 0..<data.count{
                        self.wishlistArr.append(data[i])
                            let gg = self.wishlistArr[i].productId ?? ""
                                self.wishIdArr.append(gg)
                                print("myCartIdArr",self.wishIdArr)
                        }
                    }
               switch status {
                case 1:
                    print("sucess")
                    if self.wishlistArr.isEmpty == true{
                        ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                    }else{
                    DispatchQueue.main.async {
                        if self.wishlistArr.isEmpty{
                            self.vw_NoDataBgView.isHidden = false
                        }else{
                            self.vw_NoDataBgView.isHidden = true
                        }
                    self.wishlistTV.reloadData()
                    }
                }
                case 201:
                    ApiService.shared.showAlert(title: "WARNING", msg: "\(data?.responseText ?? "")" )
                default:
                  
                    ApiService.shared.showAlert(title: "WARNING", msg: "\(data?.responseText ?? "")" )
                   if self.wishlistArr.isEmpty{
                       self.vw_NoDataBgView.isHidden = false
                   }else{
                       self.vw_NoDataBgView.isHidden = true
                   }
                }
            }
        }
    }
    @objc func nHapusTap(sender: UIButton) {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = wishlistTV.cellForRow(at: indexPath) as? WishlistTableViewCell
        let hitPoint = sender.convert(CGPoint.zero, to: wishlistTV)
        
        let alertController = UIAlertController(title: "", message: "Do you want to remove this product ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            
         
            if let indexPath = self.wishlistTV.indexPathForRow(at: hitPoint) {

                self.wishlistArr.remove(at: indexPath.row)
                self.wishlistTV.beginUpdates()
                
                
                self.removeWishListData(sender: (cell?.deleteButton)!)
                self.wishlistTV.deleteRows(at: [indexPath], with: .automatic)
               self.wishlistTV.endUpdates()

            }
           
        }
        let cancelAction = UIAlertAction(title:"Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
       
    }
     func removeWishListData(sender:UIButton){
       
        let parameters:[String:Any] = ["product_id": "\(wishIdArr[sender.tag])","customer_id": "\(customerId)"]
        RemoveAndAddWishListDataResponce.AddUserData(api: "appapi/wishlist/add", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText ?? ""
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                        
                        if self.wishlistArr.isEmpty{
                            self.vw_NoDataBgView.isHidden = false
                        }else{
                            self.vw_NoDataBgView.isHidden = true
                        }
                    self.wishlistTV.reloadData()
                        
                        
                        
                    }
                   ApiService.shared.showAlert(title: "", msg: "\(text)" )
                   
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "something" )
                }
            }
        }
        
    }
}
extension WishlistViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishlistArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = wishlistTV.dequeueReusableCell(withIdentifier: "WishlistTableViewCell", for: indexPath) as! WishlistTableViewCell
        cell.selectionStyle = .none
        cell.homeSetUP(wishlistArr[indexPath.row])
       // id = wishListArr[indexPath.row].product_id ?? ""
        cell.deleteButton.tag = indexPath.row
      
        cell.deleteButton.addTarget(self, action: #selector(nHapusTap(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            secVC.productId = wishlistArr[indexPath.row].productId ?? ""
            secVC.sellerId = "1"
        secVC.imageString = wishlistArr[indexPath.row].thumb ?? ""
        secVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    
}


/*
 let alertController = UIAlertController(title: "", message: "Do you want to Logout?", preferredStyle: .alert)
 let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
     UIAlertAction in
     NSLog("OK Pressed")
 
     UserDefaults.standard.removeObject(forKey:"user_id")
     let vc = self.storyboard?.instantiateViewController(withIdentifier:"HomeVC") as? HomeVC
     self.navigationController?.pushViewController(vc!, animated: true)
//                    let time = DispatchTime.now() + 1
//                    DispatchQueue.main.asyncAfter(deadline:time){
//                        if let viewControllers = self.navigationController?.viewControllers{
//                            for vc in viewControllers {
//                                if vc.isKind(of: HomeVC.classForCoder()){
//                                    self.navigationController!.popToViewController(vc, animated:true)
//                                }
//                            }
//                        }
//                    }
     
 }
}
 */

//extension WishlistViewController {
//    var statusBarView: UIView? {
//        if responds(to: Selector(("statusBar"))) {
//            return value(forKey: "statusBar") as? UIView
//        }
//        return nil
//    }
//}
//
//WishlistViewController.shared.statusBarView?.backgroundColor = .red
//
