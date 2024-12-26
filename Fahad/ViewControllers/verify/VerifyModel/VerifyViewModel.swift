//
//  VerifyViewModel.swift
//  Fahad
//
//  Created by Kondalu on 04/09/21.
//

import Foundation
import UIKit
import Alamofire
class VerifyOtpDataResponce: UIViewController {
    
    static let shared = ForgetPasswordDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(VerifyDataStruct?)->Void)  {
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(VerifyDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}


