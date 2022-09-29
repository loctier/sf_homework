//
//  ViewController.swift
//  module_26
//
//  Created by Denis Loctier on 29/09/2022.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    let button = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .default)
    
    let mainImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainImageWidth = self.view.frame.width/1.5
        
        mainImage.frame = CGRect.init(x: self.view.frame.width/2-mainImageWidth/2,
                                      y: self.view.frame.height/3-mainImageWidth/2,
                                      width: mainImageWidth,
                                      height: mainImageWidth)
        
        self.view.addSubview(mainImage)
        
        
        
        button.frame = CGRect.init(x: self.view.frame.width/2-40,
                                   y: self.view.frame.height/1.25-40,
                                   width: 80,
                                   height: 80)
        
        button.tintColor = .white
        button.layer.cornerRadius = button.frame.width/2
        button.backgroundColor = .black
        
        button.addTarget(self,
                         action: #selector(buttonAction),
                         for: .touchUpInside)
        
        self.view.addSubview(button)
        
        updateView()
        
    }
    
    @objc
    func buttonAction() {
        if defaults.bool(forKey: "DarkMode") {
            defaults.set(false, forKey: "DarkMode")
        } else {
            defaults.set(true, forKey: "DarkMode")
        }
        
        updateView()
        
    }
    
    func updateView() {
        
        var buttonImage = UIImage(systemName: "moon.circle.fill", withConfiguration: config)
        var bgColor: UIColor = .darkGray
        var imageName: String = "dark"
        
        if !defaults.bool(forKey: "DarkMode") {
            buttonImage = UIImage(systemName: "sun.max.circle.fill", withConfiguration: config)
            bgColor = .lightGray
            imageName = "light"
        }
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) {
            self.button.setImage(buttonImage, for: .normal)
            self.view.backgroundColor = bgColor
            self.mainImage.image = UIImage(named: imageName)
        }
    }
}

