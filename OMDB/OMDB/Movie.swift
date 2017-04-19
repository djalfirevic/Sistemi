//
//  Movie.swift
//  OMDB
//
//  Created by Djuro Alfirevic on 4/19/17.
//  Copyright © 2017 Sistemi. All rights reserved.
//

import Foundation

struct Movie {

    // MARK: - Properties
    var poster = ""
    var title = ""
    var year = ""
    var actors = ""
    var director = ""
    var awards = ""

    // MARK: - Initializer
    init(json: [String: Any]) {
        if let poster = json["Poster"] as? String {
            self.poster = poster
        }

        if let title = json["Title"] as? String {
            self.title = title
        }

        if let year = json["Year"] as? String {
            self.year = year
        }

        if let actors = json["Actors"] as? String {
            self.actors = actors
        }

        if let director = json["Director"] as? String {
            self.director = director
        }

        if let awards = json["Awards"] as? String {
            self.awards = awards
        }
    }

}
