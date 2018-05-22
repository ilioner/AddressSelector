//
//  ViewController.swift
//  AddressSelector
//
//  Created by Tywin on 2018/5/21.
//  Copyright © 2018年 Tywin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selector:AddressSelector = AddressSelector.init(frame: CGRect.init(x: 100, y: 40, width: self.view.frame.size.width-100, height: self.view.frame.size.height-40))
        self.view.addSubview(selector)
    }
}

