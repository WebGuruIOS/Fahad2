//
//  SortViewModel.swift
//  Fahad
//
//  Created by Kondalu on 24/09/21.
//

import Foundation
import UIKit
import Alamofire
class SortDataResponce: UIViewController {
    
    static let shared = SortDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(SortDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(SortDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}


