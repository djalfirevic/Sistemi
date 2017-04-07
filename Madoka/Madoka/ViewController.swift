//
//  ViewController.swift
//  Madoka
//
//  Created by Djuro Alfirevic on 4/7/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}
