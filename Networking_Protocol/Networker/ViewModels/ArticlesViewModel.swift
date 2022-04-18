/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
  
  private var networker: Networking
  
  @Published private(set) var articles: [Article] = []
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(networker: Networking) {
    self.networker = networker
  }
  
  func fetchArticles() {
    let request = ArticleRequest()
    networker.fetch(request)
      .tryMap([Article].init)
      .replaceError(with: [])
      .receive(on: DispatchQueue.main)
      .assign(to: \.articles, on: self)
      .store(in: &cancellables)
  }
  
  func fetchImage(for article: Article) {
    guard article.downloadedImage == nil,
          let articleIndex = articles.firstIndex(where: { $0.id == article.id})
    else {
      return
    }
    
    let request = ImageRequest(url: article.image)
    networker.fetch(request)
      .map(UIImage.init)
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .sink { [weak self] image in
        self?.articles[articleIndex].downloadedImage = image
      }
      .store(in: &cancellables)
  }
}
