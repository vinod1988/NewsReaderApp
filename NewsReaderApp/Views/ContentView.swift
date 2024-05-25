//
//  ContentView.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                MainView()
            } else {
                SplashScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { 
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct MainView: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var showBookmarks = false
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        CategoryButton(category: "General", viewModel: viewModel)
                        CategoryButton(category: "Business", viewModel: viewModel)
                        CategoryButton(category: "Technology", viewModel: viewModel)
                        // Add more categories as needed
                    }
                    .padding()
                }
                
                if showBookmarks {
                    BookmarkListView(bookmarkedArticles: viewModel.bookmarkedArticles)
                } else {
                    ArticleListView(viewModel: viewModel)
                }
            }
            .navigationTitle("News")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button(action: { showBookmarks.toggle() }) {
                            Text(showBookmarks ? "Hide Bookmarks" : "Show Bookmarks")
                        }
                    } label: {
                        Text("Bookmarks")
                    }
                }
            }
            
            
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
            
            
            
        }
    }
}



struct CategoryButton: View {
    var category: String
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        Button(action: {
            viewModel.selectedCategory = category.lowercased()
            viewModel.fetchArticles()
        }) {
            Text(category)
                .padding()
                .background(viewModel.selectedCategory == category.lowercased() ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
