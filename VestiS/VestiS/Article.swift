//
//  Article.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/29/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import Foundation
import SwiftyJSON

class Article {

    // MARK: - Properties
    var title = ""
    var description = ""
    var imageUrl = ""
    var portal = ""
    var url = ""
    var region = ""

    // MARK: - Public API
    func text(for key: String, in json: [String: Any]) -> String {
        if let text = json[key] as? String {
            return text
        }

        return ""
    }

    // MARK: - Initializers
    init(with json: [String: Any]) {
        title = text(for: "title", in: json)
        description = text(for: "description", in: json)
        imageUrl = text(for: "imageUrl", in: json)
        portal = text(for: "portal", in: json)
        url = text(for: "url", in: json)
        region = text(for: "region", in: json)
    }

    init(with json: JSON) {
        title = json["title"].string ?? ""
        description = json["description"].string ?? ""
        imageUrl = json["imageUrl"].string ?? ""
        portal = json["portal"].string ?? ""
        url = json["url"].string ?? ""
        region = json["region"].string ?? ""
    }

}
