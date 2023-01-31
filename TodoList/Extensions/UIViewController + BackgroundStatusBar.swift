//
//  UIViewController + BackgroundStatusBar.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/23/23.
//

import UIKit

extension UIViewController {
    func statusBarColorChange() {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = Colors.purpleColor
            statusBar.tag = 100
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        } else {
            
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = Colors.purpleColor
            
        }
    }
}
