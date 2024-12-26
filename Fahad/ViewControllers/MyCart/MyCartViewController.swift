//
//  MyCartViewController.swift
//  Fahad
//
//  Created by Kondalu on 20/08/21.
//

import UIKit

class MyCartViewController: UIViewController {

    @IBOutlet weak var vw_checOutBgView: UIView!

    @IBOutlet weak var vw_NoDataBgView: UIView!
    
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    @IBOutlet weak var checkoutView: UIView!{
                didSet{
                    checkoutView.clipsToBounds = true
                    checkoutView.layer.cornerRadius = checkoutView.frame.size.height / 2
                    }
    }
    @IBOutlet weak var myCartTV: UITableView!
    var myCartDataArr = [MyCartResponseData]()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var mainTotal = String()
    var total = String()
    var addTotal = String()
    var tax = String()
    var discount = Int()
    var discount1 = String()
    var counterValue = Int()
    var shippingCode = String()
    var shippingRate = String()
    var shippingName = String()
    var shippingArr = [Shipping_total]()
    var cartId = String()
    var myCartIdArr = [String]()
    var checkdisount = String()
    var checkTotal = String()
    let nf = NumberFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // vw_NoDataBgView.isHidden = tr
        //Trending Now
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        myCartTV.delegate = self
        myCartTV.dataSource = self
        myCartTV.register(UINib(nibName: "MyCartTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCartTableViewCell")
        }else{
            //Commented by prince 24/06/2022
           // orderDetails()
        }
       // self.vw_checOutBgView.clipsToBounds 
        self.setNeedsStatusBarAppearanceUpdate()
        myCartData()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        myCartDataArr = []
       
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        myCartDataArr.removeAll()
        myCartIdArr.removeAll()
       // myCartData()
     // myCartTV.reloadData()
            //self.vw_checOutBgView.isHidden = true
        }else{
            orderDetails()
        }
    }
   
    func orderDetails(){
        let alertController = UIAlertController(title: "For use this features you need an account", message: "Do you want Login an account", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel" , style: .default) { (_ action) in
            self.navigationController?.popViewController(animated: true)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func checkOutButton(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
        secVC.check = "2"
        secVC.hide = "5"
        secVC.Shippingrate = shippingRate
        secVC.shippingname = shippingName
        secVC.shippingCode = shippingCode
        secVC.checkTotal = checkTotal
        secVC.disount = checkdisount
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func myCartData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)","currency_code":"USD","language_id":"\(languageID)"]
        MyCartDataResponce.AddUserData(api: "appapi/cart/cart_list", parameters: parameters) { (data) in
            if data != nil{
                // print("Datavalue:",data ?? "")
                self.myCartDataArr = []
                let status = data?.responseCode
                self.myCartDataArr.removeAll()
                self.myCartIdArr.removeAll()
                
                print("ArrVAlue:",self.myCartDataArr)
               //Banner Slider
                if let data = data?.responseData{
                     self.myCartDataArr = []
                    
                    for i in 0..<(data.count )  { //- 1
                    self.myCartDataArr.append(data[i])
                        
                        //if self.myCartDataArr.count != 0 {
                            let gg = data[i].cartId ?? ""
                                self.myCartIdArr.append(gg)
                                print("myCartIdArr",self.myCartIdArr)
                        //}
                    
                   }
                }
                if let data1 = data?.responseExtraData{
                    let cartTotal = data1.cart_total ?? ""
                    let shippingDetails = data1.shipping_total
                    for i in 0..<shippingDetails!.count{
                        self.shippingArr.append((shippingDetails?[i])!)
                        DispatchQueue.main.async {
                            
                            self.shippingCode = self.shippingArr[i].code ?? ""
                            self.shippingName = self.shippingArr[i].title ?? ""
                            self.shippingRate = self.shippingArr[i].cost ?? "1"
                            print("cartId1234",self.shippingRate)
                        
                        let intCarttotal = self.nf.number(from: "\(cartTotal)")?.intValue
                            print("intCarttotal",intCarttotal ?? "")
                        let cost = self.nf.number(from: "\(self.shippingRate)")?.intValue
                            print("cost",cost ?? "")
                        let ss = (Int(intCarttotal ?? 0)) // (Int(cost ?? 0))
                            print("ss",ss )
                        let totalPay = (Double(intCarttotal ?? 0)) //+ (Int(cost ?? 0))
                            print("ss",totalPay )
                        self.totalPaymentLabel.text = "Total Pay: $\(totalPay)"
                            self.discountLabel.text = "Save: $\(0.0)"
                            self.checkdisount = "$\(ss)"
                        }
                    }
                    let tt = data1.orginal_cost_total ?? ""
                   
                    print("sssss111",self.shippingRate )
                    print("ShipingArray:",self.shippingArr)
                    // let ta = data1.tax_total ?? ""
                    
                 //   self.checkdisount = "$\(ta)"
                    self.checkTotal = "$\(tt)"
                   
                }
               switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                        debugPrint(self.myCartDataArr)
                        self.myCartTV.reloadData()
                        self.vw_NoDataBgView.isHidden = true
                        self.vw_checOutBgView.isHidden = false
                    }
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                    if self.myCartDataArr.count == 0{
                        self.vw_checOutBgView.isHidden = true
                        self.vw_NoDataBgView.isHidden = false
                    }else{
                        self.vw_NoDataBgView.isHidden = true
                        self.vw_checOutBgView.isHidden = false
                    }
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                }
            }
        }
    }
    @objc func incrementButton(sender : UIButton){
       let yy =  myCartDataArr[sender.tag].quantity ?? ""
        let nf1 = NumberFormatter()
        let x1 = nf1.number(from: "\(yy)")?.intValue ?? 0
       let indexPath = IndexPath.init(row: x1, section: 0)
        let cell = myCartTV.cellForRow(at: indexPath) as? MyCartTableViewCell
        let qua = myCartDataArr[sender.tag].quantity ?? ""
        let nf = NumberFormatter()
        let x = nf.number(from: "\(qua)")?.intValue
        counterValue = x ?? 0
           counterValue += 1;
        cell?.countLabel.text = "\(counterValue)"
        let value = "\(counterValue)"
      //  cell?.countLabel.text = "\(value)"
        let parameters:[String:Any] = ["customer_id":"\(customerId)","cart_id":"\(myCartIdArr[sender.tag])","quantity":"\(value)"]
        VerifyOtpDataResponce.AddUserData(api: "appapi/cart/update_to_cart", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData ?? ""
                print("code",code)
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                    self.myCartDataArr.removeAll()
                    self.myCartData()
                    self.myCartTV.reloadData()
                  ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    self.myCartTV.reloadData()
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
    
    @objc func decrementButton(sender : UIButton){
        let yy =  myCartDataArr[sender.tag].quantity ?? ""
         let nf1 = NumberFormatter()
         let x1 = nf1.number(from: "\(yy)")?.intValue ?? 0
        let indexPath = IndexPath.init(row: x1, section: 0)
         let cell = myCartTV.cellForRow(at: indexPath) as? MyCartTableViewCell
         let qua = myCartDataArr[sender.tag].quantity ?? ""
         let nf = NumberFormatter()
         let x = nf.number(from: "\(qua)")?.intValue
        if x == 1{
            ApiService.shared.showAlert(title: "", msg: "quantity value greater than 0" )
        }else{
         counterValue = x ?? 0
            counterValue -= 1;
         cell?.countLabel.text = "\(counterValue)"
         let value = "\(counterValue)"
       //  cell?.countLabel.text = "\(value)"
         let parameters:[String:Any] = ["customer_id":"\(customerId)","cart_id":"\(myCartDataArr[sender.tag].cartId ?? "")","quantity":"\(value)"]
         VerifyOtpDataResponce.AddUserData(api: "appapi/cart/update_to_cart", parameters: parameters) { (data) in
             if data != nil{
                 let responseCode = data?.responseCode
                 let responseText = data?.responseText ?? ""
                 let code = data?.responseData ?? ""
                 print("code",code)
                 print("statuse Is",responseCode ?? 0)
                 switch responseCode {
                 case 1:
                     self.myCartDataArr.removeAll()
                     self.myCartData()
                     self.myCartTV.reloadData()
                   ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                 case 0:
                     self.myCartTV.reloadData()
                     ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                 default:
                     ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                 }
             }
         }
      }
    }
    func removeWishListData(sender:UIButton){
      
        let parameters:[String:Any] = ["CartId": "\(myCartIdArr[sender.tag])"]
        VerifyOtpDataResponce.AddUserData(api: "appapi/cart/cart_data_delete", parameters: parameters) { (data) in
           if data != nil{
               let status = data?.responseCode
               let text = data?.responseText ?? ""
               print("statuse Is",status ?? 0)
               switch status {
               case 1:
                   print("sucess")
                   DispatchQueue.main.async {
                   self.myCartTV.reloadData()
                       self.myCartData()

                       
                       if self.myCartDataArr.count != 0{
                           self.vw_NoDataBgView.isHidden = true
                       }else{
                           self.vw_NoDataBgView.isHidden = false
                       }
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
    @objc func nHapusTap(sender: UIButton) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = myCartTV.cellForRow(at: indexPath) as? MyCartTableViewCell
        let hitPoint = sender.convert(CGPoint.zero, to: myCartTV)
        if let indexPath = myCartTV.indexPathForRow(at: hitPoint) {
            self.myCartDataArr.remove(at: sender.tag)
            myCartTV.beginUpdates()
            removeWishListData(sender: (cell?.deleteButton)!)
            myCartTV.deleteRows(at: [indexPath], with: .automatic)
            myCartTV.endUpdates()
            
        }
    }
}
extension MyCartViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myCartDataArr.count == 0{
            self.vw_checOutBgView.isHidden = true
        }else{
            self.vw_checOutBgView.isHidden = false
        }
        return myCartDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myCartTV.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        cell.homeSetUP(myCartDataArr[indexPath.row])
        cartId = myCartDataArr[indexPath.row].cartId ?? ""
        cell.decrementButton.tag = indexPath.row
        cell.incrementButton.tag = indexPath.row
        cell.incrementButton.addTarget(self, action: #selector(incrementButton(sender:)), for: .touchUpInside)
        cell.decrementButton.addTarget(self, action: #selector(decrementButton(sender:)), for: .touchUpInside)
        cell.deleteButton.tag = indexPath.row
       cell.deleteButton.addTarget(self, action: #selector(nHapusTap(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
