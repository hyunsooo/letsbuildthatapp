//
//  ViewController.swift
//  like_animation_lbta
//
//  Created by hyunsu han on 2018. 7. 3..
//  Copyright © 2018년 hyunsoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let bgImageView: UIImageView = {
        let imageView = UIImageView(image : #imageLiteral(resourceName: "background"))
        return imageView
    }()
    
    let iconContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 280, height: 55)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 25
        return containerView
    }()
    
    let icons = [UIImageView(image: #imageLiteral(resourceName: "like")), UIImageView(image: #imageLiteral(resourceName: "love")), UIImageView(image: #imageLiteral(resourceName: "wow")), UIImageView(image: #imageLiteral(resourceName: "sad")), UIImageView(image: #imageLiteral(resourceName: "angry"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.frame = view.frame
        
        setupLongPressGesture()
        icons.forEach { self.iconContainerView.addSubview($0) }
        
//        iconContainerView.addSubview(likeImageView)
//        iconContainerView.addSubview(loveImageView)
//        iconContainerView.addSubview(wowImageView)
//        iconContainerView.addSubview(sadImageView)
//        iconContainerView.addSubview(angryImageView)
        
        setConstraint(icons[0], left: iconContainerView)
        setConstraint(icons[1], left: icons[0])
        setConstraint(icons[2], left: icons[1])
        setConstraint(icons[3], left: icons[2])
        setConstraint(icons[4], left: icons[3])
    }
    
    fileprivate func setupLongPressGesture() {
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    fileprivate func setConstraint(_ v: UIView, left: UIView) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor).isActive = true
        v.leftAnchor.constraint(equalTo: left == iconContainerView ? left.leftAnchor : left.rightAnchor, constant: 5).isActive = true
        v.widthAnchor.constraint(equalToConstant: 50).isActive = true
        v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        v.clipsToBounds = false
    }
   
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            view.addSubview(iconContainerView)
            let pressedPosition = gesture.location(in: view)
            let centerX = (view.frame.width - iconContainerView.frame.width) / 2
            iconContainerView.transform = CGAffineTransform(translationX: centerX, y: pressedPosition.y)
            iconContainerView.alpha = 0
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.iconContainerView.alpha = 1
                self.iconContainerView.transform = CGAffineTransform(translationX: centerX, y: pressedPosition.y - self.iconContainerView.frame.height)
            })
        } else if gesture.state == .ended {
            iconContainerView.removeFromSuperview()
        } else if gesture.state == .changed {
            let pressedPosition = gesture.location(in: iconContainerView)
            let index = Int(pressedPosition.x / 50)
            DispatchQueue.main.sync {
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.icons.enumerated().filter { $0.offset != index }.forEach { $0.element.transform = CGAffineTransform.identity }
                    self.icons[index].transform = CGAffineTransform(scaleX: 1.2, y: 1).concatenating(CGAffineTransform(translationX: self.icons[index].bounds.origin.x, y: self.icons[index].bounds.origin.y - 50))
                })
            }
        }
    }

    override var prefersStatusBarHidden: Bool { return true }
    
}



