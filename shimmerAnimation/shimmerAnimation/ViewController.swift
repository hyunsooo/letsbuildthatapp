//
//  ViewController.swift
//  shimmerAnimation
//
//  Created by hyunsu han on 2018. 6. 23..
//  Copyright © 2018년 hyunsoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // set text label
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
        textLabel.text = "HYUNSOO"
        textLabel.textColor = UIColor(white: 1, alpha: 0.15)
        textLabel.font = .systemFont(ofSize: 40)
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        let shinyTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 400))
        shinyTextLabel.text = "HYUNSOO"
        shinyTextLabel.textColor = .white
        shinyTextLabel.font = .systemFont(ofSize: 40)
        shinyTextLabel.textAlignment = .center
        view.addSubview(shinyTextLabel)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = shinyTextLabel.frame
        
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        
        shinyTextLabel.layer.mask = gradientLayer
        
        // set animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 2
        animation.fromValue = -view.frame.width
        animation.toValue = view.frame.width
        animation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: "doesn't_matter_some_key")
        
        
//        view.layer.addSublayer(gradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

