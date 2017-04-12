//
//  ViewController.swift
//  ThirdParty
//
//  Created by Djuro Alfirevic on 4/12/17.
//  Copyright © 2017 Symphony. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Spring

class ViewController: UIViewController {

    // MARK: - Actions
    @IBAction func facebookButtonTapped() {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email", "user_friends", "user_birthday"], from: self) { (result, error) in

            if let error = error {
                print("Facebook login error: \(error.localizedDescription)")
            }

            if let result = result {
                if !result.isCancelled {

                    let parameters = ["fields": "first_name, last_name, gender, email, picture.type(large), birthday"]

                    // Get user information
                    FBSDKGraphRequest(graphPath: "me", parameters: parameters).start(completionHandler: { (connection, result, error) in
                        print(result)
                    })
                }
            }
        }
    }

}

