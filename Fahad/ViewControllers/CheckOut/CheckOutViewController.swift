//
//  CheckOutViewController.swift
//  Fahad
//
//  Created by Kondalu on 29/09/21.
//

import UIKit
import Stripe
class CheckOutViewController: UIViewController{

    @IBOutlet weak var proceedView: UIView!{
        didSet{
            proceedView.clipsToBounds = true
            proceedView.layer.cornerRadius = 30
            proceedView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    
    @IBOutlet weak var casRedButton: UIButton!
    @IBOutlet weak var onlineRedButton: UIButton!
    @IBOutlet weak var changeAddressButton: UIButton!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var mrpLabel: UILabel!
    @IBOutlet weak var cashButton: UIButton!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var mode = String()
    var str = String()
    var cartIDArr = [Any]()
    var shippingCode = String()
    var shippingName = String()
    var shippingrate = String()
    var addressId = String()
    var billingAddress = String()
   
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    
    var checkoutDataArr : CheckoutResponseData?
    var cartArr = [CheckOutCart]()
    var label7 = String()
    var label8 = String()
    var label9 = String()
    var label10 = String()
    var label11 = String()
    var label12 = String()
    var cartId = String()
    var fullName = String()
    var disount = String()
    var checkTotal = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        changeAddressButton.layer.cornerRadius = 20
        changeAddressButton.layer.masksToBounds = true
        nameLabel.text = fullName
        firstView.layer.cornerRadius = 3
        firstView.layer.masksToBounds = false
        firstView.layer.shadowColor = UIColor.lightGray.cgColor
        firstView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        firstView.layer.shadowRadius = 5.0
        firstView.layer.shadowOpacity = 0.5
        
        secondView.layer.cornerRadius = 3
        secondView.layer.masksToBounds = false
        secondView.layer.shadowColor = UIColor.lightGray.cgColor
        secondView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        secondView.layer.shadowRadius = 5.0
        secondView.layer.shadowOpacity = 0.5
        
        thirdView.layer.cornerRadius = 3
        thirdView.layer.masksToBounds = false
        thirdView.layer.shadowColor = UIColor.lightGray.cgColor
        thirdView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        thirdView.layer.shadowRadius = 5.0
        thirdView.layer.shadowOpacity = 0.5
        label1.text = label7
        label2.text = label8
        label3.text = label9
        label4.text = label10
        label5.text = label11
        label6.text = label12
        
        mode = "0"
        onlineButton.setImage(UIImage(named: "grayCircle"), for: .normal)
        cashButton.setImage(UIImage(named: "grayCircle"), for: .normal)
        CheckoutListData()
        self.setNeedsStatusBarAppearanceUpdate()
        onlineRedButton.isHidden = true
        casRedButton.isHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func proceedButtonAction(_ sender: UIButton) {
        if mode == "online"{
            ApiService.shared.showAlert(title: "", msg: "Under Development" )
        }else if mode == "cod"{
           usingCod()
        }
        else{
            ApiService.shared.showAlert(title: "", msg: "Please Enter Payment Mode" )
        }
    }
    @IBAction func cashButtonAction(_ sender: UIButton) {
        if cashButton.isSelected{
            cashButton.setImage(UIImage(named: "grayCircle"), for: .normal)
          //  onlineButton.setImage(UIImage(named: "redCircle"), for: .normal)
            onlineRedButton.isHidden = false
            casRedButton.isHidden = true
            mode = "0"
            print("jj",mode)
        }else{
            onlineButton.setImage(UIImage(named: "grayCircle"), for: .normal)
           // cashButton.setImage(UIImage(named: "redCircle"), for: .normal)
            casRedButton.isHidden = false
            onlineRedButton.isHidden = true
            mode = "cod"
            print("jjj",mode)
        }
    }
 

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func onlineButtonAction(_ sender: UIButton) {
        if onlineButton.isSelected{
            onlineButton.setImage(UIImage(named: "grayCircle"), for: .normal)
           // cashButton.setImage(UIImage(named: "redCircle"), for: .normal)
            casRedButton.isHidden = false
            onlineRedButton.isHidden = true
            mode = "0"
           
        }else{
            cashButton.setImage(UIImage(named: "grayCircle"), for: .normal)
          //  onlineButton.setImage(UIImage(named: "redCircle"), for: .normal)
            onlineRedButton.isHidden = false
            casRedButton.isHidden = true
            mode = "online"
            let addCardViewController = STPAddCardViewController()
            addCardViewController.delegate = self
            
            // Present add card view controller
            let navigationController = UINavigationController(rootViewController: addCardViewController)
            present(navigationController, animated: true)
            print("jjj",mode)
        }
    }
    @IBAction func changeAddressAction(_ sender: UIButton) {
        let addAddress = self.storyboard?.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
        addAddress.hide = "5"
        addAddress.check = "2"
        self.navigationController?.pushViewController(addAddress, animated: true)
    }
    func usingCod(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)","cart_id":cartId,"shipping_code":"\(shippingCode)","shipping_name":"\(shippingName)","shipping_rate":"\(shippingrate)","order_description":"test","address_id":"\(addressId)","billing_address":"\(addressId)","coupon":"","coupon_amount":"","transaction_id":"","currency_code":"USD"]
        VerifyOtpDataResponce.AddUserData(api: "appapi/order/make_order", parameters: parameters) { (data) in
            if data != nil{
               let status = data?.responseCode
               
                print("statuse Is",status ?? 0)
                switch status {
                case 1:
                    let secVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderListViewController") as! OrderListViewController
                    self.navigationController?.pushViewController(secVC, animated: true)
                    ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                default:
                    ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                }
            }
        }
    }
    func CheckoutListData(){
    let parameters:[String:Any] = ["language_id":"\(languageID)","customer_id":"\(customerId)","currency_code":"USD","coupon_code":"1111"]
        CheckoutDataResponce.AddUserData(api: "appapi/cart/checkOut", parameters: parameters) { (data) in
        if data != nil{
            let status = data?.responseCode
            
            if let data1 = data?.responseData{
                self.checkoutDataArr = data1
                let ff = self.checkoutDataArr?.cart
                for i in 0..<ff!.count{
                    DispatchQueue.main.async {
                        self.cartArr.append((ff?[i])!)
                        self.cartId = self.cartArr[i].cartId ?? ""
                      //  self.cartId = id
                        
//                        self.cartId =  self.cartId + "," + self.cartArr[i].cartId!
//                        self.cartIDArr.append(id)
//                        print("cartId",self.cartId)
                        
                        
//                        for i in self.cartArr{
//                            self.cartId = self.cartId + "," + "\(self.cartArr[i].cartId)"
//                            print("cartId12345",self.cartId)
////                            print("names",names)
//                         //   print("qwerty",names, terminator: "")
//                        }
                     //   print("cartId12345123",self.str)
                        
                       // print("cartId1234",id)
                        
                    }
                    
                }
               
                let res = self.checkoutDataArr?.responseExtraData
                var price:Double = 0.0
                var cost:Double = 0.0
                var total_Amount:Double = 0.0
                price = Double(res?.cart_total ?? "") ?? 0
                print(price)
                self.mrpLabel.text = "$\(res?.cart_total ?? "")"
                
                self.discountLabel.text = "$\(res?.coupon_total ?? "")"//self.disount coupon_total
                //self.deliveryChargesLabel.text = res?
                //self.totalAmountLabel.text = self.checkTotal
                let gg = res?.shipping_total
                for i in 0..<gg!.count{
                    self.deliveryChargesLabel.text = gg?[i].text ?? ""
                    cost = Double(gg?[i].cost ?? "") ?? 0 //gg?[i].cost ?? ""
                }
                
                total_Amount = price  + cost
                self.totalAmountLabel.text = "$ \(total_Amount)"
               print("Value of cost:",total_Amount)
            }
           switch status {
            case 1:
                print("sucess")
            case 0:
                ApiService.shared.showAlert(title: "", msg: "Something Went Wrong " )
            default:
                ApiService.shared.showAlert(title: "", msg: "Something Went Wrong" )
            }
        }
    }
}
}
extension CheckOutViewController:STPAddCardViewControllerDelegate {
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        print("Payment Details",paymentMethod.billingDetails as Any)
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        // Dismiss add card view controller
        dismiss(animated: true)
    }
    
    private func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        dismiss(animated: true)
        
        print("Printing Strip response:\(token.allResponseFields)\n\n")
        print("Printing Strip Token:\(token.tokenId)")
    }
}
