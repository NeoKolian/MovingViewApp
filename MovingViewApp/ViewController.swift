//
//  ViewController.swift
//  MovingViewApp
//
//  Created by Nikolay Pochekuev on 17.04.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var squareView: UIView!
    var location = CGPoint(x: 0, y: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        squareView.layer.cornerRadius = 8
    }


}

extension ViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateSquare(with: touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateSquare(with: touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetSquareRotation()
    }
    
    private func animateSquare(with touches: Set<UITouch>) {
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: { [weak self] in
            guard let self = self else { return }
            let touch: UITouch = touches.first! as UITouch
            self.location = touch.location(in: self.view)
            self.squareView.center = self.location
            
            let rotationAngle = self.rotationAngle(for: self.squareView.center)
            self.squareView.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
        })
    }
    
    private func rotationAngle(for center: CGPoint) -> CGFloat {
        let offset = center.x - self.view.bounds.width / 2
        return offset * CGFloat.pi / 180
    }
    
    private func resetSquareRotation() {
        UIView.animate(withDuration: 0.5) {
            self.squareView.transform = .identity
        }
    }
}
