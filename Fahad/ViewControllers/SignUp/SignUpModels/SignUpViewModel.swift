//
//  SignUpViewModel.swift
//  Fahad
//
//  Created by Kondalu on 04/09/21.
//

import Foundation
import UIKit
import Alamofire
class SignUpDataResponce: UIViewController {
    
    static let shared = SignUpDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(SignUpDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(SignUpDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}

