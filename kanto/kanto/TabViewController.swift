//
//  ViewController.swift
//  kanto
//
//  Created by George Tevosov on 15.02.2022.
//

import UIKit

class TabViewController: UITabBarController {

    convenience init () {
        self.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0
        
        // Do any additional setup after loading the view.
    }
    
    func showPin(data: String) {
        print(data)
    }


}

