//
//  UpdateProfileViewController.swift
//  Fahad
//
//  Created by Kondalu on 19/08/21.
//

import UIKit
import Alamofire

class UpdateProfileViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartMainView: UIView!{
        didSet{
            cartMainView.clipsToBounds = true
            cartMainView.layer.cornerRadius = cartMainView.frame.size.width / 2
            }
        }
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var save_Btn: UIButton!
    
    @IBOutlet weak var emailUpdateButton: UIButton!
    @IBOutlet weak var mobileUpdateButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var editButton: UIButton!
    let firstnameLine = CALayer()
    let secondnameLine = CALayer()
    let mobileLine = CALayer()
    let emailLine = CALayer()
    var firstName = String()
    var lastName = String()
    var mobile = String()
    var email = String()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var imagePick: ImagePicker!
    var str_profilePic:String = ""
    var userImage:UIImage?
    var mobileNum = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mainview
        mobileNumberTF.text = mobile
        emailTF.text = email
        firstNameTF.text = firstName
        lastNameTF.text = lastName
        mainview.clipsToBounds = true
        mainview.layer.cornerRadius = 40
        mainview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        //firstname
        firstnameLine.frame = CGRect(x: 0, y: firstNameTF.frame.height-2, width: firstNameTF.frame.width, height: 1)
        firstnameLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        firstNameTF.borderStyle = .none
        firstNameTF.layer.addSublayer(firstnameLine)
        //lastname
        secondnameLine.frame = CGRect(x: 0, y: lastNameTF.frame.height-2, width: lastNameTF.frame.width, height: 1)
        secondnameLine.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        lastNameTF.borderStyle = .none
        lastNameTF.layer.addSublayer(secondnameLine)
        //mobile
        mobileLine.frame = CGRect(x: 0, y: mobileNumberTF.frame.height-2, width: mobileNumberTF.frame.width, height: 1)
        mobileLine.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        mobileNumberTF.borderStyle = .none
        mobileNumberTF.layer.addSublayer(mobileLine)
        //lastname
        emailLine.frame = CGRect(x: 0, y: emailTF.frame.height-2, width: emailTF.frame.width, height: 1)
        emailLine.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        emailTF.borderStyle = .none
        emailTF.layer.addSublayer(emailLine)
        
        self.imagePick = ImagePicker(presentationController: self, delegate: self)
        
        self.profileImg.layer.cornerRadius = self.profileImg.layer.frame.height / 2
        self.editButton.layer.cornerRadius = self.editButton.layer.frame.height / 2
        self.save_Btn.layer.cornerRadius = self.save_Btn.layer.frame.height / 2
        
        DispatchQueue.main.async {
            if let imageUrl:URL = URL(string: "\(self.str_profilePic)"){
                self.profileImg.kf.setImage(with: imageUrl)
            }
        }
        
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func emailUpdateAction(_ sender: UIButton) {
        
    }
    @IBAction func mobileUpdateAction(_ sender: UIButton) {
        phoneNoUpdateApi()
//        if  mobileNumberTF.text == ""{
//            ApiService.shared.showAlert(title: "", msg: "Enter phone number" )
//        }else{
//            if mobileNumberTF.text != mobileNum {
//                mobileNumberTF.text = mobile
//                ApiService.shared.showAlert(title: "", msg: "Phone number already exists" )
//            }else{
//                phoneNoUpdateApi()
//
//            }
//        }
 
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editButtonAction(_ sender: UIButton) {
        self.imagePick.present(from: sender)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        UpdateProfileData()
        
       // self.navigationController?.popViewController(animated: true)
    }
    
    func UpdateProfileData(){
        let parameters:[String:Any] = ["customer_id":customerId,"firstname":"\(firstNameTF.text ?? "")","lastname":"\(lastNameTF.text ?? "")","profileImage":imagePick ?? ""]
        UpdateProfileDataResponce.AddUserData(api: "appapi/customer/editAccount", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                let text = data?.responseText
               switch status {
                case 1:
                    print("sucess")
//                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyprofileViewController") as? MyprofileViewController
//                   self.navigationController?.pushViewController(vc!, animated: true)
                   self.navigationController?.popViewController(animated: true)
                    ApiService.shared.showAlert(title: "", msg: "\(text ?? "")" )
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong " )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong" )
                }
            }
        }
    }
    
 /*   func forgetPasswordDataAction(){
       let parameters:[String:Any] = ["code":"+91","mobile_no":mobileNumberTF.text ?? ""]
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
                    logiVC.mobile = self.mobileNumberTF.text ?? ""
                  self.navigationController?.pushViewController(logiVC, animated: true)
                  ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Please Enter Valid Email Or Password" )
                }
            }
        }
    }
   */
    
    
    func phoneNoUpdateApi(){
        let parameters:[String:Any] = ["code":"+91","phone_no":mobileNumberTF.text ?? "","customer_id":customerId]
        PhoneDataResponse.AddUserData(api: "appapi/customer/change_phoneno", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                let responseText = data?.responseText ?? ""
                let mobileNum = data?.mobile ?? ""
                self.mobileNumberTF.text = data?.mobile
                print("statuse Is",responseCode ?? 0)
                switch responseCode {
                case 1:
                  ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                }
            }
        }
    }
   
    
    func multiFormImageUpload(imageFile:UIImage){
        ACProgressHUD.shared.showHUD()
        let parameters = ["customer_id": customerId] //Optional for extra parameter
        let baseURL1 = baseURL + "customer/profile_image" //appapi/customer/profile_image
        print("BaseUrl:",baseURL1)
        Alamofire.upload(multipartFormData: { multipartFormData in
            let imageData1 = imageFile.jpegData(compressionQuality: 0.75)
            multipartFormData.append(imageData1!, withName: "image",fileName: "file.jpg", mimeType: "image/jpg")
                for (key, value) in parameters {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    } //Optional for extra parameters
            },
        to:baseURL1,headers:nil){ (result) in
            switch result {
            case .success(let upload, _, _):

                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })

                upload.responseJSON { response in
                    ACProgressHUD.shared.hideHUD()
                    print(response.result.value ?? "")
                    ApiService.shared.showAlert(title: "", msg: "Image upload sucessfull" )
                }

            case .failure(let encodingError):
                print(encodingError)
                ACProgressHUD.shared.hideHUD()
            }
        }
    }
    
    func imageUpdate(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]){
        
        var selectedImage:UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            selectedImage = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            selectedImage = originalImage
        }
        
        if let selectedImages = selectedImage{
            self.userImage = selectedImages
            self.profileImg.image = userImage
            self.multiFormImageUpload(imageFile:selectedImages)
        }
    }
}
extension UpdateProfileViewController: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        self.profileImg.image = image
        guard let img = image else {
            return
        }
        self.multiFormImageUpload(imageFile:img)
    }
  }


