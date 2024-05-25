//
//  BookMarkListView.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 25/05/24.
//

import SwiftUI

struct BookmarkListView: View {
    var bookmarkedArticles: [ArticleEntity]
    
    var body: some View {
        List(bookmarkedArticles) { article in
            VStack(alignment: .leading) {
                Text(article.title ?? "")
                    .font(.headline)
                Text(article.content ?? "")
                    .font(.subheadline)
                    .lineLimit(3)
            }
        }
    }
}
