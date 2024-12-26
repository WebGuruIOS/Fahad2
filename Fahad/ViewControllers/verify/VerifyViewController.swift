//
//  VerifyViewController.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class VerifyViewController: UIViewController,UITextFieldDelegate {

   
    @IBOutlet weak var secondView4: UIView!{
        didSet{
            secondView4.layer.cornerRadius = 7
            secondView4.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var secondView3: UIView!{
        didSet{
            secondView3.layer.cornerRadius = 4
            secondView3.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var firstView4: UIView!{
        didSet{
            firstView4.layer.cornerRadius = 4
            firstView4.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var firstView3: UIView!{
        didSet{
            firstView3.layer.cornerRadius = 4
            firstView3.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var secondView2: UITextField!{
        didSet{
            secondView2.layer.cornerRadius = 4
            secondView2.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var firstView2: UIView!{
        didSet{
            firstView2.layer.cornerRadius = 4
            firstView2.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var secondView1: UIView!{
        didSet{
            secondView1.layer.cornerRadius = 4
            secondView1.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var firstView1: UIView!{
        didSet{
            firstView1.layer.cornerRadius = 4
            firstView1.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    var Otp = String()
    var mobile = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        numberLabel.text = "Please Enter the 4 digit code to \(mobile)"
        verifyButton.layer.cornerRadius = 20
        verifyButton.layer.masksToBounds = true
        //mainview
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 40
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        firstTF.delegate = self
        secondTF.delegate = self
        thirdTF.delegate = self
        fourthTF.delegate = self
        
//        firstTF.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControl.Event.editingChanged)
//
//        secondTF.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControl.Event.editingChanged)
//        thirdTF.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControl.Event.editingChanged)
//        fourthTF.addTarget(self, action: Selector(("textFieldDidChange:")), for: UIControl.Event.editingChanged)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
//    func textFieldDidChange(textField: UITextField){
//          let text = textField.text
//         if text?.utf16.count ?? 0 >= 1{
//            switch textField{
//            case firstTF:
//                secondTF.becomeFirstResponder()
//            case secondTF:
//                thirdTF.becomeFirstResponder()
//            case thirdTF:
//                fourthTF.becomeFirstResponder()
//            case fourthTF:
//                fourthTF.resignFirstResponder()
//            default:
//                break
//            }
//         }else{
//       }
//    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func resendCodeButtonAction(_ sender: UIButton) {
        forgetPasswordDataAction()
    }
    @IBAction func verifyButtonAction(_ sender: UIButton) {
       VerifyOtpDataAction()
    }
//    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == firstTF{
//        return firstTF.text?.count ?? 0 < 1
//        }else if textField == secondTF{
//            return secondTF.text?.count ?? 0 < 1
//        }else if textField == thirdTF{
//            return thirdTF.text?.count ?? 0 < 1
//        }else{
//            return fourthTF.text?.count ?? 0 < 1
//        }
//    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstTF{
        let maxLength = 1
        let currentString: NSString = (firstTF.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
        }else if textField == secondTF{
            let maxLength = 1
            let currentString: NSString = (secondTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else if textField == thirdTF{
            let maxLength = 1
            let currentString: NSString = (thirdTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }else{
            let maxLength = 1
            let currentString: NSString = (fourthTF.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
       
    }
    func VerifyOtpDataAction(){
        Otp = "\(firstTF.text ?? "")\(secondTF.text ?? "")\(thirdTF.text ?? "")\(fourthTF.text ?? "")"
       let parameters:[String:Any] = ["phone":mobile,"otp":Otp]
        VerifyOtpDataResponce.AddUserData(api: "appapi/home/otp_verify", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData ?? ""
                print("code",code)
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                  let logiVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                    logiVC.mobile = self.mobile
                  self.navigationController?.pushViewController(logiVC, animated: true)
               //   ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
    func forgetPasswordDataAction(){
       let parameters:[String:Any] = ["code":"+91","mobile_no":mobile]
        ForgetPasswordDataResponce.AddUserData(api: "appapi/home/login", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData ?? ""
                print("code",code)
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                  ApiService.shared.showAlert(title: "", msg: "otp is \(code) " )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.text = ""
//    }

}

