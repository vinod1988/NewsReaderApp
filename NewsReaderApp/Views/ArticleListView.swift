//
//  ArticleListView.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import SwiftUI

struct ArticleListView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.articles) { article in
                NavigationLink(destination: ArticleDetailView(article: article, viewModel: viewModel)) {
                    ArticleRowView(article: article)
                        .foregroundColor(.primary) // Set text color
                }
                .listRowInsets(EdgeInsets()) // Remove cell selection
                .buttonStyle(PlainButtonStyle()) // Hide the arrow and make the navigation link transparent
                .padding(.all, 8)
            }
        }
        .onAppear {
            // Apply appearance changes when the view appears
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().allowsSelection = false
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
        .listStyle(PlainListStyle()) // Remove cell separators
        .background(Color.clear) // Set list background color to clear
    }
}

struct ArticleRowView: View {
    var article: Article
    @State private var isExpanded = false // State to track whether the description is expanded
    
    var body: some View {
        VStack(spacing: 10) {
            // Image
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url,
                           placeholder: { ProgressView() },
                           image: { Image(uiImage: $0).resizable() })
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200) // Adjust height as needed
                .cornerRadius(12)
                .clipped()
            }
            
            VStack(alignment: .leading) {
                // Title
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                    .padding(.trailing, 8) // Add padding to title
            }
            
            // Description
            Text(article.description ?? "")
                .font(.subheadline)
                .lineLimit(isExpanded ? nil : 2) // Allow unlimited lines if expanded
                .padding(.bottom, 8) // Add bottom padding
            
            HStack {
                Spacer()
                
                // Read more / Less button
                Button(action: { isExpanded.toggle() }) {
                    Text(isExpanded ? "Less" : "Read more")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            
            HStack {
                Spacer()
                
                // Date
                if let publishedAt = article.publishedAt {
                    Text(publishedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .buttonStyle(PlainButtonStyle()) // Remove cell detail indicator
    }
}
