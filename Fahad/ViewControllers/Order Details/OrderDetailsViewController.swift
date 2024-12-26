//
//  OrderDetailsViewController.swift
//  Fahad
// Prince
//  Created by Kondalu on 30/08/21.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var paymentTypeLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalMrpLabel: UILabel!
    @IBOutlet weak var label26: UILabel!
    @IBOutlet weak var label25: UILabel!
    @IBOutlet weak var label24: UILabel!
    @IBOutlet weak var label23: UILabel!
    @IBOutlet weak var label22: UILabel!
    @IBOutlet weak var label21: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var orderDetailsTV: UITableView!
    var orderPaymentAddressArr : OrderDetailsResponseData?
    var orderDetailsOptions = [Product]()
    var prdArr = [PrdOption]()
    var orderQuantityArr = [String]()
    var orderId = String()
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        orderDetailsTV.delegate = self
        orderDetailsTV.dataSource = self
        orderDetailsData()
        self.orderDetailsTV.rowHeight  = UITableView.automaticDimension
        self.orderDetailsTV.estimatedRowHeight = 80
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        self.orderDetailsTV.layoutSubviews()
    }
    @IBAction func reOrderButtonAction(_ sender: UIButton) {
        reOrderAction()
    }
    @IBAction func cancelOrderButtonAction(_ sender: UIButton) {
        cancelOrderAction()
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func orderDetailsData(){
        let parameters:[String:Any] = ["order_no":"\(orderId)","language_id":"\(languageID)"]
        OrderDetailsDataResponce.AddUserData(api: "appapi/order/order_details", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode

                if let data1 = data?.responseData{
                   // for i in 0..<data1.count{
                    self.orderPaymentAddressArr = data1
                    let hg = self.orderPaymentAddressArr?.product
                    for i in 0..<hg!.count{
                        self.orderDetailsOptions.append((hg?[i])!)
                        print("orderDetailsOptions234",self.orderDetailsOptions)
                        let attribute = self.orderDetailsOptions[i].prdOption
                        for i in 0..<attribute!.count{
                            self.prdArr.append((attribute?[i])!)
                        }
                        print("attribute123",attribute ?? [])
                        let gg = self.orderDetailsOptions[i].quantity
                        for _ in 0..<gg!.count{
                             self.orderQuantityArr.append(gg!)
                            print("q11111",self.orderQuantityArr)
                            
                        }
                    }
                    self.totalAmountLabel.text = self.orderPaymentAddressArr?.finalTotal ?? ""
                    self.totalMrpLabel.text = self.orderPaymentAddressArr?.subTotal ?? ""
                    self.discountLabel.text = self.orderPaymentAddressArr?.taxAmount ?? ""
                    self.deliveryChargesLabel.text = self.orderPaymentAddressArr?.couponTotal ?? ""
                    self.label11.text = self.orderPaymentAddressArr?.statusName ?? ""
                    self.paymentTypeLabel.text = self.orderPaymentAddressArr?.paymentMethod ?? ""
                    //PaymentAddress
                   // let paymentAddress = self.orderPaymentAddressArr?.paymentAddress
                    
                    
                    //ShippingAddress
                    let shippingAddress = self.orderPaymentAddressArr?.shippingAddress
                    self.label21.text = shippingAddress?.address1 ?? ""
                    self.label22.text = shippingAddress?.address2 ?? ""
                    self.label23.text = shippingAddress?.address ?? ""
                    self.label24.text = shippingAddress?.city ?? ""
                    self.label25.text = shippingAddress?.country ?? ""
                    self.label26.text = shippingAddress?.postCode ?? ""
                    let first = shippingAddress?.firstName ?? ""
                    let second = shippingAddress?.lastName ?? ""
                    self.nameLabel.text = first + second
               // }
                switch status {
                case 1:
                   
                    print("sucess")
                    DispatchQueue.main.async {
                        if self.orderQuantityArr.isEmpty == true{
                            ApiService.shared.showAlert(title: "", msg: "No orders Found" )
                        }else{
                            self.orderDetailsTV.reloadData()
                        }
                }
                case 201:
                    ApiService.shared.showAlert(title: "WARNING", msg: "Something Went Wrong " )
                default:
                    ApiService.shared.showAlert(title: "WARNING", msg: "Something Went Wrong" )
                }
            }
        }
    }
    }
    func cancelOrderAction(){
       
       let parameters:[String:Any] = ["order_id":"\(orderId)","customer_id":"\(customerId)"]
        OrderCancelDataResponce.AddUserData(api: "appapi/order/cancel_order", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
               
                switch responseCode {
                case 1:
                self.navigationController?.popViewController(animated: true)
                ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                }
            }
        }
    }
    func reOrderAction(){
       
       let parameters:[String:Any] = ["order_id":"\(orderId)","customer":"\(customerId)"]
        OrderCancelDataResponce.AddUserData(api: "appapi/order/re_order", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
               
                switch responseCode {
                case 1:
//                    let secVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
//                    self.navigationController?.pushViewController(secVC, animated: true)
                  ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                }
            }
        }
    }

}
extension OrderDetailsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("orderDetailsOptions123",orderQuantityArr.count)
        return orderQuantityArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderDetailsTV.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell", for: indexPath) as! OrderDetailsTableViewCell
        cell.homeSetUP(orderDetailsOptions[indexPath.row])
        cell.obejectArr = orderDetailsOptions[indexPath.row].prdOption ?? []
       cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if prdArr.count == 0{
            return 180
        }else{
            return 205
        }
       
    }
    
    
}

