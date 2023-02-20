//
//  UIview+Extensions.swift
//  Fazpass Example
//
//  Created by Akbar Putera on 06/02/23.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?, in vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        vc.present(alert, animated: true)
    }
    
    func showLoadingView(in uview: UIView) {
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0,0,50,50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        
        let greyView = UIView()
        greyView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        greyView.backgroundColor = .black
        greyView.alpha = 0.5
        uview.addSubview(greyView)
        greyView.addSubview(activityIndicator)
    }
    
    func dismissLoadingVIew(in uview: UIView) {
        uview.removeFromSuperview()
    }
}
