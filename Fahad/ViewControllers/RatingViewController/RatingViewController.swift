//
//  RatingViewController.swift
//  Fahad
//
//  Created by Prince on 15/03/22.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {

    @IBOutlet weak var ratingVW: CosmosView!
    
    @IBOutlet weak var vw_TextBgView: UIView!
    @IBOutlet weak var vw_SubmitBgView: UIView!
    @IBOutlet weak var txt_EnterYourReview: UITextField!
    var customer_Id = UserDefaults.standard.string(forKey: "UserIdKey") ?? ""
    var custmorName = UserDefaults.standard.string(forKey: "name") ?? ""
    //UserDefaults.standard.set(<#Any?#>, forKey: "name")
    var prodId = String()
    var ratinValue:Int = 0
    var ratingSubmitStatus:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // self.ratingVW.rating = Double(5.0)
        self.vw_TextBgView.layer.borderWidth = 1.0
        self.vw_TextBgView.layer.cornerRadius = 10.0
        self.vw_TextBgView.layer.borderColor = UIColor.gray.cgColor
        
        self.vw_SubmitBgView.layer.cornerRadius = self.vw_SubmitBgView.frame.size.height / 2
        
        ratingVW.didFinishTouchingCosmos = { rating in
            
            self.ratinValue = Int(rating)
        }

        // A closure that is called when user changes the rating by touching the view.
        // This can be used to update UI as the rating is being changed by moving a finger.
        let hhjhj: () = ratingVW.didTouchCosmos = { rating in }
        
        print("Rating:",hhjhj)
        
    }
    

    @IBAction func act_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func act_Submit(_ sender: Any) {
        ratingSubmitStatus = true
        
        if ratinValue == 0{
            ratingSubmitStatus = false
            ApiService.shared.showAlert(title: "", msg: "Please give rating & review.".localiz() )
        }else if self.txt_EnterYourReview.text == "" {
            ratingSubmitStatus = false
            ApiService.shared.showAlert(title: "", msg: "Please give rating & review.".localiz() )
        }
        
        if ratingSubmitStatus{
            
            //Comented by prince 22 - 06 - 2022
//            if let name = UserDefaults.standard.string(forKey: "UserName"){
//                self.ratingReviewApi(userName:name)
//            }
            self.ratingReviewApi()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func ratingReviewApi(){
        
        let parameters:[String:Any] = ["product_id":prodId, "name":custmorName,"review":self.txt_EnterYourReview.text!,"rating":self.ratinValue,"customer_id":customer_Id]
        print("ParamValue:",parameters)
        RatingReviewDataResponce.AddUserData(api: "appapi/product/add_rating", parameters: parameters) { (data) in
            if data != nil{
                let responseCode = data?.responseCode
                    // let responseData = data?.reviewData
                let responseText = data?.responseText ?? ""
                switch responseCode {
                case 1:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                case 0:
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                default :
                    ApiService.shared.showAlert(title: "", msg: "\(responseText)" )
                }
                
                let when = DispatchTime.now() + 2
                        DispatchQueue.main.asyncAfter(deadline: when){
                            self.navigationController?.popViewController(animated: true)
                }
            }
        }
       
    }
    
   
}

extension RatingViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

  }
  func textFieldDidEndEditing(_ textField: UITextField) {

  }
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return true
  }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
      return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
      return true
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      return true
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {

      return true
  }
}
