//
//  AppDelegate.swift
//  AMov1920P2ios1z
//
//  Created by Alvaro Santos on 29/11/2019.
//  Copyright © 2019 DEIS-ISEC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var lstReceitas : [Receita] = [] {
        didSet {
            print("Lista de Receitas:")
            for receita in lstReceitas {
                print("   - \(receita.nome)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    
}

