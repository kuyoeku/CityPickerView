//
//  AreaCitiesModel.swift
//  pickCellTest
//
//  Created by JarlRyan on 15/10/23.
//  Copyright © 2015年 JarlRyan. All rights reserved.
//

import Foundation
class AreaCitiesModel : NSObject{
    var areas : NSArray = NSArray()
    var state : String = ""
    init(dict : NSDictionary){
        if let stateStr : String = dict["state"] as? String{
            self.state = stateStr
        }
        
        if let areaArr : NSArray = dict["areas"] as? NSArray {
            self.areas = areaArr
        }
    }
}