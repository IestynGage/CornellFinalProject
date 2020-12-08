//  DetailedViewController.swift
//  NewsApp
//
//  Created by Iestyn Gage on 17/11/2020.
//

import UIKit

class DetailedViewController: UIViewController {

//  MARK: Variables
    var article: Article = Article(title: "Empty", url: "http://www.google.com", abstract: "Empty Abstract String")

//  MARK: UI Elements

    var headlineUILabel: UILabel!
    var articleSnippetTextView: UITextView!
    var articleImage: UIImageView!
    var linkButton: UIButton!

//  MARK: Initalizer

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(article:Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headlineUILabel = UILabel()
        headlineUILabel.text = article.title
        headlineUILabel.lineBreakMode = .byWordWrapping
        headlineUILabel.numberOfLines = 0
        headlineUILabel.textAlignment = .center
        headlineUILabel.font = UIFont.boldSystemFont(ofSize: 21)
        headlineUILabel.translatesAutoresizingMaskIntoConstraints = false

        articleImage = UIImageView()
       // if(article.imageURL.count>0){
            let url = URL(string: "https://static01.nyt.com/images/2020/11/19/world/19virus-hk-hygiene03/19virus-hk-hygiene03-thumbStandard.jpg")!
            //articleImage.displayImageURL(url: url)
            articleImage.translatesAutoresizingMaskIntoConstraints = false
       // }

        articleSnippetTextView = UITextView()
        articleSnippetTextView.text = article.abstract
        articleSnippetTextView.isScrollEnabled = false
        articleSnippetTextView.isEditable = false
        articleSnippetTextView.backgroundColor = .red
        articleSnippetTextView.translatesAutoresizingMaskIntoConstraints = false

        linkButton = UIButton()
        linkButton.setTitle("Read More", for: .normal)
        linkButton.setTitleColor(.white, for: .normal)
        linkButton.backgroundColor = .blue
        linkButton.addTarget(self, action: #selector(readMoreButton), for: .touchUpInside)
        linkButton.translatesAutoresizingMaskIntoConstraints = false


        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favourite", style: .plain, target: self, action: #selector(favourite))

        view.addSubview(articleImage)
        view.addSubview(linkButton)
        view.addSubview(headlineUILabel)
        view.addSubview(articleSnippetTextView)
        view.backgroundColor = .white
        setupContraints()
    }

//  MARK: Button Functions

    @objc
    func favourite(){
        let encorder = JSONEncoder()
        let decoder = JSONDecoder()

        if let FavouriteArticles = UserDefaults.standard.data(forKey: UserDefaultKey.articles){
            if var articles = try? decoder.decode(Set<Article>.self, from: FavouriteArticles) {
                if(!articles.contains(article)){
                    print("added")
                    print(articles.count)
                    articles.insert(article)
                    if let encodedObject = try? encorder.encode(articles){
                        UserDefaults.standard.set(encodedObject, forKey: UserDefaultKey.articles)
                    }
                } else {
                    print("Removed")
                    articles.remove(article)
                    if let encodedObject = try? encorder.encode(articles){
                        UserDefaults.standard.set(encodedObject, forKey: UserDefaultKey.articles)
                    }
                }
            }
        } else {
            let newArticle:Set<Article> = [article]
            if let encodedObject = try? encorder.encode(newArticle){
                UserDefaults.standard.set(encodedObject, forKey: UserDefaultKey.articles)
            }
        }

    }

    @objc
    func readMoreButton(){
        let urlComponents = URLComponents (string: article.url)!
        UIApplication.shared.open (urlComponents.url!)
    }

//  MARK: Constraints

    func setupContraints() {
        NSLayoutConstraint.activate([
            articleImage.topAnchor.constraint(equalTo: headlineUILabel.bottomAnchor, constant: 20),
            articleImage.bottomAnchor.constraint(equalTo: articleSnippetTextView.topAnchor, constant: -10),
            articleImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            articleImage.heightAnchor.constraint(equalToConstant: 100)
            //articleImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            articleSnippetTextView.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 20),
            articleSnippetTextView.bottomAnchor.constraint(equalTo: linkButton.topAnchor, constant: -10),
            articleSnippetTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            articleSnippetTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            linkButton.topAnchor.constraint(equalTo: articleSnippetTextView.bottomAnchor, constant: 16),
            //linkButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            linkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
  //          linkButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension UIImageView {
    func displayImageURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
