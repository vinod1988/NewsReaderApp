//
//  ArticleDetailView.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 25/05/24.
//

import SwiftUI

struct ArticleDetailView: View {
    let article: Article
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                    AsyncImage(url: url,
                               placeholder: { ProgressView() },
                               image: { Image(uiImage: $0).resizable() })
                    .aspectRatio(contentMode: .fit)
                }
                
                Text(article.content ?? "No content available")
                    .padding()
                
                Button(action: {
                    viewModel.bookmark(article: article)
                }) {
                    Text("Bookmark")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
