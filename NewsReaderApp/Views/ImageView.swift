//
//  ImageView.swift
//  NewsReaderApp
//
//  Created by Vinod Vishwakarma on 23/05/24.
//
import SwiftUI
import Combine

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        self._loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if let uiImage = loader.image {
                image(uiImage)
            } else {
                placeholder
            }
        }
    }
}

private class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}
