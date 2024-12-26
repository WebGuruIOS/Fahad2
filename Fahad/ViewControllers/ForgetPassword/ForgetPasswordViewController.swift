//
//  ForgetPasswordViewController.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var otpButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        otpButton.layer.cornerRadius = 25
        otpButton.layer.masksToBounds = true
        //mainview
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 40
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        //emailView
        emailView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        emailView.layer.borderWidth = 1.0
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.navigationBar.isHidden = true
    }
   
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func otpButtonAction(_ sender: UIButton) {
       forgetPasswordDataAction()
    }
    func forgetPasswordDataAction(){
       let parameters:[String:Any] = ["code":"+91","mobile_no":emailTF.text ?? ""]
        ForgetPasswordDataResponce.AddUserData(api: "appapi/home/login", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let code = data?.responseData ?? ""
                print("code",code)
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                  let logiVC = self.storyboard?.instantiateViewController(withIdentifier: "VerifyViewController") as! VerifyViewController
                    logiVC.mobile = self.emailTF.text ?? ""
                 //   ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                  self.navigationController?.pushViewController(logiVC, animated: true)
                 ApiService.shared.showAlert(title: "", msg: "otp is \(code) " )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)".localiz() )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password".localiz() )
                }
            }
        }
    }
}
