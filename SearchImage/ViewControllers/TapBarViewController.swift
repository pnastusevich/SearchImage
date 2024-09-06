//
//  TapBarViewController.swift
//  SearchImage
//
//  Created by Паша Настусевич on 5.09.24.
//

import UIKit

final class TapBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBar.standardAppearance = tabBarApperance
        tabBar.scrollEdgeAppearance = tabBarApperance
        
    }
}
