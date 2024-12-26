//
//  PhoneUpdateViewModel.swift
//  Fahad
//
//  Created by Prince on 28/07/22.
//

import Foundation
import UIKit
import Alamofire

class PhoneDataResponse: UIViewController{
    
    static let shared = PhoneDataResponse()
    
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(phoneDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(phoneDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
}
