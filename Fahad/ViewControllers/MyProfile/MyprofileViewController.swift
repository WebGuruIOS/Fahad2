//
//  MyprofileViewController.swift
//  Fahad
//
//  Created by Kondalu on 18/08/21.
//

import UIKit
import EzPopup
import LanguageManager_iOS
class MyprofileViewController: UIViewController {

    @IBOutlet weak var cartmainView: UIView!{
        didSet{
            cartmainView.clipsToBounds = true
            cartmainView.layer.cornerRadius = cartmainView.frame.size.width / 2
            }
        }
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var profileTV: UITableView!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var mainview: UIView!{
        didSet{
            mainview.clipsToBounds = true
            mainview.layer.cornerRadius = 40
            mainview.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    let customAlertVC = ChangePasswordViewController.instantiate()
    var nameArr = ["My Orders".localiz(),"My Address".localiz(),"Privacy".localiz(),"Logout".localiz()]
    var subNameArr = ["View AllOrders".localiz(),"Add And Update Address".localiz(),"ChangePassword".localiz(),""]
    var getStudentDataArr : MyAccountResponseData?
    var firstName = String()
    var lastName = String()
    var mobile = String()
    var email = String()
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var profilePic = String()
    
    
    /*
     languageId = languagelistArr[indexPath.row].id ?? "1"
    UserDefaults.standard.set(languageId, forKey: "languageId")
     */
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //Trending Now
       
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        profileTV.delegate = self
        profileTV.dataSource = self
        profileTV.register(UINib(nibName: "MyProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "MyProfileTableViewCell")
      
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        }else{
            orderDetails()
        }
        self.profileimg.layer.cornerRadius = self.profileimg.layer.frame.height / 2
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
    func orderDetails(){
        let alertController = UIAlertController(title: "For use this features you need an account", message: "Do you want Login an account".localiz(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel".localiz() , style: .default) { (_ action) in
//            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//           self.navigationController?.pushViewController(updateProfileVC, animated: true)
            self.dismiss(animated: true, completion: nil)
            
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
}
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileViewController") as! UpdateProfileViewController
        updateProfileVC.firstName = firstName
        updateProfileVC.lastName = lastName
        updateProfileVC.mobile = mobile
        updateProfileVC.email = email
        updateProfileVC.str_profilePic =  self.profilePic
       // updateProfileVC.imagePick = profilePic
        
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        MyProfileData()
        }else{
        orderDetails()
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
       // self.navigationController?.navigationBar.isHidden = true
    }
    func MyProfileData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)"]
        MyAccountDataResponce.AddUserData(api: "appapi/customer/myAccount", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                if let data = data?.responseData{
                    self.getStudentDataArr = data
                    self.firstName = self.getStudentDataArr?.firstName ?? ""
                    self.lastName = self.getStudentDataArr?.lastName ?? ""
                    var name = ("\(self.firstName) "  +  self.lastName)
                    UserDefaults.standard.set(name, forKey: "name")
                    print(name)
                    
                    self.namelabel.text = name
                    self.emailLabel.text = self.getStudentDataArr?.email ?? ""
                    self.mobileLabel.text = self.getStudentDataArr?.telephone ?? ""
                    self.email = self.getStudentDataArr?.email ?? ""
                    self.mobile = self.getStudentDataArr?.telephone ?? ""
                    self.profilePic = self.getStudentDataArr?.profileImage ?? ""
                    DispatchQueue.main.async {
                        if let imageUrl:URL = URL(string: "\(self.profilePic)"){
                            self.profileimg.kf.setImage(with: imageUrl)
                        }
                    }
                   
                    
                    /*
                     let data1 = self.elcctronicArr[i].image ?? ""
                     DispatchQueue.main.async {
                          if let imageUrl:URL = URL(string:"\(data1)") {
                              self.img5.kf.setImage(with: imageUrl)
                     */
                }
               switch status {
                case 1:
                    print("sucess")
                   
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong ".localiz() )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong" )
                }
            }
        }
    }
}
extension MyprofileViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTV.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell", for: indexPath) as! MyProfileTableViewCell
        cell.selectionStyle = .none
        cell.nameLabel.text = nameArr[indexPath.row]
        cell.subnameLabel.text = subNameArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
//            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
//                updateProfileVC.hidesBottomBarWhenPushed = true
//           self.navigationController?.pushViewController(updateProfileVC, animated: true)
            myAddressDetailscheck()
        }else if indexPath.row == 3{
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "menuBar") as! menuBar
           updateProfileVC.hidesBottomBarWhenPushed = true
          UserDefaults.standard.set(false, forKey: "isStudentLoggdIn")
          UserDefaults.standard.removeObject(forKey: "isStudentLoggdIn")
          self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }else if indexPath.row == 0{
//            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderListViewController") as! OrderListViewController
//                updateProfileVC.hidesBottomBarWhenPushed = true
//           self.navigationController?.pushViewController(updateProfileVC, animated: true)
            OrderDetailscheck()
        }else if indexPath.row == 2{
                guard let customAlertVC = customAlertVC else { return }
                let popupVC = PopupViewController(contentController: customAlertVC, popupWidth: 400, popupHeight: 600)
                       popupVC.cornerRadius = 15
                       popupVC.delegate = self
               // customAlertVC.feedbackID = id
                present(popupVC, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func orderDetails1(){
        let alertController = UIAlertController(title: "For use this features you need an account".localiz(), message: "Do you want Login an account".localiz(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel" , style: .default) { (_ action) in
            self.dismiss(animated: true, completion: nil)
        }
        ok.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alertController.addAction(ok)
        alertController.addAction(cancel)
        alertController.view.tintColor = .yellow
        self.present(alertController, animated: true, completion: nil)
    }
    func OrderDetailscheck(){
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderListViewController") as! OrderListViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }else{
            orderDetails1()
        }
    }
    func myAddressDetailscheck(){
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyAddressViewController") as! MyAddressViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }else{
            orderDetails1()
        }
    }

}
extension MyprofileViewController: PopupViewControllerDelegate {
    func popupViewControllerDidDismissByTapGesture(_ sender: PopupViewController) {
        print("log - popupViewControllerDidDismissByTapGesture")
    }
}

