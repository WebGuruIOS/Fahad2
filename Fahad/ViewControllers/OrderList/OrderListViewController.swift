//
//  OrderListViewController.swift
//  Fahad
//
//  Created by Kondalu on 27/09/21.
//

import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var oederListTV: UITableView!
    var orderListArr = [OrderListResponseData]()
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? ""
    override func viewDidLoad() {
        super.viewDidLoad()
        oederListTV.delegate = self
        oederListTV.dataSource = self
        oederListTV.register(UINib(nibName: "OrderListTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderListTableViewCell")
      //  self.oederListTV.rowHeight  = UITableView.automaticDimension
      //  self.oederListTV.estimatedRowHeight = 80
        orderListData()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func orderListData(){
        let parameters:[String:Any] = ["customer":customerId]
        OrderListDataResponce1.AddUserData(api: "appapi/order/order_list", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode

                   if let data = data?.responseData{
                        for i in 0..<data.count{
                        self.orderListArr.append(data[i])
                            
                        }
                       print(self.orderListArr)
                    }
               switch status {
                case 1:
                    print("sucess")
                    if self.orderListArr.isEmpty == true{
                        ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                    }else{
                    DispatchQueue.main.async {
                    self.oederListTV.reloadData()
                    }
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(data?.responseText ?? "")" )
                }
            }
        }
    }
  

}
extension OrderListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderListArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oederListTV.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        cell.selectionStyle = .none
        cell.homeSetUP(orderListArr[indexPath.row])
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 121
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        secVC.orderId = orderListArr[indexPath.row].orderId ?? ""
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
}
