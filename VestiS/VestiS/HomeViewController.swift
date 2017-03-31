//
//  HomeViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/29/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var articles = [Article]()

    // MARK: - Public API
    func loadArticles() {
        guard isConnected() else {
            return
        }

        if let url = URL(string: apiUrl) {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            session.dataTask(with: url, completionHandler: { (data, response, error) in

                if error != nil {
                    print("Error: \(error!.localizedDescription)")
                }

                if data != nil {

                }
            })
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        loadArticles()
    }

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
