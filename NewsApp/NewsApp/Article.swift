//
//  Article.swift
//  NewsApp
//
//  Created by Iestyn Gage on 18/11/2020.
//

import Foundation

struct Article: Codable, Hashable {
    var title:String
    var url:String
    var abstract:String
    //var media:[String]
}

struct media: Codable {
    var mediaMetaDate:[image]

}

struct image: Codable {
    var url: String
}

struct ArticlesResponse: Codable {
    var status:String
    var results:[Article]
}

struct SearchResult: Codable {
    var response:searchResponse
    var status: String
}

struct searchResponse:Codable {
    var docs:[searchArticle]
}

struct searchArticle: Codable {
//    var title:String
    var web_url:String
    var abstract:String
}
