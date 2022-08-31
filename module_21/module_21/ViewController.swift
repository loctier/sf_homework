//
//  ViewController.swift
//  module_21
//
//  Created by Denis Loctier on 24/08/2022.
//

import UIKit

var startingSize = 50.0

class ViewController: UIViewController {

    // let centerX = self.view.frame.size.width/2
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        startingSize = screenWidth/8
        
        let marginX = screenWidth/4
        let marginY = screenHeight/4
        
        let centerX = view.center.x
        let centerY = view.center.y
        
        let midY = centerY - (centerY - marginY)/2
        
        let gameTokens: [gameToken] = [
            gameToken(frame: CGRect(x: centerX - startingSize/2, y: marginY - startingSize/2, width: startingSize, height: startingSize)),
            gameToken(frame: CGRect(x: marginX - startingSize/2, y: midY - startingSize/2, width: startingSize, height: startingSize)),
            gameToken(frame: CGRect(x: screenWidth - marginX - startingSize/2, y: midY - startingSize/2, width: startingSize, height: startingSize)),
            gameToken(frame: CGRect(x: centerX - startingSize/2, y: centerY - startingSize/2, width: startingSize, height: startingSize)),
            gameToken(frame: CGRect(x: marginX - startingSize/2, y: screenHeight - midY - startingSize/2, width: startingSize, height: startingSize)),
            gameToken(frame: CGRect(x: screenWidth - marginX - startingSize/2, y: screenHeight - midY - startingSize/2, width: startingSize, height: startingSize)),
            gameToken(frame: CGRect(x: centerX - startingSize/2, y: screenHeight - marginY - startingSize/2, width: startingSize, height: startingSize))
        ]
        
        for (index, token) in gameTokens.enumerated() {
            view.insertSubview(token, at: index)
            let draggingRecognizer = UIPanGestureRecognizer(target:self, action:#selector(dragging))
            view.subviews[index].addGestureRecognizer(draggingRecognizer)
            
        }
        
        // view.subviews[1].subviews[0].backgroundColor = .init(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)
        
    }

    @objc func dragging(_ draggingRecognizer : UIPanGestureRecognizer) {
          let draggedToken = draggingRecognizer.view!
        switch draggingRecognizer.state {
        case .began, .changed:
            let delta = draggingRecognizer.translation(in:draggedToken.superview)
            var draggedTokenCenter = draggedToken.center
            draggedTokenCenter.x += delta.x; draggedTokenCenter.y += delta.y
            draggedToken.center = draggedTokenCenter
            draggingRecognizer.setTranslation(.zero, in: draggedToken.superview)
            
        case .ended:
           
            for token in draggedToken.superview!.subviews {
                if !(token === draggedToken) && (token.subviews[0].frame.width == startingSize) && !(token.isHidden) {
                    if (abs(draggedToken.center.x-token.center.x) < startingSize) && (abs(draggedToken.center.y-token.center.y) < startingSize) {
                        
                        UIView.animate(withDuration: 0.2,
                                       delay: 0,
                                       options: .curveEaseInOut,
                                       animations: {
                            token.subviews[0].backgroundColor = .blue
                            token.subviews[0].frame = CGRect(x: token.subviews[0].frame.minX, y: token.subviews[0].frame.minY, width: startingSize*1.5, height: startingSize*1.5)
                            token.subviews[0].layer.cornerRadius = startingSize*1.5/2
                            draggedToken.alpha = 0.0

                        }, completion: nil)
                        
                        draggedToken.isHidden = true
                    }
                }
            }
            
        default: break
        }
    }
    

}

