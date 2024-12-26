//
//  AddNewAddressViewController.swift
//  Fahad
//
//  Created by Kondalu on 19/08/21.
//

import UIKit

class AddNewAddressViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var lblTxtFirstName: UITextField!
    @IBOutlet weak var cartMainView: UIView!{
        didSet{
            cartMainView.clipsToBounds = true
            cartMainView.layer.cornerRadius = cartMainView.frame.size.width / 2
            }
    }
  
    @IBOutlet weak var btn_Country: UIButton!
    @IBOutlet weak var btn_State: UIButton!
    @IBOutlet weak var vw_CountryStateBgView: UIView!
    @IBOutlet weak var tbl_CountryStateTblView: UITableView!
    @IBOutlet weak var tbl_StateTableView: UITableView!
    
    @IBOutlet weak var lbl_HeaderName: UILabel!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var makeDefaultLabel: UILabel!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var stateTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var pincodeTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var houseNameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var saveView: UIView!
    var countryNameArr = [String]()
    var countryIdArr = [String]()
    var stateNameArr = [String]()
    var stateIdArr = [String]()
    //let dropDown = DropDown()
    var stateId = String()
    var countryId = String()
    var cityId = String()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? ""
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var addId = "0"
    var id = String()
    var firstName = String()
    var lastname = String()
    var phone = String()
    var House = String()
    var Street = String()
    var pincode = String()
    var city = String()
    var country = String()
    var state = String()
    var addressId = String()
    var stateId1 = String()
    var str_HeaderName = String()
    var commonArr = [[String:Any]]()
    var countyArr = [[String:Any]]()
    var stateArr = [[String:Any]]()
    var countryModelArr = [CountryResponseData]()
    var validStatus: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveView.clipsToBounds = true
        saveView.layer.cornerRadius = 30
        saveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
       
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        firstNameTF.placeholder = "First Name"
        lblTxtFirstName.placeholder = "First Name"
        
        countryTF.delegate = self
        stateTF.delegate = self
       // firstNameTF.delegate = self
       getCountryId()
        makeButton.isHidden = true
       // getStateId()
        if id == "1"{
            houseNameTF.text = House
            streetTF.text = Street
            cityTF.text = city
            stateTF.text = state
            pincodeTF.text = pincode
            phoneNumberTF.text = phone
           firstNameTF.text = firstName
            lastNameTF.text = lastname
            countryTF.text = country
        }else{
            print("kondalu")
        }
        self.setNeedsStatusBarAppearanceUpdate()
        self.lbl_HeaderName.text = str_HeaderName
        
        //self.vw_CountryStateBgView.isHidden = false
        //self.tbl_CountryStateTblView.isHidden = true
        //self.tbl_StateTableView.isHidden = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func act_Country(_ sender: Any) {
        self.vw_CountryStateBgView.isHidden = false
        self.tbl_CountryStateTblView.isHidden = false
        self.tbl_StateTableView.isHidden = true
        
    }
    
    @IBAction func act_State(_ sender: Any) {
        self.vw_CountryStateBgView.isHidden = false
        self.tbl_StateTableView.isHidden = false
        self.tbl_CountryStateTblView.isHidden = true
    }
    
    @IBAction func act_Cancle(_ sender: Any) {
        self.vw_CountryStateBgView.isHidden = true
    }
    
    @IBAction func whiteButtonAction(_ sender: UIButton) {
        addId = "1"
        whiteButton.isHidden = false
        whiteButton.isEnabled = false
        makeButton.isHidden = false
        print("addId",addId)
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
}
   
    @IBAction func makeButtonAction(_ sender: UIButton) {
        addId = "0"
        whiteButton.isHidden = false
        whiteButton.isEnabled = true
        makeButton.isHidden = true
        print("addId",addId)
    }
    @IBAction func backbuttonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        validStatus = true
        
        if id == "1"{
           updateAdressData()
        }else{
            
        if firstNameTF.text?.isEmpty == true {
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter Firstname" )
        }else if lastNameTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter Lastname" )
        }
        else if phoneNumberTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter PhoneNumber"  )
        }else if houseNameTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter house/appartment address" )
        }else if streetTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter Street Address" )
        }else if pincodeTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter Pincode number" )
        }
//        else if pincodeTF.text!.count == 5 {
//            validStatus = false
//            SharedClass.sharedInstance.alert(view: self, title: "", message: "Pincode must be 6 digits!!" )
//        }
        else if stateTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter state name" )
        }else if cityTF.text?.isEmpty == true{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter City name" )
        }
      }
        if isValidPhone(phone:self.phoneNumberTF.text!){
            
        }else{
            validStatus = false
            self.alertDisplay(titleMsg:"", displayMessage:"Enter valid mobile no.", buttonLabel:"Ok")
        }
        
        if isValidPincode(value: self.pincodeTF.text!){
            
        }else{
            validStatus = false
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Pincode must be 6 digits!!" )
        }
        
        if validStatus{
            addNewAdressData()
        }
        
    }
    func validate(value: String) -> Bool {
               let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
               let phoneNumberTF = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
               let result = phoneNumberTF.evaluate(with: value)
               return result
           }
    
    func addNewAdressData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)","firstname":"\(firstNameTF.text ?? "")","lastname":"\(lastNameTF.text ?? "")","company":"1","address_1":"\(houseNameTF.text ?? "")","address_2":"\(houseNameTF.text ?? "")","str_address":"\(streetTF.text ?? "")","city":"\(cityTF.text ?? "")","phone":"\(phoneNumberTF.text ?? "")","postcode":"\(pincodeTF.text ?? "")","country_id":"\(stateId1)","state_id":"\(cityId)","default_address":"\(addId)"]
        AddAddressDataResponce.AddUserData(api: "appapi/address/addressAdd", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
            switch status {
                case 1:
                    self.navigationController?.popViewController(animated: true)
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "" )
                case 201:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")
                default:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")
                }
            }
        }
    }
    func updateAdressData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)","firstname":"\(firstNameTF.text ?? "")","lastname":"\(lastNameTF.text ?? "")","company":"1","address_1":"\(houseNameTF.text ?? "")","address_2":"\(houseNameTF.text ?? "")","str_address":"\(streetTF.text ?? "")","city":"\(cityTF.text ?? "")","phone":"\(phoneNumberTF.text ?? "")","postcode":"\(pincodeTF.text ?? "")","country_id":"\(stateId)","state_id":"\(cityId)","default_address":"\(addId)","address_id":"\(addressId)"]
        VerifyOtpDataResponce.AddUserData(api: "appapi/address/addressUpdate", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
            switch status {
                case 1:
                    self.navigationController?.popViewController(animated: true)
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")

                   // ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                case 201:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")

                   // ApiService.shared.showAlert(title: "", msg:  )
                default:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "")
                }
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == countryTF {
            userStateButtonAction(countryTF)
           print("kondalu")
            return false //do not show keyboard nor cursor
        }else if textField == stateTF{
          //  userCityButtonAction(stateTF)
            return false
        }else{
            return true
        }
    }
    
    func getCountryId(){
        CountryDataResponce.AddUserData(api: "appapi/customer/countryList", parameters: [:]) { (data) in
            if data != nil{
                let status = data?.responseCode
                self.countryNameArr.removeAll()
                self.countryIdArr.removeAll()
               // CountryResponseData
                if let data = data?.responseData{
                    for i in 0..<data.count{
                        self.countryModelArr.append(data[i])
                        self.countryNameArr.append(data[i].name ?? "")
                      //  self.countryTF.text = self.countryNameArr[0]
                        self.countryIdArr.append(data[i].id ?? "")
                       // self.stateId1 = self.countryIdArr[0]
                    }
                }
                
                switch status {
                case 1:
                    print("vggjvj")
                    //self.getStateId()
                    self.tbl_CountryStateTblView.reloadData()
                case 0:
                    
                    ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                default:
                    ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                }
            }
        }
    }
    func getStateId(stateId:String){
        let parameters:[String:Any] = ["country_id":stateId]
        CountryDataResponce.AddUserData(api: "appapi/customer/stateList", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                self.stateIdArr.removeAll()
                self.stateNameArr.removeAll()
                self.countryModelArr.removeAll()
                if let data = data?.responseData{
                    for i in 0..<data.count{
                        self.countryModelArr.append(data[i])
                        self.stateIdArr.append(data[i].id ?? "")
                        self.stateNameArr.append(data[i].name ?? "")
                        self.stateTF.text = self.stateNameArr[0]
                    }
                }
                switch status {
                case 1:
                    print("Success")
                    
                    self.tbl_StateTableView.reloadData()
                  //  self.tbl_StateTableView.isHidden = false
                   // self.vw_CountryStateBgView.isHidden = false
                   
               // case 0:
                   // ApiService.shared.showAlert(title: "", msg: data?.responseText ?? "" )
                default:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: data?.responseText ?? "" )
                    
                }
            }
        }
    }
    
    func userStateButtonAction(_ sender: UITextField) {
      
    /*    dropDown.dataSource = countryNameArr
        dropDown.dataSource1 = countryIdArr
          dropDown.anchorView = sender  //5
           dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
           dropDown.show() //7
       dropDown.selectionAction = { [weak self] (index: Int, item: String, item1: String) in //8
             guard let _ = self else { return }
             self?.countryTF.text = item
             self?.stateId1 = item1
             self?.getStateId()
        print("id")
       }*/
    }
        
   /* func userCityButtonAction(_ sender: UITextField) {
           //countryIdArr.removeAll()
          // countryNameArr.removeAll()
           dropDown.dataSource = stateNameArr
           dropDown.dataSource1 = stateIdArr
           dropDown.anchorView = sender  //5
           dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height) //6
           dropDown.show() //7
           dropDown.selectionAction = { [weak self] (index: Int, item: String, item1: String) in //8
             guard let _ = self else { return }
             self?.stateTF.text = item
             self?.cityId = item1
            
       }
    }*/
 }

extension AddNewAddressViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        var numberOfItems = 1
        switch tableView {
        case tbl_CountryStateTblView:
            numberOfItems =  self.countryModelArr.count
        case tbl_StateTableView:
            numberOfItems = self.countryModelArr.count
        default:
            print("Somthing went wrong")
        }
        return numberOfItems
        
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch tableView {
        case tbl_CountryStateTblView:
            let cell1 = self.tbl_CountryStateTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CounteryCustCell
            let cntryModel = self.countryModelArr[indexPath.row]
            cell1.lbl_CountryState.text = cntryModel.name
           
            cell = cell1
        case tbl_StateTableView:
            
            let cell2 = self.tbl_StateTableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as! StateCustCell
            let dict = self.countryModelArr[indexPath.row]
            cell2.lbl_StateName.text = dict.name
            cell = cell2
            
        default:
            print("Somthing went wrong")
        }
        
        return cell
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tbl_CountryStateTblView{
            let cntryModel = self.countryModelArr[indexPath.row]
            let cntryId = cntryModel.id ?? ""
            self.countryTF.text = cntryModel.name
            stateId1 = cntryModel.id ?? ""
            print("CountryId:",stateId1)
            self.getStateId(stateId: cntryId)
            self.tbl_CountryStateTblView.isHidden = true
            self.vw_CountryStateBgView.isHidden = true
        }else if tableView == tbl_StateTableView{
            let dict = self.countryModelArr[indexPath.row]
            self.stateTF.text = dict.name
            cityId = dict.id ?? ""
            print("StateId:",cityId)
            self.tbl_StateTableView.isHidden = true
            self.vw_CountryStateBgView.isHidden = true
        }
        
    }
    
    
}

