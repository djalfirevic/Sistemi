//
//  MovieViewController.swift
//  OMDB
//
//  Created by Djuro Alfirevic on 4/19/17.
//  Copyright © 2017 Sistemi. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImageFromURL(_ imageURL: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: imageURL) {
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

class MovieViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var awardsLabel: UILabel!
    var movie: Movie!

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = movie.title
        imageView.loadImageFromURL(movie.poster)
        titleLabel.text = movie.title
        yearLabel.text = movie.year
        actorsLabel.text = movie.actors
        directorLabel.text = movie.director
        awardsLabel.text = movie.awards
    }

}
