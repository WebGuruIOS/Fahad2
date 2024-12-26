//
//  Category2ViewModel.swift
//  BoutiqAK
//
//  Created by Ananda Sen on 02/11/21.
//  Copyright © 2021 wbg. All rights reserved.
//

import Foundation
class CategoryViewModel2: NSObject {
    var categorylist:[CategoryListingData] = []
    var array:[Bool] = []
    func categorylistCount()-> Int{
        return categorylist.count
    }
}
