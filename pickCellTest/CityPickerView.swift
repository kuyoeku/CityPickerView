//
//  CityPickerView.swift
//  pickCellTest
//
//  Created by JarlRyan on 15/10/23.
//  Copyright © 2015年 JarlRyan. All rights reserved.
//

import UIKit

class CityPickerView: UIPickerView,UIPickerViewDelegate, UIPickerViewDataSource {

    var dataArray : NSArray = NSArray()
    var cityArray : NSArray = NSArray()
    var areaArray : NSArray = NSArray()
    
    var province : String = ""
    var city : String = ""
    var area : String = ""
    
    var finalValue : String = ""
    
    var tableView : UITableView!
    var pickerController : PickerCellsController!
    
    
    func initData(tableView : UITableView, pickerC : PickerCellsController,defaultValue : [String] = []){
        self.delegate = self
        self.dataSource = self
        dataArray = AreaFactory.getAreaArray()
        
        let firstAreaModel : AreaModel = dataArray.firstObject as! AreaModel
        cityArray = firstAreaModel.cites
        
        let firstCitiesModel : AreaCitiesModel = cityArray.firstObject as! AreaCitiesModel
        areaArray = firstCitiesModel.areas
        
        province = firstAreaModel.state
        city = firstCitiesModel.state
        area = areaArray.firstObject as! String
        
        if defaultValue.count > 0 {
            
            var provinceIndex : Int = 0
            var cityIndex : Int = 0
            var areaIndex : Int = 0
            
            dataArray.enumerateObjectsUsingBlock({
                (item, idx, er) in
                let currAreaModel : AreaModel = item as! AreaModel
                if currAreaModel.state == defaultValue[0] {
                    provinceIndex = idx
                    self.cityArray = currAreaModel.cites
                }
                
            })
            
            cityArray.enumerateObjectsUsingBlock({
                (item, idx, er) in
                let currCitiesModel : AreaCitiesModel = item as! AreaCitiesModel
                if currCitiesModel.state == defaultValue[1] {
                    cityIndex = idx
                    self.areaArray = currCitiesModel.areas
                }
                
            })
            
            areaArray.enumerateObjectsUsingBlock({
                (item, idx, er) in
                let currArea : String = item as! String
                if currArea == defaultValue[2] {
                    areaIndex = idx
                }
                
            })
            if defaultValue[1] == "" && cityIndex == 0 {
                self.areaArray = NSArray()
            }
            if defaultValue[2] == "" && areaIndex == 0 {
                self.area = ""
            }
            finalValue = defaultValue[0] + " " + defaultValue[1] + " " + defaultValue[2]
            
            self.selectRow(provinceIndex, inComponent: 0, animated: false)
            self.selectRow(cityIndex, inComponent: 1, animated: false)
            self.selectRow(areaIndex, inComponent: 2, animated: false)
        }else{
            finalValue = province + " " + city + " " + area
        }
        
        self.tableView = tableView
        self.pickerController = pickerC
        
    }
    
    func getPickerViewResult() -> String{
        return finalValue
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var number : Int = 0
        
        switch (component) {
        case 0:
            number = dataArray.count
            break
        case 1:
            number = cityArray.count
            break
        case 2:
            number = areaArray.count
            break
        default :
            break
        }
        return number;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var text : String = "请选择"
        switch (component) {
        case 0:
            let currAreaModel : AreaModel = dataArray[row] as! AreaModel
            text = currAreaModel.state
            break
        case 1:
            if cityArray.count>0 {
                let currAreaCityModel : AreaCitiesModel = cityArray[row] as! AreaCitiesModel
                text = currAreaCityModel.state
            }else{
                text = ""
            }
            
            break
        case 2:
            if areaArray.count>0 {
                text = areaArray[row] as! String
            }else{
                text = ""
            }
            break
        default :
            break
        }
        return text
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (0 == component) {
            let areaModel : AreaModel = dataArray[row] as! AreaModel
            cityArray = areaModel.cites
            province = areaModel.state
            
            
            //            debugPrint(cityArray)
            
            if cityArray.count > 0 {
                let citiesModel : AreaCitiesModel = cityArray.firstObject as! AreaCitiesModel
                areaArray = citiesModel.areas
                city = citiesModel.state
            }else{
                city = ""
                areaArray = NSArray()
            }
            
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            
            
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
            if areaArray.count > 0{
                area = areaArray.firstObject as! String
            }else{
                area = ""
            }
            
            
        } else if (1 == component) {
            if (cityArray.count > 0) {
                let citiesModel : AreaCitiesModel = cityArray[row] as! AreaCitiesModel
                areaArray = citiesModel.areas
                
                if citiesModel.state != city {
                    city = citiesModel.state
                    pickerView.reloadComponent(2)
                    pickerView.selectRow(0, inComponent: 2, animated: true)
                }
                area = areaArray.firstObject as! String
                
            }
        } else if (2 == component) {
            if areaArray.count > 0{
                area = areaArray[row] as! String
            }
            
        }
        
        finalValue = province + " " + city + " " + area
        let ip : NSIndexPath = self.pickerController.indexPathForPicker(pickerView)
        self.tableView.reloadRowsAtIndexPaths([ip], withRowAnimation: .Automatic)
    }

}
