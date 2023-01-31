//
//  UIView + ShowIndicator.swift
//  MediaFinder
//
//  Created by Tolba on 23/06/1444 AH.
//

import UIKit
extension UIView {
    func showLoader() {
       let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    func hideLoader() {
        if let activityIndicator = viewWithTag(333) {
            activityIndicator.removeFromSuperview()
        }
    }
    
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.center = self.center
        activityIndicator.style = .large
        activityIndicator.tag = 333
        return activityIndicator
    }
}
