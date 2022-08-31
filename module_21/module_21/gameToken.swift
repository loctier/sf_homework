//
//  gameToken.swift
//  module_21
//
//  Created by Denis Loctier on 24/08/2022.
//

import UIKit

class gameToken: UIView {

    var workingView: UIView!
    var xibName: String = "gameToken"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    func getFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: xibName, bundle: bundle)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func setCustomView() {
        workingView = getFromXib()
        workingView.frame = bounds
        workingView.clipsToBounds = true
        workingView.layer.cornerRadius = frame.size.height/2
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(workingView)
    }
    
    
    
//    @IBAction func dragging(_ gesture: UIPanGestureRecognizer) {
//    
//        let gestureTranslation = gesture.translation(in: self)
//        
//        guard let gestureView = gesture.view else { return }
//        
//        gestureView.center = CGPoint(
//            x: gestureView.center.x + gestureTranslation.x,
//            y: gestureView.center.y + gestureTranslation.y
//        )
//        
//        gesture.setTranslation(.zero, in: self)
//        
//        guard gesture.state == .ended else {
//            return
//        }
//        
//        
//        
//        
//    }
    
    
}
