//
//  SelectLanguageViewController.swift
//  Fahad
//
//  Created by Kondalu on 31/08/21.
//

import UIKit
import LanguageManager_iOS
class SelectLanguageViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var languageTV: UITableView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartView: UIView!{
        didSet{
            cartView.clipsToBounds = true
            cartView.layer.cornerRadius = cartView.frame.size.width / 2
            }
        }
    var languageArr = ["English","Turkish","Arabic"]
    var languagelistArr = [LanguageResponseData]()
    var languageId = String()
    let customerId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var languageID = UserDefaults.standard.string(forKey: "languageId") ?? "1"
    override func viewDidLoad(){
        super.viewDidLoad()
        languageTV.delegate = self
        languageTV.dataSource = self
        languageTV.register(UINib(nibName: "SelectLanguageTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectLanguageTableViewCell")
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 40
        saveButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        languageId = UserDefaults.standard.string(forKey: "languageId") ?? ""
        print("languageId is",languageId)
       languagelistData()
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default//lightContent
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
}
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if languageId == "1" {
            LanguageManager.shared.setLanguage(language: .en)
                { _ in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                return storyboard.instantiateInitialViewController()!
            }animation: { (view) in
                view.transform = CGAffineTransform(scaleX: 2, y: 2)
                view.alpha = 0
            }
            }else if languageId == "2"{
                LanguageManager.shared.setLanguage(language: .tr)
                    { _ in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    return storyboard.instantiateInitialViewController()!
                }animation: { (view) in
                    view.transform = CGAffineTransform(scaleX: 2, y: 2)
                    view.alpha = 0
                }
            }else if languageId == "3" {
                LanguageManager.shared.setLanguage(language: .ar)
                    { _ in
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    return storyboard.instantiateInitialViewController()!
                }animation: { (view) in
                    view.transform = CGAffineTransform(scaleX: 2, y: 2)
                    view.alpha = 0
                }
            }
     }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func languagelistData(){
        let parameters:[String:Any] = ["customer_id":"\(customerId)","currency_code":"USD","language_id":"\(languageID)"]
        LanguageDataResponce.AddUserData(api: "appapi/home/language_list", parameters: parameters) { (data) in
            if data != nil{
                let status = data?.responseCode
                
               //Banner Slider
                if let data = data?.responseData{
                    for i in 0..<data.count{
                        DispatchQueue.main.async {
                            self.languagelistArr.append(data[i])
                        }
                    }
                }
               switch status {
                case 1:
                    print("sucess")
                    DispatchQueue.main.async {
                        self.languageTV.reloadData()
                    }
                case 201:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong " )
                default:
                    ApiService.shared.showAlert(title: "", msg: "Something Went Wrong" )
                }
            }
        }
    }
}
extension SelectLanguageViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languagelistArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = languageTV.dequeueReusableCell(withIdentifier: "SelectLanguageTableViewCell", for: indexPath) as! SelectLanguageTableViewCell
        cell.nameLabel.text = languagelistArr[indexPath.row].name ?? ""
        if languagelistArr[indexPath.row].id == languageId {
            cell.redButton.isHidden = false
            cell.redButton.isEnabled = false
        }else{
            cell.redButton.isHidden = true
            cell.selectButton.isEnabled = false
        }
      //  cell.redButton.isHidden = true
       
        
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let cell = languageTV.cellForRow(at: indexPath) as? SelectLanguageTableViewCell
        languageId = languagelistArr[indexPath.row].id ?? "1"
       UserDefaults.standard.set(languageId, forKey: "languageId")
        languageTV.reloadData()
       // if cell?.selectButton.isSelected == true{}
        cell?.redButton.isHidden = false
        
        print("Add",languageId)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        let cell = languageTV.cellForRow(at: indexPath) as? SelectLanguageTableViewCell
        if languagelistArr[indexPath.row].id == languageId {
            cell?.redButton.isHidden = true
        }else{
            cell?.redButton.isHidden = false
        }
      //  let languageId = languagelistArr[indexPath.row].id ?? ""
        UserDefaults.standard.removeObject(forKey: "languageId")
        print("Remove",languageId)
    }
    }
