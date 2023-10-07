//
//  CustomButton.swift
//  SEL4C
//
//  Created by Daniel Rong Chen on 04/10/23.
//

import UIKit

class CustomButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // 2
        enum ButtonState {
            case normal
            case disabled
        }
        // 3
        private var disabledBackgroundColor: UIColor?
        private var defaultBackgroundColor: UIColor? {
            didSet {
                backgroundColor = defaultBackgroundColor
            }
        }
        
        // 4. change background color on isEnabled value changed
        override var isEnabled: Bool {
            didSet {
                if isEnabled {
                    if let color = defaultBackgroundColor {
                        self.backgroundColor = color
                    }
                }
                else {
                    if let color = disabledBackgroundColor {
                        self.backgroundColor = color
                    }
                }
            }
        }
        
        // 5. our custom functions to set color for different state
        func setBackgroundColor(_ color: UIColor?, for state: ButtonState) {
            switch state {
            case .disabled:
                disabledBackgroundColor = color
            case .normal:
                defaultBackgroundColor = color
            }
        }

}
