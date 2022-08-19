//
//  FriendsViewModel.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import Foundation
import BEList
import Combine
import SwiftUI

class FriendsViewModel: BECollectionViewModel<Friend>, BEListViewModelType {
    enum Error: Swift.Error {
        case unknown
    }
    
    override func createRequest() async throws -> [Friend] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let result = Int.random(in: 0..<10)
        if result == 0 {
            return []
        } else if result == 1 {
            throw Error.unknown
        } else {
            return Array(0..<Int.random(in: 5..<1000)).map {.init(name: "Friend #\($0 + 1)")}
        }
    }
    
    var sectionsPublisher: AnyPublisher<[BESectionData], Never> {
        Publishers.CombineLatest($state, $data)
            .map { state, data -> [BESectionData] in
                let sections = data.chunked(into: 10).enumerated()
                    .map { index, data -> BESectionData in
                        .init(
                            layoutType: index % 2 == 0 ? .lazyVStack: .lazyVGrid(columns: [
                                GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude)),
                                GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude)),
                                GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude))
                            ]),
                            state: state,
                            items: data,
                            error: state == .error ? "Something went wrong": nil
                        )
                    }
                
                if sections.isEmpty {
                    return [
                        .init(state: state, items: data, error: state == .error ? "Something went wrong": nil)
                    ]
                }
                
                return sections.reduce([], {$0 + [$1]})
            }
            .eraseToAnyPublisher()
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
