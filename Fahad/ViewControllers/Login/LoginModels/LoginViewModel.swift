//
//  LoginViewModel.swift
//  Fahad
//
//  Created by Kondalu on 02/09/21.
//

import Foundation
import UIKit
import Alamofire
class LoginDataResponce: UIViewController {
    
    static let shared = LoginDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(LoginDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(LoginDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
