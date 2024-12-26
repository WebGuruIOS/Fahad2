//
//  MyAddressViewController.swift
//  Fahad
//
//  Created by Kondalu on 19/08/21.
//

import UIKit

class MyAddressViewController: UIViewController {

    @IBOutlet weak var cartMainView: UIView!{
        didSet{
            cartMainView.clipsToBounds = true
            cartMainView.layer.cornerRadius = cartMainView.frame.size.width / 2
            }
        }
    @IBOutlet weak var cartimage: UIImageView!
    @IBOutlet weak var addressTV: UITableView!
    @IBOutlet weak var lbl_TitleName: UILabel!
    
    var str_pageHeader = String()
    
    var MyAdresslistArr = [MyAdressResponseData]()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var AddressIdArr = [String]()
    var hide = String()
    var check = String()
    var shippingname = String()
    var shippingCode = String()
    var Shippingrate = String()
    var Billingaddress = String()
    var disount = String()
    var checkTotal = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Trending Now
        addressTV.delegate = self
        addressTV.dataSource = self
        addressTV.register(UINib(nibName: "MyAddressTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAddressTableViewCell")
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartimage.isUserInteractionEnabled = true
        cartimage.addGestureRecognizer(cartTapGestureRecognizer)
       
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    override func viewWillAppear(_ animated: Bool) {
        MyAdresslistArr.removeAll()
        MyAdressData()
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
}
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAddressbuttonAction(_ sender: UIButton) {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
    }
    @IBAction func addNewAddressAction(_ sender: UIButton) {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
        updateProfileVC.str_HeaderName = "ADD DELIVERY ADDRESS"
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
    }
    func MyAdressData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)"]
        MyAdressDataResponce.AddUserData(api: "appapi/address/getAddress", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                
               //Banner Slider
                if let data = data?.responseData{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.MyAdresslistArr.append(data[i])
                        }
                        print("MyAdresslistArr",self.MyAdresslistArr)
                   }
                    for i in 0..<self.MyAdresslistArr.count{
                        self.AddressIdArr.append(data[i].addressId ?? "")
                        
                    }
                }
               switch status {
                case 1:
                    print("sucess")
//                    if self.MyAdresslistArr.isEmpty == true{
//                        ApiService.shared.showAlert(title: "", msg: "No Address Found" )
//                    }
                    DispatchQueue.main.async {
                        self.addressTV.reloadData()
                    
                    }
                case 0:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")
                    //ApiService.shared.showAlert(title: "", msg:  )
                default:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")
                    //ApiService.shared.showAlert(title: "", msg:  )
                }
            }
        }
    }
    @objc func editButtonAction(sender: UIButton) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewAddressViewController") as! AddNewAddressViewController
        secondVC.id = "1"
        secondVC.state = MyAdresslistArr[sender.tag].zone ?? ""
        secondVC.stateId = MyAdresslistArr[sender.tag].zoneId ?? ""
        secondVC.countryId = MyAdresslistArr[sender.tag].countryId ?? ""
        secondVC.addressId = MyAdresslistArr[sender.tag].addressId ?? ""
        secondVC.pincode = MyAdresslistArr[sender.tag].postcode ?? ""
        secondVC.phone = MyAdresslistArr[sender.tag].phone ?? ""
        secondVC.House = MyAdresslistArr[sender.tag].address1 ?? ""
        secondVC.Street = MyAdresslistArr[sender.tag].strAddress ?? ""
        secondVC.country = MyAdresslistArr[sender.tag].country ?? ""
        secondVC.firstName = MyAdresslistArr[sender.tag].firstname ?? ""
        secondVC.lastname = MyAdresslistArr[sender.tag].lastname ?? ""
        secondVC.city = MyAdresslistArr[sender.tag].city ?? ""
        secondVC.str_HeaderName = "EDIT ADDRESS"
        self.navigationController?.pushViewController(secondVC, animated: true)
        
    }
    
    func removeAddress(sender : UIButton){
        let parameters:[String:Any] = ["address_id":"\(MyAdresslistArr[sender.tag].addressId ?? "")","customer_id":"\(customerId)"]
        CountryDataResponce.AddUserData(api: "appapi/address/deleteAddress", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                    self.addressTV.reloadData()
                    }
                    SharedClass.sharedInstance.alert(view: self, title: "", message: "\(data?.responseText ?? "")")
                   //ApiService.shared.showAlert(title: "", msg:  )
                case 0:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")
                   // ApiService.shared.showAlert(title: "", msg:  )
                default:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "" )
                  //  ApiService.shared.showAlert(title: "", msg: )
                }
            }
        }
    }
    
    @objc func nHapusTap(sender: UIButton) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = addressTV.cellForRow(at: indexPath) as? MyAddressTableViewCell
        let hitPoint = sender.convert(CGPoint.zero, to: addressTV)
        if let indexPath = addressTV.indexPathForRow(at: hitPoint) {

            self.MyAdresslistArr.remove(at: indexPath.row)
            addressTV.beginUpdates()
            let alert = UIAlertController(title: "", message: "Do want to delete this address", preferredStyle: .alert)
                
                 let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.removeAddress(sender: (cell?.deleteButton)!)
                    self.addressTV.deleteRows(at: [indexPath], with: .automatic)
                    self.addressTV.endUpdates()
                    print("Prince12345")
                 })
                 alert.addAction(ok)
                 let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
                    print("Prince")
                 })
                 alert.addAction(cancel)
                 DispatchQueue.main.async(execute: {
                    self.present(alert, animated: true)
            })

        }
    }
}
extension MyAddressViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyAdresslistArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addressTV.dequeueReusableCell(withIdentifier: "MyAddressTableViewCell", for: indexPath) as! MyAddressTableViewCell
        cell.homeSetUP(MyAdresslistArr[indexPath.row])
        cell.selectionStyle = .none
        cell.deleteButton.tag = indexPath.row
        cell.editButton.tag = indexPath.row
        cell.selectionStyle = .none
        cell.deleteButton.addTarget(self, action: #selector(nHapusTap(sender:)), for: .touchUpInside)
        cell.editButton.addTarget(self, action: #selector(editButtonAction(sender:)), for: .touchUpInside)
        

//        if hide == "5"{
//            cell.deleteButton.isHidden = false
//            cell.editButton.isHidden = false
//        }else{
            if  MyAdresslistArr[indexPath.row].defaultAddress == 1{
                cell.deleteButton.isHidden = true
            }else{
            cell.deleteButton.isHidden = false
            cell.deleteButton.tintColor = UIColor.red
            cell.editButton.isHidden = false
            cell.editButton.tintColor = UIColor.green
            }
       // }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if check == "2"{
        let checkOutVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
           
        checkOutVC.label7 = MyAdresslistArr[indexPath.row].strAddress ?? ""
            checkOutVC.label8 = MyAdresslistArr[indexPath.row].city ?? ""
            checkOutVC.label9 = MyAdresslistArr[indexPath.row].address1 ?? ""
            checkOutVC.label10 = MyAdresslistArr[indexPath.row].address2 ?? ""
            checkOutVC.label11 = MyAdresslistArr[indexPath.row].postcode ?? ""
            checkOutVC.label12 = MyAdresslistArr[indexPath.row].phone ?? ""
            checkOutVC.addressId = MyAdresslistArr[indexPath.row].addressId ?? ""
            checkOutVC.shippingrate = Shippingrate
            checkOutVC.shippingName = shippingname
            checkOutVC.shippingCode = shippingCode
            let first = MyAdresslistArr[indexPath.row].firstname ?? ""
            let second = MyAdresslistArr[indexPath.row].lastname ?? ""
            let name = "\(first) "  + second
            checkOutVC.fullName = name
            checkOutVC.checkTotal = checkTotal
            checkOutVC.disount = disount
//            checkOutVC.firstname = AddressDetailsArr[indexPath.row].address_id ?? ""
//            checkOutVC.productID = productId
//            checkOutVC.productKey = productKey
//            checkOutVC.productQuantity = productQuantity
            
           // checkOutVC.mobile = mobile
        self.navigationController?.pushViewController(checkOutVC, animated: true)
        }else{
           
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
