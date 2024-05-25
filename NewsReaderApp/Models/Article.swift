//
//  Article.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}


struct Article: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String?
    let content: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: Source?
    
    struct Source: Codable {
        let id:String?
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case content
        case url
        case urlToImage
        case publishedAt
        case source
    }
}

