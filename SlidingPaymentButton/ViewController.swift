//
//  ViewController.swift
//  SlidingPaymentButton
//
//  Created by Nirzar Gandhi on 07/04/25.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var sliderContainer: UIView!
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var sliderIcon: UIImageView!
    @IBOutlet weak var vSeparator: UIView!
    
    @IBOutlet weak var resetBtn: UIButton!
    
    
    // MARK: -
    // MARK: - View init Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setControlsProperty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    fileprivate func setControlsProperty() {
        
        self.view.backgroundColor = .white
        self.view.isOpaque = false
        
        // Slider Container
        self.sliderContainer.backgroundColor = UIColor.white
        self.sliderContainer.layer.borderColor = UIColor.black.cgColor
        self.sliderContainer.layer.borderWidth = 0.5
        self.sliderContainer.layer.cornerRadius = 10
        self.sliderContainer.layer.cornerCurve = .continuous
        
        // Slider View
        self.sliderView.backgroundColor = UIColor.black
        self.sliderView.layer.borderColor = UIColor.black.cgColor
        self.sliderView.layer.borderWidth = 0.5
        self.sliderView.layer.cornerRadius = 10
        self.sliderView.layer.cornerCurve = .continuous
        
        // Slider Icon
        self.sliderIcon.contentMode = .scaleAspectFit
        self.sliderIcon.image = UIImage(named: "slider")
        
        // Vertical Separator
        self.vSeparator.backgroundColor = .systemYellow
        
        // Reset Button
        self.resetBtn.backgroundColor = .black
        self.resetBtn.titleLabel?.backgroundColor = .clear
        self.resetBtn.setTitleColor(.white, for: .normal)
        self.resetBtn.setTitle("Reset", for: .normal)
        self.resetBtn.layer.cornerRadius = 10
        
        self.sliderView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrageLeftToRight(_:))))
    }
}


// MARK: - Call Back
extension ViewController {
    
    @objc func onDrageLeftToRight(_ sender: UIPanGestureRecognizer) {
        
        let translationX = sender.translation(in: sender.view!).x
        let minX: CGFloat = 0
        
        switch sender.state {
            
        case .began:
            break
            
        case .changed:
            
            var transX: CGFloat = minX
            if translationX < minX {
                
                transX = minX
                
            } else if translationX > minX {
                
                if translationX >= self.sliderContainer.frame.width - self.sliderView.frame.width - 4 {
                    
                    transX = self.sliderContainer.frame.width - self.sliderView.frame.width - 4
                    self.sliderIcon.image = UIImage(named: "ActiveTick")
                    
                } else if translationX > self.sliderContainer.frame.width - 26 - 54 - 40 {
                    
                    transX = translationX
                    self.sliderIcon.image = UIImage(named: "ActiveTick")
                    
                } else {
                    transX = translationX
                    self.sliderIcon.image = UIImage(named: "slider")
                }
            }
            
            self.sliderView.transform = CGAffineTransform(translationX: transX, y: minX)
            
        case .ended, .cancelled:
            
            if translationX > self.sliderContainer.frame.width - 26 - 54 - 40 {
                //self.sliderContainer.backgroundColor = UIColor.red
                //self.sliderView.backgroundColor = UIColor.green
                self.sliderIcon.image = UIImage(named: "ActiveTick")
                let endX: CGFloat = self.sliderContainer.frame.width - self.sliderView.frame.width - 4
                UIView.animate(withDuration: 0.1, animations: {
                    self.sliderView.transform = CGAffineTransform(translationX: endX, y: minX)
                })
                
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.sliderIcon.image = UIImage(named: "slider")
                    self.sliderView.transform = CGAffineTransform(translationX: minX, y: minX)
                })
            }
            
        case .failed, .possible:
            break
            
        @unknown default:
            break
        }
    }
}


// MARK: - Button Touch & Action
extension ViewController {
    
    @IBAction func resetBtnTouch(_ sender: UIButton) {
        
        self.sliderContainer.backgroundColor = UIColor.white
        self.sliderView.backgroundColor = UIColor.black
        self.sliderIcon.image = UIImage(named: "slider")
        
        self.sliderView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
}
