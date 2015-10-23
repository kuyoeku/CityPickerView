//
//  AreaModel.swift
//  pickCellTest
//
//  Created by JarlRyan on 15/10/23.
//  Copyright © 2015年 JarlRyan. All rights reserved.
//

import Foundation

class AreaModel : NSObject {
    var cites : NSArray = NSArray()
    var state : String = ""
    
    init(dictionary : NSDictionary){
        let areaCitiesArray : NSMutableArray = NSMutableArray()
        dictionary["cities"]?.enumerateObjectsUsingBlock({
            (dict,idx,stop) in
            
            let areaCitiesModel : AreaCitiesModel = AreaCitiesModel(dict: dict as! NSDictionary)
            areaCitiesArray.addObject(areaCitiesModel)
            
        })
        
        self.cites = areaCitiesArray
        self.state = dictionary["state"] as! String
    }
}
