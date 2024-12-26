//
//  MyAdressViewModel.swift
//  Fahad
//
//  Created by Kondalu on 13/09/21.
//


import Foundation
import UIKit
import Alamofire
class MyAdressDataResponce: UIViewController {
    
    static let shared = MyAdressDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(MyAddressDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(MyAddressDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}

