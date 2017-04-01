//
//  HomeViewController.swift
//  VestiS
//
//  Created by Djuro Alfirevic on 3/29/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var articles = [Article]()

    // MARK: - Public API
    func loadArticlesWithSwiftyJSON() {
        guard isConnected() else {
            return
        }

        if let url = URL(string: apiUrl) {
            let configuration = URLSessionConfiguration.default
            let request = URLRequest(url: url)
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: request, completionHandler: { [unowned self] (data, response, error) in

                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }

                if let data = data {
                    let json = JSON(data)

                    DispatchQueue.main.async { [unowned self] in
                        if let news = json["news"].array {
                            for newsJson in news {
                                let article = Article(with: newsJson)
                                self.articles.append(article)
                            }

                            self.tableView.reloadData()
                        }
                    }
                }
            })
            
            task.resume()
        }
    }

    func loadArticles() {
        guard isConnected() else {
            return
        }

        if let url = URL(string: apiUrl) {
            let configuration = URLSessionConfiguration.default
            let request = URLRequest(url: url)
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: request, completionHandler: { [unowned self] (data, response, error) in

                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }

                if let data = data {
                    // try, try?, try!

                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        self.parseArticles(json: json)
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            })

            task.resume()
        }
    }

    func parseArticles(json: [String: Any]?) {
        guard let json = json else {
            return
        }

        DispatchQueue.main.async { [unowned self] in
            if let news = json["news"] as? [[String: Any]] {
                for newsJson in news {
                    let article = Article(with: newsJson)
                    self.articles.append(article)
                }

                self.tableView.reloadData()
            }
        }
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        //loadArticles()
        loadArticlesWithSwiftyJSON()
    }

    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }

        let article = articles[indexPath.row]

        // 1. version.
        if segue.destination is WebViewController {
            let toViewController = segue.destination as! WebViewController
            toViewController.urlString = article.url
        }

        // 2. version.
        if let toViewController = segue.destination as? WebViewController {
            toViewController.urlString = article.url
        }
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
