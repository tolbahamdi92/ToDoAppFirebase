//
//  UITextField + addBottomBorder.swift
//  TodoList
//
//  Created by Tolba Hamdi on 1/26/23.
//

import UIKit

extension UITextField {
    func addBottomBorder(height: CGFloat = 1, color: CGColor = Colors.grayColor.cgColor){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        bottomLine.backgroundColor = color
        layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
    }
}
