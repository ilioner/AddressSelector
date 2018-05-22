//
//  AddressSelector.swift
//  AddressSelector
//
//  Created by Tywin on 2018/5/22.
//  Copyright © 2018年 Tywin. All rights reserved.
//

import Foundation
import UIKit

class AddressSelector: UIView,UITableViewDelegate,UITableViewDataSource{
    
    var provinceTable:UITableView?
    var cityTable:UITableView?
    var districtTable:UITableView?
    
    var dataSource:NSDictionary?
    
    var currentProvinceChild:NSDictionary?
    var currentCityChild:NSDictionary?
    var oldProvinceSelect:Int = -1
    var oldCitySelect:Int = -1
    var oldDistrictSelect:Int = -1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadDataSource()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadDataSource(){
        let filePath = Bundle.main.path(forResource: "data", ofType: "json")
        let fileData = NSData.init(contentsOfFile:filePath!)
        
        let dataString = NSString.init(data: Data.init(referencing: fileData!), encoding: String.Encoding.utf8.rawValue)
        
        let obj = getDictionaryFromJSONString(jsonString: dataString as! String)
        self.dataSource = obj
    }
    
    func setupView(){
        self.provinceTable = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), style: UITableViewStyle.plain)
        self.provinceTable?.delegate = self
        self.provinceTable?.dataSource = self
        self.addSubview(self.provinceTable!)
    }
    
    func getCityTable(){
        if self.cityTable == nil {
            self.cityTable = UITableView.init(frame: CGRect.init(x: 100, y: 0, width: self.frame.size.width-100, height: self.frame.size.height), style: UITableViewStyle.plain)
            self.cityTable?.delegate = self
            self.cityTable?.dataSource = self
            self.cityTable?.isHidden = true
            self.addSubview(self.cityTable!)
        }
    }
    
    func getDistrictTable(){
        if self.districtTable == nil {
            self.districtTable = UITableView.init(frame: CGRect.init(x: 180, y: 0, width: self.frame.size.width-180, height: self.frame.size.height), style: UITableViewStyle.plain)
            self.districtTable?.delegate = self
            self.districtTable?.dataSource = self
            self.districtTable?.isHidden = true
            self.addSubview(self.districtTable!)
        }
    }
    
    func getDictionaryFromJSONString(jsonString:String) ->NSDictionary{
        
        let jsonData:Data = jsonString.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView ==  self.provinceTable {
            return (self.dataSource?.allKeys.count)!
        }else if tableView ==  self.cityTable {
            return (self.currentProvinceChild?.allKeys.count)!
        }else{
            return (self.currentCityChild?.allKeys.count)!
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        }
        
        if tableView == self.provinceTable {
           
            let key = self.dataSource?.allKeys[indexPath.row] as! String;
            let dic:NSDictionary = self.dataSource?[key] as! NSDictionary
            let name:String = dic["name"] as! String

            cell?.textLabel?.text = name
            
            if self.oldProvinceSelect == indexPath.row{
                cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                cell?.textLabel?.textColor = UIColor.init(red: 108/255, green: 92/255, blue: 231/255, alpha: 1)
            }else{
                cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 11.0)
                cell?.textLabel?.textColor = UIColor.init(red: 99/255, green: 110/255, blue: 114/255, alpha: 1)
            }
            
        }else if tableView == self.cityTable {
            
            let key = self.currentProvinceChild?.allKeys[indexPath.row] as! String;
            let dic:NSDictionary = self.currentProvinceChild?[key] as! NSDictionary
            let name:String = dic["name"] as! String
            cell?.textLabel?.text = name
            
            if self.oldCitySelect == indexPath.row{
                cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                cell?.textLabel?.textColor = UIColor.init(red: 108/255, green: 92/255, blue: 231/255, alpha: 1)
            }else{
                cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 11.0)
                cell?.textLabel?.textColor = UIColor.init(red: 99/255, green: 110/255, blue: 114/255, alpha: 1)
            }
            
        }else{
            
            let key = self.currentCityChild?.allKeys[indexPath.row] as! String;
            let name:String = self.currentCityChild?[key] as! String
            cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
            cell?.textLabel?.text = name
            
            if self.oldDistrictSelect == indexPath.row{
                cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 12.0)
                cell?.textLabel?.textColor = UIColor.init(red: 108/255, green: 92/255, blue: 231/255, alpha: 1)
            }else{
                cell?.textLabel?.font = UIFont.italicSystemFont(ofSize: 11.0)
                cell?.textLabel?.textColor = UIColor.init(red: 99/255, green: 110/255, blue: 114/255, alpha: 1)
            }
        }
        
        
        
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        if tableView == self.provinceTable {
            
            if self.oldProvinceSelect == indexPath.row{
                return
            }
            self.oldCitySelect = -1
            self.oldDistrictSelect = -1
            self.oldProvinceSelect = indexPath.row
            self.districtTable?.isHidden = true
            
            let key = self.dataSource?.allKeys[indexPath.row] as! String;
            let dic:NSDictionary = self.dataSource?[key] as! NSDictionary
            
            if dic["child"] is NSDictionary {
                let child:NSDictionary = dic["child"] as! NSDictionary
                self.currentProvinceChild = child;
                getCityTable()
                self.cityTable?.isHidden = false
                self.cityTable?.reloadData()
            }else{
                self.cityTable?.isHidden = true
                self.cityTable?.reloadData()
            }
        }else if tableView ==  self.cityTable{
            
            self.oldCitySelect = indexPath.row
            
            let key = self.currentProvinceChild?.allKeys[indexPath.row] as! String;
            let dic:NSDictionary = self.currentProvinceChild?[key] as! NSDictionary
            
            if dic["child"] is NSDictionary {
                let child:NSDictionary = dic["child"] as! NSDictionary
                self.currentCityChild = child;
                getDistrictTable()
                self.districtTable?.isHidden = false
                self.districtTable?.reloadData()
            }else{
                self.districtTable?.isHidden = true
                self.oldDistrictSelect = -1
                self.districtTable?.reloadData()
            }
        }else{
            self.oldDistrictSelect = indexPath.row
        }
        tableView.reloadData()
    }
}
