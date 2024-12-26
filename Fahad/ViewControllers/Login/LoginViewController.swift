//
//  LoginViewController.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var visibleButton: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mainView1: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    var mobile = String()
    var email = String()
    var isCheck = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        //mainview
        mainView1.clipsToBounds = true
        mainView1.layer.cornerRadius = 40
        mainView1.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
       // emailTF.text = "9647226775"
      //  emailTF.text = "bbiswas6015@gmail.com"
       // passwordTF.text = "nopass"
        passwordTF.isSecureTextEntry = true
        visibleButton.setImage(UIImage(named: "private") , for: .normal)
        self.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    @IBAction func showHideButtonAction(_ sender: UIButton) {
        self.isCheck = !self.isCheck
              if isCheck {
                visibleButton.setImage(UIImage(named: "private") , for: .normal)
                passwordTF.isSecureTextEntry = true
              } else {
                visibleButton.setImage(UIImage(named: "private1") , for: .normal)
                passwordTF.isSecureTextEntry = false
              }
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default //lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        //self.navigationController?.isNavigationBarHidden = true
       // self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        let logiVC = self.storyboard?.instantiateViewController(withIdentifier: "menuBar") as! menuBar
        self.navigationController?.pushViewController(logiVC, animated: true)
     //   self.navigationController?.popViewController(animated: true)
    }
    func logInDataAction(){
        let validateMobile = isvalidMobile(value: emailTF.text!)
        let validatemail = isvalidEmail(value: emailTF.text!)
        if validateMobile == true{
           // mobile = emailTF.text ?? ""
            email = ""
        }else if validatemail == true{
            email = emailTF.text ?? ""
           // mobile = ""
        }else{
            email = ""
           // mobile = ""
        }
        let parameters:[String:Any] = ["email":"\(email)","password":passwordTF.text ?? "","phone":"\(mobile)","device_type":"I","device_token":"12345"]
        LoginDataResponce.AddUserData(api: "appapi/home/main_login", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let id = data?.responseData
                let customerId = id?.id
                UserDefaults.standard.set(customerId, forKey: "UserIdKey")
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                    UserDefaults.standard.set(true, forKey: "isStudentLoggdIn")
                    let logiVC = self.storyboard?.instantiateViewController(withIdentifier: "menuBar") as! menuBar
                    self.navigationController?.pushViewController(logiVC, animated: true)
                    let responseText = data?.responseText ?? ""
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)".localiz() )
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password".localiz() )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password".localiz() )
                }
            }
        }
    }
    @IBAction func signUpButtonAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
       logInDataAction()
    }
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        let secVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        self.navigationController?.pushViewController(secVC, animated: true)
    }
    func isvalidMobile(value: String) -> Bool{
        let mobile = "^[123456789][0-9]{9}?"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", mobile)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    func isvalidEmail(value: String) -> Bool{
        let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", email)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
}
