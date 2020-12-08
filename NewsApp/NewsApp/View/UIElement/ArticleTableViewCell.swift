//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Iestyn Gage on 19/11/2020.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    var articleLabel:UILabel!
    
    let padding: CGFloat = 8

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        articleLabel = UILabel()
        articleLabel.font = UIFont.systemFont(ofSize: 18)
        articleLabel.lineBreakMode = .byWordWrapping
        articleLabel.numberOfLines = 0
        articleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(articleLabel)

        setupContraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(for article: Article){
        articleLabel.text = article.title
    }

    func setupContraints(){
        NSLayoutConstraint.activate([
            articleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            articleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            articleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            articleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 10)
        ])
    }
}
