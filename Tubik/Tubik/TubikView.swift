//
//  TubikView.swift
//  Tubik
//
//  Created by Djuro Alfirevic on 4/8/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

let margin: CGFloat = 15.0
let separatorWidth: CGFloat = 1.0
let animationDuration: TimeInterval = 0.4

protocol TubikViewDelegate: class {
    func leftButtonTapped(_ tubikView: TubikView)
    func middleButtonTapped(_ tubikView: TubikView)
    func rightButtonTapped(_ tubikView: TubikView)
}

@IBDesignable
class TubikView: UIView {

    // MARK: - Properties
    @IBInspectable var mainColor: UIColor = UIColor.green {
        didSet {
            mainView.backgroundColor = mainColor
        }
    }
    @IBInspectable var separatorColor: UIColor = UIColor.gray {
        didSet {
            separatorOne.backgroundColor = separatorColor
            separatorTwo.backgroundColor = separatorColor
        }
    }
    @IBInspectable var leftButtonImage: UIImage! {
        didSet {
            leftButton.setImage(leftButtonImage, for: .normal)
        }
    }
    @IBInspectable var middleButtonImage: UIImage! {
        didSet {
            middleButton.setImage(middleButtonImage, for: .normal)
        }
    }
    @IBInspectable var rightButtonImage: UIImage! {
        didSet {
            rightButton.setImage(rightButtonImage, for: .normal)
        }
    }
    @IBInspectable var maskColor: UIColor = UIColor.green

    var mainView = UIView()
    var mainMaskView = UIView()
    var separatorOne = UIView()
    var separatorTwo = UIView()
    var leftButton = UIButton()
    var middleButton = UIButton()
    var rightButton = UIButton()
    weak var delegate: TubikViewDelegate?

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configureUI()
    }

    // MARK: - Actions
    func leftButtonTapped() {
        if let delegate = delegate {
            delegate.leftButtonTapped(self)
        }
    }

    func middleButtonTapped() {
        if let delegate = delegate {
            delegate.middleButtonTapped(self)
        }
    }

    func rightButtonTapped() {
        if let delegate = delegate {
            delegate.rightButtonTapped(self)
        }
    }

    // MARK: - Public API
    func configureUI() {
        mainView.frame = CGRect(x: 0.0, y: 0.0, width: bounds.size.width, height: bounds.size.height)
        mainView.layer.cornerRadius = bounds.size.height/2
        addSubview(mainView)

        separatorOne.frame = CGRect(x: bounds.size.width/3, y: margin, width: separatorWidth, height: bounds.size.height - 2 * margin)
        addSubview(separatorOne)

        separatorTwo.frame = CGRect(x: 2 * (bounds.size.width/3), y: separatorOne.frame.origin.y, width: separatorWidth, height: separatorOne.frame.size.height)
        addSubview(separatorTwo)

        let buttonWidth = bounds.size.width/6
        let buttonHeight = bounds.size.height/2
        let buttonY = (bounds.size.height - buttonHeight)/2

        leftButton.frame = CGRect(x: (separatorOne.frame.origin.x - buttonWidth)/2, y: buttonY, width: buttonWidth, height: buttonHeight)
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        leftButton.alpha = 0.0
        addSubview(leftButton)

        middleButton.frame = CGRect(x: separatorOne.frame.origin.x + leftButton.frame.origin.x, y: buttonY, width: buttonWidth, height: buttonHeight)
        middleButton.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        middleButton.alpha = 0.0
        addSubview(middleButton)

        rightButton.frame = CGRect(x: separatorTwo.frame.origin.x + leftButton.frame.origin.x, y: buttonY, width: buttonWidth, height: buttonHeight)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.alpha = 0.0
        addSubview(rightButton)

        mainMaskView.frame = CGRect(x: (bounds.size.width - 0.5)/2, y: (bounds.size.height - 0.5)/2, width: 0.5, height: 0.5)
        mainMaskView.layer.cornerRadius = mainMaskView.frame.size.width/2
        mainMaskView.backgroundColor = maskColor
        addSubview(mainMaskView)
        mask = mainMaskView
    }

    func open() {
        UIView.animate(withDuration: animationDuration, animations: { [unowned self] in
            self.mainMaskView.transform = CGAffineTransform.init(scaleX: 2 * self.bounds.size.width, y: 2 * self.bounds.size.width)
            self.middleButton.alpha = 1.0
        }) { (completed) in
            UIView.animate(withDuration: animationDuration/2) { [unowned self] in
                self.leftButton.alpha = 1.0
                self.rightButton.alpha = 1.0
            }
        }
    }

    func close() {
        UIView.animate(withDuration: animationDuration, animations: { [unowned self] in
            self.middleButton.alpha = 0.0
            self.mainMaskView.transform = CGAffineTransform.identity
        }) { (completed) in
            UIView.animate(withDuration: animationDuration/2) { [unowned self] in
                self.leftButton.alpha = 0.0
                self.rightButton.alpha = 0.0
            }
        }
    }

}
