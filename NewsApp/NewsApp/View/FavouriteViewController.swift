//
//  FavouriteViewController.swift
//  NewsApp
//
//  Created by Iestyn Gage on 17/11/2020.
//

import UIKit

class FavouriteViewController: UIViewController {

    var tableView: UITableView!

    var articles: [Article]!
    let cellHeight: CGFloat = 50
    let reuseIdentifier = "articleCellReuse"

    override func viewDidLoad() {
        super.viewDidLoad()

        articles = loadSavedArticles()

        tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)

        setupConstraints()
    }


    func loadSavedArticles() -> [Article]{
        articles = [Article]()

        let decoder = JSONDecoder()

        if let FavouriteArticles = UserDefaults.standard.data(forKey: UserDefaultKey.articles){
            if let savedArticles = try? decoder.decode(Set<Article>.self, from: FavouriteArticles) {
                return Array(savedArticles)
            }
        }
        return articles
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        articles = loadSavedArticles()
        print(articles.count)
        tableView.reloadData()
    }
}



extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.configure(for: article)
        cell.selectionStyle = .none
        return cell
    }
}

extension FavouriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        let article = articles[indexPath.row]
        let articleVC = DetailedViewController(article: article)
        self.navigationController?.pushViewController(articleVC, animated: true)

    }

}

