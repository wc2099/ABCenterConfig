//
//  ViewController.swift
//  ABCenterConfig
//
//  Created by Jack on 07/25/2025.
//  Copyright (c) 2025 Jack.cai. All rights reserved.
//

import UIKit
import ABCenterConfig;
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ABCenterConfig.shared.fetchAndActivate { status, error in
            switch status {
            case .successFetchedFromRemote:
                print("成功从远程拉取并激活")
            case .successUsingPreFetchedData:
                print("使用了缓存的配置")
            case .error:
                print("拉取失败：\(String(describing: error))")
            }
            
            if let someValue = ABCenterConfig.shared.string(forKey: "some_key") {
                print("配置值: \(someValue)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

