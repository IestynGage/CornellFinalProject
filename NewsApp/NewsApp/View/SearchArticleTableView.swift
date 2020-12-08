//
//  SearchArticleTableView.swift
//  NewsApp
//
//  Created by Iestyn Gage on 17/11/2020.
//

import UIKit

class SearchArticleTableView: UIViewController {

    var articles = [searchArticle]()

    var tableView: UITableView!
    var searchBar: UISearchBar!

    let reuseIdentifier = "articleCellReuse"

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.showsScopeBar = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search Here....."
        searchBar.sizeToFit()

        tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.tableHeaderView = searchBar
        view.addSubview(tableView)

        setupConstraints()
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchArticleTableView: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("ExtDidBeginEditing")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Text Did end Editing")
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        RestAPI.searchArticles(search: searchBar.text!,completion:{articles in
            print("")
            articles.forEach{article in
                print(article.abstract)
            }
            self.articles = articles
            self.tableView.reloadData()
        })
        searchBar.resignFirstResponder()
    }
}

extension SearchArticleTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticleTableViewCell
        let searchArticle = articles[indexPath.row]
        let article = Article(title: searchArticle.abstract, url: searchArticle.web_url, abstract: searchArticle.abstract)
        cell.configure(for: article)
        cell.selectionStyle = .none
        return cell
    }


}

extension SearchArticleTableView: UITableViewDelegate {

}

