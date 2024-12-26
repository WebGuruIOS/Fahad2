//
//  Global.swift
//  Fahad
//
//  Created by Prince on 21/06/22.
//

import Foundation
import AVFoundation

let baseURL = "https://www.ozone-ws.com/?route="
// https://www.ozone-ws.com/?route=appapi/
var strRating:String = ""
var nav_State:String = ""
var nav_status_delegate:Bool = false

class Global: NSObject {
   
    class var sharedManager: Global {
        struct Static {
            static let instance = Global()
        }
        return Static.instance
    }
}
