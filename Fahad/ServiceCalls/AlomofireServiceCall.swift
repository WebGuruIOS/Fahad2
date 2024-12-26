//
//  AlomofireServiceCall.swift
//  Classefy Student
//
//  Created by Kondalu on 25/05/21.
//
import AVFoundation
import UIKit
import Alamofire
import SVProgressHUD

class ApiService {
    
    static let shared = ApiService()
    //http://143.110.245.119:5300/site-api
  //  var baseURL = "https://www.developer-beta.com:5000/site-api/"
    var baseURL = "https://www.ozone-ws.com/?route="
    //21 - 06 - 2022 New base = https://www.ozone-ws.com?route=appapi/

   // https://www.developer-beta.com:5000/
    //var userApi = "/student-login"
    // Development url = http://developer-beta.com/p2/Fahad/index.php?route=
    //Live url = https://www.ozone-ws.com/?route=
    //show Alert
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let topController = UIApplication.shared.windows[0].rootViewController {
            topController.present(alert, animated: true, completion: nil)
        }
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
   
    func mobileApiRequest(api: String,method:HTTPMethod,parameters:[String:Any],completion: @escaping(Data?,Any?,Error?)->Void)   {
        
        ACProgressHUD.shared.showHUD()
//        SVProgressHUD.show()
//        SVProgressHUD.setBackgroundColor(UIColor.white)
//        SVProgressHUD.setForegroundColor(UIColor.black)
//        let color = UIColor.darkGray.withAlphaComponent(0.7)
//        SVProgressHUD.setBackgroundLayerColor(color)
        
        let baseUrl1 = baseURL
        guard let url = URL(string: baseUrl1 + api) else {
            completion(nil, nil, nil)
            return
        }
        print("Complete_url",url)
        print("ApiName:",api)
        if Connectivity.isConnectedToInternet() {
        }else{
            self.showAlert(title: "Attention!", msg: "The Internet connection appears to be offline.")
            ACProgressHUD.shared.hideHUD()
           // SVProgressHUD.dismiss()
            return
        }
        print(parameters)
        print("CompleteUrl:",url)
        var header:HTTPHeaders = [:]
        header["contentType"] = "application/json"
        Alamofire.request(url, method: method, parameters: parameters,encoding: URLEncoding.default,headers: header).responseJSON(completionHandler: { (response) in
            print(response)
            let code = response.response?.statusCode
            if code == 401{
                self.showAlert(title: "error\(code ?? 0)", msg: "Something went wrong")
            }
            switch(response.result) {
            case .success(_):
                if let data = response.data{
                    completion(data, response.value, response.error)
                }
                ACProgressHUD.shared.hideHUD()
                //SVProgressHUD.dismiss()
                break
            case .failure(_):
                completion(nil, nil, response.error)
                ACProgressHUD.shared.hideHUD()
                //SVProgressHUD.dismiss()
                //let code = response.response?.statusCode
                print("error on service call1", response.error?.localizedDescription as Any)
              //  self.showAlert(title: "error(\(code ?? 0))", msg: "\(response.error?.localizedDescription as Any)")
                break
            }
        })
    }
    
}

