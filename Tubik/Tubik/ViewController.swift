//
//  ViewController.swift
//  Tubik
//
//  Created by Djuro Alfirevic on 4/8/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tubikView: TubikView!

    // MARK: - Actions
    @IBAction func openButtonTapped() {
        tubikView.open()
    }

    @IBAction func closeButtonTapped() {
        tubikView.close()
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tubikView.delegate = self
    }

}

extension ViewController: TubikViewDelegate {

    // MARK: - TubikViewDelegate
    func leftButtonTapped(_ tubikView: TubikView) {
        print("left")
    }

    func middleButtonTapped(_ tubikView: TubikView) {
        print("middle")
    }

    func rightButtonTapped(_ tubikView: TubikView) {
        print("right")
    }

}
