//
//  ViewController.swift
//  OMDB
//
//  Created by Djuro Alfirevic on 4/19/17.
//  Copyright © 2017 Sistemi. All rights reserved.
//

import UIKit

let kBaseURL = "http://www.omdbapi.com/?t="

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var items = [String]()

    // MARK: - Private API
    fileprivate func search(_ term: String) {
        // Grab JSON from OMDB database.
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: "\(kBaseURL)\(term)") {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [unowned self] in
                        // Parsing JSON.
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                            if let json = json {
                                self.searchBar.text = ""

                                self.openMovie(Movie(json: json))
                            }
                        } catch {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }

    fileprivate func openMovie(_ movie: Movie) {
        let movieViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieViewController") as! MovieViewController
        movieViewController.movie = movie
        navigationController?.pushViewController(movieViewController, animated: true)
    }

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!

        cell.textLabel?.text = items[indexPath.row]

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        search(items[indexPath.row])
    }

}

extension ViewController: UISearchBarDelegate {

    // MARK: - UISearchBarDelegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if !text.isEmpty {
                // Appen term to items.
                items.append(text)
                items.sort()

                tableView.reloadData()

                search(text)
            }
        }
    }


}
