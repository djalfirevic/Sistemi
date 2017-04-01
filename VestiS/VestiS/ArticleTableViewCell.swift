//
//  ArticleTableViewCell.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/29/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var portalLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    var article: Article! {
        didSet {
            titleLabel.text = article.title
            portalLabel.text = article.portal
            coverImageView.layer.cornerRadius = coverImageView.frame.size.width/2
            coverImageView.layer.masksToBounds = true
            coverImageView.loadImage(from: article.imageUrl)
        }
    }

}
