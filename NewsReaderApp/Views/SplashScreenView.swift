//
//  SplashScreenView.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            Text("Welcome to Star News")
                .font(.headline)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding(.top, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SplashScreenView()
}
