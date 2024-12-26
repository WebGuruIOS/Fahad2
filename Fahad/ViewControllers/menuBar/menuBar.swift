//
//  menuBar.swift
//  Fahad
//
//  Created by Kondalu on 24/08/21.
//

import UIKit

class menuBar: UITabBarController,UITabBarControllerDelegate {
    
  
    let tabbarVC = UITabBarController()
    override func viewDidLoad() {
           super.viewDidLoad()
           self.delegate = self
      
//        let tabbarVC = UITabBarController()
//        let vc1 = HomeViewController()
//        let tabTwoBarItem1 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "caS"))
//        vc1.tabBarItem = tabTwoBarItem1
//        let vc2 = CategoriesViewController()
//        let vc3 = WishlistViewController()
//        let vc4 = MyprofileViewController()
//        let vc5 = MoreViewController()
//        tabbarVC.modalPresentationStyle = .fullScreen
//        tabbarVC.setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: false)
        
        
//        present(tabbarVC, animated: true, completion: nil)
        
      }

//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//            let tabBarIndex = tabBarController.selectedIndex
//            if tabBarIndex == 2 {
//                if UserDefaults.standard.string(forKey: "isStudentLoggdIn") != nil {
//                    print("Komdalu")
//                }else{
//                    orderDetails()
//                }
//            }
//       }
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//
//            let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
//        if selectedIndex == 2 && UserDefaults.standard.string(forKey: "isStudentLoggdIn") == nil {
//            orderDetails()
//        }else{
//           // orderDetails()
//        }
//        }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!

            if selectedIndex == 2 && UserDefaults.standard.string(forKey: "isStudentLoggdIn") == nil {
               orderDetails1()
                return false
            }else if selectedIndex == 3 && UserDefaults.standard.string(forKey: "isStudentLoggdIn") == nil {
                orderDetails1()
                return false
            }
            return true
        }
    
    
    func orderDetails1(){
        let alertController = UIAlertController(title: "For use this features you need an account".localiz(), message: "Do you want Login an account".localiz(), preferredStyle: .alert)
        let ok = UIAlertAction(title: "Login".localiz() , style: .default) { (_ action) in
            let updateProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            updateProfileVC.hidesBottomBarWhenPushed = true
            let navVC = UINavigationController(rootViewController: updateProfileVC)
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true, completion: nil)
            self.navigationController?.pushViewController(updateProfileVC, animated: true)
            
//            let rootVC = LoginViewController()
//            let navVC = UINavigationController(rootViewController: rootVC)
//                self.present(navVC, animated: true, completion: nil)
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
