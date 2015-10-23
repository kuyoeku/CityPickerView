//
//  ViewController.swift
//  pickCellTest
//
//  Created by JarlRyan on 15/10/23.
//  Copyright © 2015年 JarlRyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,PickerCellsDelegate {

    @IBOutlet weak var pickTableView: UITableView!
    
    var dataArray : NSArray = NSArray()
    var cityArray : NSArray = NSArray()
    var areaArray : NSArray = NSArray()
    
    var province : String = ""
    var city : String = ""
    var area : String = ""
    
    var finalValue : String = ""
    
    var pickersController : PickerCellsController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickersController = PickerCellsController()
        self.pickersController.attachToTableView(self.pickTableView, tableViewsPriorDelegate: self, withDelegate: self)
        
        let pickerView : CityPickerView = CityPickerView()
        //默认值的省 市 区 以空格分割 例：浙江 杭州市 市辖区
        pickerView.initData(pickTableView,pickerC: pickersController,defaultValue: "澳门  ")
        
        
        let pickerIP = NSIndexPath(forRow: 0, inSection: 0)
        self.pickersController.addPickerView(pickerView, forIndexPath: pickerIP)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        if let picker : CityPickerView = self.pickersController.pickerForOwnerCellIndexPath(indexPath) as? CityPickerView {

            cell.textLabel?.text = picker.getPickerViewResult()
        }else {
            cell.textLabel?.text = "222"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
 
    //MARK:- PickerCellsDelegate
    
    func pickerCellsController(controller: PickerCellsController!, willExpandTableViewContent tableView: UITableView!, forHeight expandHeight: CGFloat) {
//        print("expand height =\(expandHeight)")
    }
    
    func pickerCellsController(controller: PickerCellsController!, willCollapseTableViewContent tableView: UITableView!, forHeight expandHeight: CGFloat) {
//        print(expandHeight)
    }
    
 }

