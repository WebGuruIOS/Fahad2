//
//  CheckReachbility.swift
//  Classefy Student
//
//  Created by Kondalu on 25/05/21.
//
import AVFoundation
import UIKit
import Alamofire
class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
