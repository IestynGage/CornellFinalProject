//
//  ViewController.swift
//  NewsApp
//
//  Created by Iestyn Gage on 17/11/2020.
//

import UIKit

class PopularArticleViewController: UIViewController {

    var tableView: UITableView!

    var articles: [Article]!
    let cellHeight: CGFloat = 50
    let reuseIdentifier = "articleCellReuse"

    override func viewDidLoad() {
        super.viewDidLoad()
        articles = [Article]()
        RestAPI.getPopularArticles(completion: {articles in
            self.articles = articles
            self.tableView.reloadData()
        })

        tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false

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

extension PopularArticleViewController: UITableViewDataSource {
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

extension PopularArticleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let articleVC = DetailedViewController(article: article)
        self.navigationController?.pushViewController(articleVC, animated: true)
    }
}

