//
//  File.swift
//  NewsApp
//
//  Created by Iestyn Gage on 18/11/2020.
//
// https://developer.nytimes.com/apis
//
import Foundation
import Alamofire

class RestAPI {

    // MARK: Constants

    private static let api:String = "https://api.nytimes.com"
    private static let key:String = "2vGh19pTO48GWXKB7i5K5yYLZ4H1nSya"

    // MARK: Functions

    static func getPopularArticles(completion: @escaping ([Article]) -> Void) {
        let endpoint = "\(api)/svc/mostpopular/v2/emailed/1.json?api-key=\(key)"

        AF.request(endpoint, method: .get).validate().responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let jSonDecoder = JSONDecoder()

                if let articleData = try? jSonDecoder.decode(ArticlesResponse.self, from: data){
                    print(articleData.status)
                    let articles = articleData.results
                    completion(articles)
                }
            case . failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    static func searchArticles(search: String, completion: @escaping ([searchArticle]) -> Void ){
        let endpoint = "\(api)/svc/search/v2/articlesearch.json?q=\(search)&api-key=\(key)"
        
        AF.request(endpoint, method: .get).validate().responseData(completionHandler: { response in
            switch response.result {
            case .success(let data):
                let jSonDecoder = JSONDecoder()

                if let articleData = try? jSonDecoder.decode(SearchResult.self, from: data){
                    let articles = articleData.response.docs
                    completion(articles)
                }
            case . failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
