//
//  ViewController.swift
//  CountAnimationLBTA
//
//  Created by hyunsu han on 2018. 6. 24..
//  Copyright © 2018년 hyunsoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let countingLabel: UILabel = {
        let label = UILabel()
        label.text = "1234"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    
    var start: Double = 500
    let end: Double = 1000
    let animationDuration: Double = 100
    
    let animationStartDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .defaultRunLoopMode)
    }
    
    @objc func handleUpdate() {
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            self.countingLabel.text = "\(end)"
        } else {
            let percentage = elapsedTime / animationDuration
            let value = start + percentage * (end - start)
            self.countingLabel.text = "\(Int(value))"
        }
    }

}

