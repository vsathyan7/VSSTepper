//
//  VSStepper.swift
//  VSStepperExample
//
//  Created by Sathya Venkataraman on 3/7/17.
//  Copyright © 2017 Sathya Venkataraman. All rights reserved.
//

import UIKit

@IBDesignable public class VSStepper: UIControl {
    
    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    var labelOriginalCenter: CGPoint!
    
    @IBInspectable public var value: Double = 0  {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
             label.text = String(Int(value))
        
            if oldValue != value {
               sendActions(for: .valueChanged)
            }
        }
    }
    
    @IBInspectable public var minimumValue: Double = 0 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
        }
    }
    
    /// Maximum value. Must be more than minimumValue. Defaults to 100.
    @IBInspectable public var maximumValue: Double = 100 {
        didSet {
            value = min(maximumValue, max(minimumValue, value))
        }
    }
    
    @IBInspectable public var leftButtonText: String = "-" {
        didSet {
            leftButton.setTitle(leftButtonText, for: .normal)
        }
    }
    
    @IBInspectable public var rightButtonText: String = "+" {
        didSet {
            rightButton.setTitle(rightButtonText, for: .normal)
        }
    }
    
    @IBInspectable public var buttonsTextColor: UIColor = UIColor.white {
        didSet {
            for button in [leftButton, rightButton] {
                button.setTitleColor(buttonsTextColor, for: .normal)
            }
        }
    }
    
    @IBInspectable public var buttonsFont:UIFont = UIFont(name: "AvenirNext-Bold", size: 20.0)! {
        didSet {
            for button in [leftButton, rightButton] {
                button.titleLabel?.font = buttonsFont
            }
        }
    }
    
    public var labelFont : UIFont = UIFont (name: "AvenirNext-Bold", size: 15.0)! {
        didSet {
            label.font = labelFont
        }
    }
    
    public var labelWidthWeight: CGFloat = 0.5 {
        didSet {
            labelWidthWeight = min(1, max(0, labelWidthWeight))
            setNeedsLayout()
        }
    }
    
    @IBInspectable public var labelTextColor: UIColor = UIColor.white  {
        didSet {
            label.textColor = labelTextColor
        }
    }
    
    @IBInspectable public var labelBackgroundColor: UIColor = UIColor(red:0.26, green:0.6, blue:0.87, alpha:1) {
        didSet {
            label.backgroundColor = labelBackgroundColor
        }
    }
    
    @IBInspectable public var buttonsBackgroundColor: UIColor = UIColor(red:0.21, green:0.5, blue:0.74, alpha:1) {
        didSet {
            for button in [leftButton, rightButton] {
                button.backgroundColor = buttonsBackgroundColor
            }
            backgroundColor = buttonsBackgroundColor
        }
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        
        leftButton.setTitle(leftButtonText, for: .normal)
        leftButton.backgroundColor = buttonsBackgroundColor
        leftButton.setTitleColor(buttonsTextColor, for: .normal)
        leftButton.titleLabel?.font = buttonsFont
        leftButton.addTarget(self, action: #selector(VSStepper.leftButtonTouchDown), for: .touchDown)
        addSubview(leftButton)
        
        rightButton.setTitle(rightButtonText, for: .normal)
        rightButton.backgroundColor = buttonsBackgroundColor
        rightButton.setTitleColor(buttonsTextColor, for: .normal)
        rightButton.titleLabel?.font = buttonsFont
        rightButton.addTarget(self, action: #selector(VSStepper.rightButtonTouchDown), for: .touchDown)
        addSubview(rightButton)
        
        label.text = String(Int(value))
        label.textAlignment = .center
        label.backgroundColor = labelBackgroundColor
        label.textColor = labelTextColor
        label.font = labelFont
        addSubview(label)
        
        backgroundColor = buttonsBackgroundColor
    
        leftButton.addTarget(self, action: #selector(VSStepper.leftButtonTouchDown), for: .touchDown)
        
    }
    
    override public func layoutSubviews() {
        let labelWidthWeight: CGFloat = 0.5
        
        let buttonWidth = bounds.size.width * ((1 - labelWidthWeight) / 2)
        let labelWidth = bounds.size.width * labelWidthWeight
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: bounds.size.height)
        
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: bounds.size.height)
        
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: bounds.size.height)
        labelOriginalCenter = label.center
    }
    
    func leftButtonTouchDown(button: UIButton) {
        value -= 1
    }
    
    func rightButtonTouchDown(button: UIButton) {
        value += 1
    }

}
