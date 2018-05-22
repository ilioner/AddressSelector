//
//  ViewController.swift
//  AddressSelector
//
//  Created by Tywin on 2018/5/21.
//  Copyright © 2018年 Tywin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selector:AddressSelector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showButton = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 80, height: 40))
        showButton.setTitle("Show", for: UIControlState.normal)
        self.view.addSubview(showButton)
        
        showButton.addTarget(self, action:#selector(clickShow), for: UIControlEvents.touchUpInside)
        
        self.view.backgroundColor = UIColor.init(red: 223/255, green: 230/255, blue: 233/255, alpha: 1)
        self.selector = AddressSelector.init(frame: CGRect.init(x: self.view.frame.size.width, y: 40, width: self.view.frame.size.width-100, height: self.view.frame.size.height-40))
        self.view.addSubview(self.selector!)
        
        
    }
    
    @objc func clickShow() {
        UIView.animate(withDuration: 0.2) {
            self.selector?.frame = CGRect.init(x: 100, y: 40, width: self.view.frame.size.width-100, height: self.view.frame.size.height-40)
        }
    }
}

