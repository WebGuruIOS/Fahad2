//
//  SignUpViewController.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lblTxtFirstName: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var confirmPwTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
   
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    var mobile = String()
    var isCheck = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 20
        submitButton.layer.masksToBounds = true
        //mainview
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 40
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        mobileTF.text = mobile
       // mobileTF.isEnabled = false
        secondButton.setImage(UIImage(named: "private") , for: .normal)
        confirmPwTF.isSecureTextEntry = true
        firstButton.setImage(UIImage(named: "private") , for: .normal)
        passwordTF.isSecureTextEntry = true
        firstNameTF.placeholder = "First Name"
        lblTxtFirstName.placeholder = "First Name"
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func secondButtonAction(_ sender: UIButton) {
        self.isCheck = !self.isCheck
              if isCheck {
                secondButton.setImage(UIImage(named: "private") , for: .normal)
                confirmPwTF.isSecureTextEntry = true
              } else {
                secondButton.setImage(UIImage(named: "private1") , for: .normal)
                confirmPwTF.isSecureTextEntry = false
              }
    }
    @IBAction func firstButtonAction(_ sender: UIButton) {
        self.isCheck = !self.isCheck
              if isCheck {
                firstButton.setImage(UIImage(named: "private") , for: .normal)
                passwordTF.isSecureTextEntry = true
              } else {
                firstButton.setImage(UIImage(named: "private1") , for: .normal)
                passwordTF.isSecureTextEntry = false
              }
    }
    @IBAction func loginButtonAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitbuttonAction(_ sender: UIButton) {
       
        let validatemail = isvalidEmail(value: emailTF.text!)
        if firstNameTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message:"Please enter firstname".localiz())
        }
        else if lastNameTF.text?.count == 0 || lastNameTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message:"Please enter lastname".localiz())
        }else if lastNameTF.text?.count == 0 || lastNameTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please enter firstname".localiz())
        }else if emailTF.text?.count == 0 || emailTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please enter email".localiz())
        }else if validatemail == false{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please enter valid email".localiz())
        }else if mobileTF.text?.count == 0 || mobileTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please enter mobile number".localiz())
        }else if mobileTF.text!.count == 9{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Mobile number should be 10 digits!!".localiz())
        }else if passwordTF.text?.count == 0 || passwordTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please enter password".localiz())
        } else if confirmPwTF.text?.count == 0 || confirmPwTF.text!.isEmpty{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Please enter Confirm password".localiz())
        }else if passwordTF.text != confirmPwTF.text{
            SharedClass.sharedInstance.alert(view: self, title: "", message: "Does not match your password and confirm pasword".localiz())
        }else{
           signUpDataAction()
        }
    }
    func signUpDataAction(){
       
        let parameters:[String:Any] = ["firstname":firstNameTF.text ?? "","lastname":lastNameTF.text ?? "","email":emailTF.text ?? "","password":passwordTF.text ?? "","telephone":mobileTF.text ?? "","newsletter":"1"]
        SignUpDataResponce.AddUserData(api: "appapi/customer/add", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                   // self.defaults.set(true, forKey: "isStudentLoggdIn")
                    let logiVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                    self.navigationController?.pushViewController(logiVC, animated: true)
                    
                    SharedClass.sharedInstance.alert(view: self, title: "", message: "\(responseText)".localiz())
                case 0:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: "\(responseText)".localiz())
                default:
                    SharedClass.sharedInstance.alert(view: self, title: "", message: "Please Enter Valid Email Or Password".localiz())

                    
                }
            }
        }
    }
    func isvalidEmail(value: String) -> Bool {
        let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", email)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}
