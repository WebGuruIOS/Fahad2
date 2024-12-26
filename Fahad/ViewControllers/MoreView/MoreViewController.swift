//
//  MoreViewController.swift
//  Fahad
//
//  Created by Kondalu on 23/08/21.
//  webView

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var viewMoreTV: UITableView!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartManiView: UIView!{
        didSet{
            cartManiView.clipsToBounds = true
            cartManiView.layer.cornerRadius = cartManiView.frame.size.width / 2
            }
        }
    var nameArr = ["Order Details".localiz(),"Change Language".localiz(),"About Us".localiz(),"Delivery Information".localiz(),"Privacy Policy".localiz(),"Terms And Conditions".localiz(),"Product Display Policy".localiz(),"Contact Us".localiz()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewMoreTV.delegate = self
        viewMoreTV.dataSource = self
        viewMoreTV.register(UINib(nibName: "ViewMoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewMoreTableViewCell")
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default //lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @objc func gotoCartVC(){
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
            updateProfileVC.hidesBottomBarWhenPushed = true
        }else{
            orderDetails1()
        }
      }
   
    override func viewWillDisappear(_ animated: Bool) {
      //  self.navigationController?.navigationBar.isHidden = true
    }
   
}
extension MoreViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewMoreTV.dequeueReusableCell(withIdentifier: "ViewMoreTableViewCell", for: indexPath) as! ViewMoreTableViewCell
        cell.nameLabel.text = nameArr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
//            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "OrderListViewController") as! OrderListViewController
//            secVC.hidesBottomBarWhenPushed = true
            //secVC.str_PageHeader = "ORDER LIST"
//            self.navigationController?.pushViewController(secVC, animated: true)
            OrderDetailscheck()
            
        }else if indexPath.row == 1{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectLanguageViewController") as! SelectLanguageViewController
            secVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if indexPath.row == 2{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            secVC.pageId = "4"
            secVC.hidesBottomBarWhenPushed = true
            secVC.str_PageHeader = "ABOUT US"
            self.navigationController?.pushViewController(secVC, animated: true)
            
        }else if indexPath.row == 3{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            secVC.pageId = "6"
            secVC.hidesBottomBarWhenPushed = true
            secVC.str_PageHeader = "DELIVERY INFORMATION"
            self.navigationController?.pushViewController(secVC, animated: true)
            
        }else if indexPath.row == 4{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            secVC.pageId = "3"
            secVC.hidesBottomBarWhenPushed = true
            secVC.str_PageHeader = "PRIVACY POLICY".localiz()
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if indexPath.row == 5{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            secVC.pageId = "5"
            secVC.hidesBottomBarWhenPushed = true
            secVC.str_PageHeader = "TERM AND CONDITIONS".localiz()
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if indexPath.row == 6{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            secVC.pageId = "10"
            secVC.hidesBottomBarWhenPushed = true
            secVC.str_PageHeader = "PRODUCT DISPLAY POLICY".localiz()
            self.navigationController?.pushViewController(secVC, animated: true)
        }else if indexPath.row == 7{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as! AboutUsViewController
            secVC.pageId = "0"
            secVC.hidesBottomBarWhenPushed = true
            secVC.str_PageHeader = "CONTACT US".localiz()
            self.navigationController?.pushViewController(secVC, animated: true)
        }
    }
    func orderDetails1(){
        let alertController = UIAlertController(title: "For use this features you need an account".localiz(), message: "Do you want Login an account".localiz(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login".localiz() , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel".localiz() , style: .default) { (_ action) in
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
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "AddAddressViewController") as! MyAddressViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
        }else{
            orderDetails1()
        }
    }
}
