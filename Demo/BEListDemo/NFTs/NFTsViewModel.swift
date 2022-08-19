//
//  NFTsViewModel.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import Foundation
import BEList
import Combine
import SwiftUI

class NFTsViewModel: BECollectionViewModel<NFT> {
    enum Error: Swift.Error {
        case unknown
    }
    
    override func createRequest() async throws -> [NFT] {
        try await Task.sleep(nanoseconds: Bool.random() ? 1_000_000_000: 2_000_000_000)
        let result = Int.random(in: 0..<10)
        if result == 0 {
            return []
        } else if result == 1 {
            throw Error.unknown
        } else {
            return [
                .init(name: "Angry dog"),
                .init(name: "Smiled dog"),
                .init(name: "Normal dog"),
                .init(name: "Faking dog"),
                .init(name: "Smoking dog"),
                .init(name: "Walking dog"),
                .init(name: "fun dog"),
                .init(name: "some dog")
            ]
        }
    }
}
