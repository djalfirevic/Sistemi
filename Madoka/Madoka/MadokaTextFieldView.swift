//
//  MadokaTextFieldView.swift
//  Madoka
//
//  Created by Djuro Alfirevic on 4/7/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

let animationDuration: TimeInterval = 1.0
let fontSize: CGFloat = 14.0
let margin: CGFloat = 10.0
let borderDimension: CGFloat = 1.0

class MadokaTextFieldView: UIView {

    // MARK: - Properties
    var topBorderView = UIView()
    var bottomBorderView = UIView()
    var rightBorderView = UIView()
    var leftBorderView = UIView()
    var titleLabel = UILabel()
    var textField = UITextField()
    var titleLabelOriginFrame = CGRect.zero
    var borderLayer = CAShapeLayer()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    // Initialization from storyboard...
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureUI()
    }

    // MARK: - Public API
    func configureUI() {
        // Borders.
        topBorderView.backgroundColor = UIColor.red
        addSubview(topBorderView)
        bottomBorderView.backgroundColor = UIColor.red
        addSubview(bottomBorderView)
        rightBorderView.backgroundColor = UIColor.red
        addSubview(rightBorderView)
        leftBorderView.backgroundColor = UIColor.red
        addSubview(leftBorderView)

        // Text field.
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.textColor = UIColor.blue
        textField.delegate = self
        addSubview(textField)

        // Title label.
        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: fontSize)
        titleLabel.text = "First name"
        addSubview(titleLabel)

        layer.addSublayer(borderLayer)
    }

    func open() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: bottomBorderView.frame.origin.y))
        path.addLine(to: CGPoint(x: bounds.width - borderDimension, y: bottomBorderView.frame.origin.y))
        path.addLine(to: CGPoint(x: bounds.width - borderDimension, y: bounds.origin.y + borderDimension))
        path.addLine(to: CGPoint(x: bounds.origin.x + borderDimension, y: bounds.origin.y + borderDimension))
        path.close()
        borderLayer.path = path.cgPath
        borderLayer.lineCap = kCALineCapSquare
        borderLayer.lineWidth = borderDimension
        borderLayer.fillColor = nil
        borderLayer.strokeColor = UIColor.red.cgColor

        // Animate path.
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1.0;
        pathAnimation.fromValue = CGFloat(0.0)
        pathAnimation.toValue = CGFloat(1.0)
        borderLayer.add(pathAnimation, forKey: "strokeEnd")
        borderLayer.strokeEnd = 1.0
    }

    func close() {
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1.0;
        pathAnimation.fromValue = CGFloat(1.0)
        pathAnimation.toValue = CGFloat(0.0)
        borderLayer.add(pathAnimation, forKey: "strokeEnd")
        borderLayer.strokeEnd = 0.0
    }

    // MARK: - View lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()

        // We need to change frames for views, because after this method gets called, our 'bounds' are final.
        topBorderView.frame = CGRect(x: bounds.size.width - borderDimension, y: 0.0, width: 0.0, height: 0.0)
        bottomBorderView.frame = CGRect(x: 0.0, y: bounds.size.height - margin, width: bounds.size.width, height: borderDimension)
        rightBorderView.frame = CGRect(x: bounds.size.width - borderDimension, y: bottomBorderView.frame.origin.y, width: borderDimension, height: 0.0)
        leftBorderView.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0)

        textField.frame = CGRect(x: borderDimension + margin, y: borderDimension, width: bounds.size.width - 2 * borderDimension - 2 * margin, height: bottomBorderView.frame.origin.y - 2 * borderDimension)

        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: textField.frame.origin.x, y: (textField.frame.size.height - titleLabel.frame.size.height)/2 + borderDimension, width: titleLabel.frame.size.width, height: titleLabel.frame.size.height)
        titleLabelOriginFrame = titleLabel.frame
    }

}

extension MadokaTextFieldView: UITextFieldDelegate {

    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        open()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        close()
    }

}
