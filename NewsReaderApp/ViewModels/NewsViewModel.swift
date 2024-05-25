//
//  NewsViewModel.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import Foundation
import Combine
import CoreData

class NewsViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var bookmarkedArticles = [ArticleEntity]()
    @Published var selectedCategory = "general"
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private var context: NSManagedObjectContext {
        CoreDataServices.shared.context
    }
    
    init() {
        fetchArticles()
        fetchBookmarkedArticles()
    }
    
    func fetchArticles() {
        NewsService.shared.fetchArticles(for: selectedCategory)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Failed to fetch articles: \(error)")
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { articles in
                self.articles = articles
            })
            .store(in: &cancellables)
    }
    
    func fetchBookmarkedArticles() {
        let fetchRequest: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        do {
            bookmarkedArticles = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch bookmarked articles: \(error)")
            errorMessage = error.localizedDescription
        }
    }
    
    func bookmark(article: Article) {
        if !bookmarkedArticles.contains(where: { $0.id == article.id }) {
            let bookmarkedArticle = ArticleEntity(context: context)
            bookmarkedArticle.id = article.id
            bookmarkedArticle.title = article.title
            bookmarkedArticle.content = article.content
            bookmarkedArticle.descriptions = article.description
            bookmarkedArticle.url = article.url
            bookmarkedArticle.urlToImage = article.urlToImage
            bookmarkedArticle.publishedAt = article.publishedAt
            bookmarkedArticle.createdAt = Date()
            do {
                try context.save()
                bookmarkedArticles.append(bookmarkedArticle)
            } catch {
                print("Failed to save bookmark: \(error)")
                errorMessage = error.localizedDescription
            }
        }
    }
}
