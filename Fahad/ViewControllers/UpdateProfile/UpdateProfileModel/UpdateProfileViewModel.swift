//
//  UpdateProfileViewModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//

import Foundation
import UIKit
import Alamofire
class UpdateProfileDataResponce: UIViewController {
    
    static let shared = UpdateProfileDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(UpdateProfileDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(UpdateProfileDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}



