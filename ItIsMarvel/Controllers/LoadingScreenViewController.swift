//
//  LoadingScreenViewController.swift
//  ItIsMarvel
//
//  Created by Марина Айбулатова on 14.07.2021.
//

import UIKit

class LoadingScreenViewController: UIViewController {
    var loadingActivityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        
        indicator.startAnimating()
        
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleBottomMargin,
            .flexibleTopMargin, .flexibleRightMargin]
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.alpha = 0.8
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        
        loadingActivityIndicator.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        
        view.addSubview(loadingActivityIndicator)
    }
}
