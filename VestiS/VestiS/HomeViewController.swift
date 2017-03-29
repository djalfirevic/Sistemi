//
//  HomeViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/29/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

let url = "http://www.brzevesti.net/api/news"

class HomeViewController: UIViewController {

    // MARK: - Properties
    var articles = [Article]()

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleTableViewCell
        cell.article = articles[indexPath.row]

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
