//
//  ContentDataSource.swift
//  Flowerdex
//
//  Created by Víctor A. Hernández on 11/12/20.
//

import Foundation
import Combine
// TAKEN FROM https://www.donnywals.com/implementing-an-infinite-scrolling-list-with-swiftui-and-combine/

/*
class ContentDataSource: ObservableObject {
  @Published var items = [Flower]() // ListItem
  @Published var isLoadingPage = false
  private var currentPage = 1
  private var canLoadMorePages = true

  init() {
    print("More 0")
    loadMoreContent()
  }

  func loadMoreContentIfNeeded(currentItem item: FlowerItem?) {
    guard let item = item else {
        print("More 1")
      loadMoreContent()
      return
    }

    let thresholdIndex = items.index(items.endIndex, offsetBy: -5)
    if items.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
        print("More 2")
      loadMoreContent()
    }
  }

  private func loadMoreContent() {
    guard !isLoadingPage && canLoadMorePages else {
        print("Terminate \(isLoadingPage) \(canLoadMorePages)")
        return
    }

    isLoadingPage = true

    let url = URL(string: "https://trefle.io/api/v1/plants/?token=hg6M-l4XhrgVgn2A-qZC6KKMrVPMUuCffVfDgDPtc0I&page=\(currentPage)")!
    // https://s3.eu-west-2.amazonaws.com/com.donnywals.misc/feed-\(currentPage).json
    URLSession.shared.dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: TrefleResponseModel.self, decoder: JSONDecoder()) // ListResponse.self
      .receive(on: DispatchQueue.main)
      .handleEvents(receiveOutput: { response in
        print("Called, \(response.links!["self"] != response.links!["last"])")
        self.canLoadMorePages = (response.links!["self"] != response.links!["last"]) // response.hasMorePages
        self.isLoadingPage = false
        self.currentPage += 1
      })
      .map({ response in
        return self.items + response.data! // response.items
      })
      .catch({ _ in
        return Just(self.items)
      })
      .assign(to: &$items)
  }
}
*/
