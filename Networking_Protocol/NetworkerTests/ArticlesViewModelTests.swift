/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import XCTest
import Combine
@testable import Networker

///mock networker will implement the Networking protocol but return hard-coded values for each request
class MockNetworker: Networking {
  func fetch(_ request: Request) -> AnyPublisher<Data, URLError> {
    let outputData: Data
    switch request {
    case is ArticleRequest:
      let article = Article(name: "Article Name", description: "Article Description", image: URL(string: "https://image.com")!, id: "Article ID", downloadedImage: nil)
      let articleData = ArticleData(article: article)
      let articles = Articles(data: [articleData])
      outputData = try! JSONEncoder().encode(articles)
    default:
      outputData = Data()
    }
    return Just<Data>(outputData)
      .setFailureType(to: URLError.self)
      .eraseToAnyPublisher()
  }
}

class ArticlesViewModelTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var viewModel: ArticlesViewModel!
  var cancellables: Set<AnyCancellable> = []

  override func setUpWithError() throws {
    try super.setUpWithError()
    ///create a new view model instance and inject your stub networker
    viewModel = ArticlesViewModel(networker: MockNetworker())
  }
  
  ///verify that your view model fetches articles and decodes them correctly
  func testArticlesAreFetchedCorrectly() {
    XCTAssert(viewModel.articles.isEmpty)
    ///Expectations are used to test asynchronous code.
    ///The expectation will keep the test going until the expectation is fulfilled or a timer runs out.
    let expectation = XCTestExpectation(description: "Article received")
    ///you subscribe to changes to the articles array and wait until it’s not empty
    viewModel.$articles.sink { articles in
      guard !articles.isEmpty else { return }
      XCTAssertEqual(articles[0].id, "Article ID")
      expectation.fulfill()
    }
    .store(in: &cancellables)
    ///start the fetching and decoding process
    viewModel.fetchArticles()
    ///tell XCTest to wait for 0.1 seconds until your expectation is fulfilled
    wait(for: [expectation], timeout: 0.1)
  }
}
