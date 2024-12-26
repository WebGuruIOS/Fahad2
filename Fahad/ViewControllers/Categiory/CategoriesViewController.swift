//
//  CategoriesViewController.swift
//  Sumatra
//
//  Created by Kondalu on 05/06/21.
//

import UIKit

class CategoriesViewController: UIViewController,UITabBarControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.categoryViewModel2 = CategoryViewModel2()
    }
    var imgView = UIImageView()
    var categoryViewModel2:CategoryViewModel2!
    @IBOutlet weak var tableviewCategory: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var vw_backBgView: UIView!
    
    @IBOutlet weak var vw_TopView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cartView: UIView!{
        didSet{
            cartView.clipsToBounds = true
            cartView.layer.cornerRadius = cartView.frame.size.width / 2
            }
        }
    
    @IBOutlet weak var cartImg: UIImageView!
   
    let token = UserDefaults.standard.string(forKey: "AccessToken") ?? ""
    let userId = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var backId = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        cateData()
        if backId == "1"{
            logoImage.isHidden = true
            backButton.isHidden = false
            self.vw_TopView.backgroundColor = .red
            cartView.isHidden = true
           
            
        }else{
            
            logoImage.isHidden = false
            backButton.isHidden = true
            self.vw_backBgView.isHidden = true
        }
        tableviewCategory.register(UINib(nibName: "OthersTVCell", bundle: nil), forCellReuseIdentifier: "OthersTVCell")
        tableviewCategory.estimatedRowHeight = 100
        tableviewCategory.rowHeight = UITableView.automaticDimension
        tableviewCategory.separatorStyle = .none
        tableviewCategory.dataSource = self
        tableviewCategory.delegate = self
        
       let cartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gotoCartVC))
        cartImg.isUserInteractionEnabled = true
        cartImg.addGestureRecognizer(cartTapGestureRecognizer)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default//lightContent
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gotoCartVC(){
        if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
        let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
            updateProfileVC.hidesBottomBarWhenPushed = true
        }else{
            orderDetails()
        }
      }
    
    func orderDetails(){
        let alertController = UIAlertController(title: "For use this features you need an account".localiz(), message: "Do you want Login an account".localiz(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login" , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            print("KK123456")
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
           // self.present(updateProfileVC, animated: false, completion: nil)
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      // navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func cateData(){
        let parameters:[String:Any] = ["language_id":"1"]
        subCateDataResponce.AddUserData(api: "appapi/home/category_list", parameters: parameters) { (data) in
            if data != nil{
               if let data = data?.responseData{
                self.categoryViewModel2.categorylist = data
                self.tableviewCategory.reloadData()
                
             }
         }
      }
    }
    
    @objc private func sectionHeaderTapped(sender: UIButton) {
        UIView.animate(withDuration:0.1, animations: {
             self.imgView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
        if let _data = categoryViewModel2.categorylist[sender.tag].subCategory as [SubCategoryData]?{
            if _data.count != 0{
                let section = sender.tag
                if categoryViewModel2.array[section]{
                    categoryViewModel2.array[section] = false
                       }else{
                        categoryViewModel2.array[section] = true
                       }
                tableviewCategory.beginUpdates()
                tableviewCategory.reloadSections([section], with: .automatic)
                tableviewCategory.endUpdates()
               // reload table view or that particular section
                tableviewCategory.reloadData()
            }else{
               let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
                secVC.cateId = categoryViewModel2.categorylist[sender.tag].id
                secVC.extraParam = "appapi/product/category_wise_product"
                secVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(secVC, animated: true)
            }
        }
    }
}
   
extension CategoriesViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        if categoryViewModel2.categorylist.count != 0{
            for _ in 0...(categoryViewModel2.categorylist.count - 1){
                categoryViewModel2.array.append(true)
            }
        }
        
        return categoryViewModel2.categorylist.count
    }
    
func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
    imgView = UIImageView(frame: CGRect(x: tableView.frame.size.width-40, y: 10, width: 25, height: 15))
    imgView.image = UIImage(named: "upArrow")
     let label = UILabel(frame: CGRect(x: 10, y: 7, width: tableView.frame.size.width - 80, height: 20))
     label.font = label.font.withSize(16)
     label.textColor = .black
    label.text = categoryViewModel2.categorylist[section].title
     let button = UIButton(frame:CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
     button.tag = section
     button.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)
     view.addSubview(label)
     view.addSubview(button)
    view.addSubview(imgView)
    if categoryViewModel2.categorylist[section].subCategory.count == 0{
        imgView.isHidden = true
    }
   //  view.backgroundColor = MyHelper.hexStringToUIColor(hex: "#D9D9D9")
     return view
 }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoryViewModel2.array[section]{
            return 0
        }else{
            return categoryViewModel2.categorylist[section].subCategory.count
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OthersTVCell", for: indexPath) as! OthersTVCell
        cell.selectionStyle = .none
        if let _data = categoryViewModel2.categorylist[indexPath.section].subCategory[indexPath.item] as SubCategoryData?{
            cell.labelUnderline.text = _data.title
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _data = categoryViewModel2.categorylist[indexPath.section].subCategory[indexPath.item] as SubCategoryData?{
            let secVC = self.storyboard?.instantiateViewController(withIdentifier: "SortAndFilterViewController") as! SortAndFilterViewController
            //secVC.cateId = subCateId
            secVC.cateId = _data.id
            secVC.extraParam = "appapi/product/category_wise_product"
            secVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(secVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    }
}

   



