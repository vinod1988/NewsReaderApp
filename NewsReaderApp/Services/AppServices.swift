//
//  AppServices.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import Foundation
import Combine

class NewsService {
    static let shared = NewsService()
    private let apiKey = "be7e668200dd43799fbd5544c1287479"
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    
    func fetchArticles(for category: String) -> AnyPublisher<[Article], Error> {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        print("Fetching articles from URL: \(url)") // Debug: Log the URL being fetched
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output in
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map { $0.articles }
            .receive(on: DispatchQueue.main)
            .print() // Debug: Print publisher events
            .eraseToAnyPublisher()
    }
}

