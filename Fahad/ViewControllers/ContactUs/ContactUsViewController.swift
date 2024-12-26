//
//  ContactUsViewController.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartView: UIView!{
        didSet{
            cartView.clipsToBounds = true
            cartView.layer.cornerRadius = cartView.frame.size.width / 2
            }
        }
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var messageTF: UITextField!
    @IBOutlet weak var subjectTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var firstNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        saveView.clipsToBounds = true
        saveView.layer.cornerRadius = 30
        saveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        firstNameTF.setPlaceholder = "Name"
//        lastNameTF.setPlaceholder = "LastName"
//        mobileTF.setPlaceholder = "MobileNumber"
//        emailTF.setPlaceholder = "Email"
//        subjectTF.setPlaceholder = "Subject"
//        messageTF.setPlaceholder = "Message"
        let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImage.isUserInteractionEnabled = true
        cartImage.addGestureRecognizer(cartTapGestureRecognizer)
       
    }
    @objc func gotoCartVC(){
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
       self.navigationController?.pushViewController(updateProfileVC, animated: true)
}
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
    }
}
