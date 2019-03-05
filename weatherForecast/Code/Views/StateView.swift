//
//  LoadingView.swift
//  weatherForecast
//
//  Created by Emiliano Baublys on 05/03/2019.
//  Copyright © 2019 Emiliano Baublys. All rights reserved.
//

import UIKit

class StateView: UIView {

    public enum state {
        case loading
        case empty
        case noInternet
    }

    @IBOutlet weak var stateImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!

    func hide() {
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform(translationX: 0, y: -800)
            self.alpha = 0
        }
    }

    func show(for state: state, toView: UIView) {
        stateImage.layer.removeAllAnimations()
        self.bounds.size.width = toView.bounds.size.width
        self.bounds.size.height = toView.bounds.size.height
        self.center = toView.center
        switch state {
        case .loading:
            stateImage.image = UIImage(named: "Clear Sky (Day)")
            messageLabel.text = ""
            animate()
        case .empty:
            stateImage.image = UIImage(named: "data_error")
            messageLabel.text = "No data! :("
        case .noInternet:
            stateImage.image = UIImage(named: "no_internet")
            messageLabel.text = "Ooops! looks like there is no connection!"
        }
        toView.addSubview(self)
    }

    fileprivate func animate() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi
        rotationAnimation.duration = 3.0
        rotationAnimation.repeatCount = .greatestFiniteMagnitude
        self.stateImage.layer.add(rotationAnimation, forKey: nil)
    }
}
