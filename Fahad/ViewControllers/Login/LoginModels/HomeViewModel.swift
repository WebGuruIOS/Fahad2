//
//  HomeViewModel.swift
//  Fahad
//
//  Created by Kondalu on 02/09/21.
//

import Foundation
import UIKit
import Alamofire
class HomeDataResponce: UIViewController {
    
    static let shared = HomeDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(HomeDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(HomeDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}

