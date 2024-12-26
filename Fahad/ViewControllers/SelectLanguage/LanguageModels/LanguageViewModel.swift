//
//  LanguageViewModel.swift
//  Fahad
//
//  Created by Kondalu on 25/09/21.
//

import Foundation
import UIKit
import Alamofire
class LanguageDataResponce: UIViewController {
    
    static let shared = LanguageDataResponce()
    public static func AddUserData(api:String,parameters:[String:Any],completion: @escaping(LanguageDataStruct?)->Void)  {
        
        ApiService.shared.mobileApiRequest(api: api, method: .post, parameters: parameters) { (data, val, error) in
            guard let data = data else { return }
            do{
                let res = try JSONDecoder().decode(LanguageDataStruct.self, from: data)
                completion(res)
            }catch{
                completion(nil)
                print("Error on parsing")
            }
        }
    }
    
}
