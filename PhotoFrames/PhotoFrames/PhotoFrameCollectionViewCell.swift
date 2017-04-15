//
//  PhotoFrameCollectionViewCell.swift
//  PhotoFrames
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class PhotoFrameCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }

}
