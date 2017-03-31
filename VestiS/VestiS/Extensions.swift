//
//  Extensions.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/31/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {

    func loadImage(from urlString: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async { [unowned self] in
                            self.image = image
                        }
                    }
                }
            }
        }
    }
    
}

extension UIViewController {

    func isConnected() -> Bool {
        if let reachability = Reachability() {
            return reachability.isReachable
        }

        return false
    }
    
}
