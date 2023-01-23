//
//  UIViewController + BackgroundStatusBar.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/23/23.
//

import UIKit

extension UIViewController {
    func statusBarColorChange() {
        let color = UIColor(red: 0.278, green: 0.078, blue: 0.396, alpha: 1.0)
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = color
            statusBar.tag = 100
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        } else {
            
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
            
        }
    }
}
