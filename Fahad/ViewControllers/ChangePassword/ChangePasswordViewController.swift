//
//  ChangePasswordViewController.swift
//  Fahad
//
//  Created by Kondalu on 29/09/21.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    
    @IBOutlet weak var btn_OldPsdEyebtn: UIButton!
    @IBOutlet weak var btn_NewPsdEyeBtn: UIButton!
    @IBOutlet weak var btn_RetypePsdEyeBtn: UIButton!
    
    
    @IBOutlet weak var vw_OldPsdBgView: UIView!
    @IBOutlet weak var vw_NewPsdBgView: UIView!
    @IBOutlet weak var vw_ReTypeBgView: UIView!
    @IBOutlet weak var btn_Save: UIButton!
    
    @IBOutlet weak var reTypeNewPWTF: UITextField!
    @IBOutlet weak var newPWTF: UITextField!
    @IBOutlet weak var oldPWTF: UITextField!
    @IBOutlet weak var changView: UIView!
    static func instantiate() -> ChangePasswordViewController? {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(ChangePasswordViewController.self)") as? ChangePasswordViewController
        }
    var responseText = String()
    
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? "0"
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vw_OldPsdBgView.layer.cornerRadius = self.vw_OldPsdBgView.layer.frame.height / 2
        self.vw_OldPsdBgView.layer.borderWidth = 1.0
        self.vw_OldPsdBgView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.vw_NewPsdBgView.layer.cornerRadius = self.vw_NewPsdBgView.layer.frame.height / 2
        self.vw_NewPsdBgView.layer.borderWidth = 1.0
        self.vw_NewPsdBgView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.vw_ReTypeBgView.layer.cornerRadius = self.vw_ReTypeBgView.layer.frame.height / 2
        self.vw_ReTypeBgView.layer.borderWidth = 1.0
        self.vw_ReTypeBgView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.changView.layer.cornerRadius = 15.0

        self.btn_Save.layer.cornerRadius = self.btn_Save.layer.frame.height / 2
        
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        if oldPWTF.text == ""{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Old Password Required!!")
        }
        
        if newPWTF.text == ""{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "New Password Required!!")
        }else if newPWTF.text!.count < 5 {
            SharedClass.sharedInstance.alert(view: self, title: "", message: "New password must be 6 digits!!")
        }
        
        if reTypeNewPWTF.text == ""{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Confirm Password Required!!")
        } else if newPWTF.text!.count < 5{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Confirm password must be 6 digits!!")
            
        }
        
        if isPasswordSame(password:newPWTF.text!, confirmPassword:reTypeNewPWTF.text!){

        }else{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Password & Confirm password not matched!!")
            
            
        }
        
        changePWDataAction()
        
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func act_OldPsdEye(_ sender: Any) {
        if(iconClick == true) {
            oldPWTF.isSecureTextEntry = false
        } else {
            oldPWTF.isSecureTextEntry = true
        }
        iconClick = !iconClick
        
    }
    
    @IBAction func act_NewPsdEye(_ sender: Any) {
        if(iconClick == true) {
            newPWTF.isSecureTextEntry = false
        } else {
            newPWTF.isSecureTextEntry = true
        }

        iconClick = !iconClick
    }
    @IBAction func act_RetypePsdEye(_ sender: Any) {
        if(iconClick == true) {
            reTypeNewPWTF.isSecureTextEntry = false
        } else {
            reTypeNewPWTF.isSecureTextEntry = true
        }

        iconClick = !iconClick
    }
    
    
    /*
      Password Validation : Check current and Confirm is Same.
     */
    func isPasswordSame(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
          return true
        }else{
          return false
        }
    }
    
    func changePWDataAction(){
       
        let parameters:[String:Any] = ["customer_id":"\(customerId)","old":"\(oldPWTF.text ?? "")","new":"\(newPWTF.text ?? "")"]
        ChangePasswordDataResponce.AddUserData(api: "appapi/customer/change_password", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                self.responseText = data?.responseText ?? ""
                switch responseCode {
                case 1:
                    self.orderDetails()
                case 0:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: "Password does not match with your account")
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(self.responseText)" )
                }
            }
        }
    }
    func orderDetails(){
        let alertController = UIAlertController(title: "", message: "\(self.responseText)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK" , style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
//            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! prof
//            updateProfileVC.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(updateProfileVC, animated: true)
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
}
