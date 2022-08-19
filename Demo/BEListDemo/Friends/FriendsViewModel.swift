//
//  FriendsViewModel.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import Foundation
import BEList
import Combine

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
            return [.init(name: "Ty"), .init(name: "Phi"), .init(name: "Tai"), .init(name: "Long")] + Array(5..<Int.random(in: 1000..<1009)).map {.init(name: "Friend #\($0))")}
        }
    }
    
    var sectionsPublisher: AnyPublisher<[BESectionData], Never> {
        Publishers.CombineLatest($state, $data)
            .map { state, data -> [BESectionData] in
                [
                    .init(state: state, items: data, error: state == .error ? "Something went wrong": nil)
                ]
            }
            .eraseToAnyPublisher()
    }
}
