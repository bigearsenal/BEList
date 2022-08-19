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

class CryptoCurrenciesViewModel: BECollectionViewModel<CryptoCurrency> {
    enum Error: Swift.Error {
        case unknown
    }
    
    override func createRequest() async throws -> [CryptoCurrency] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let result = Int.random(in: 0..<10)
        if result == 0 {
            return []
        } else if result == 1 {
            throw Error.unknown
        } else {
            return [
                .init(name: "Bitcoin", symbol: "BTC", price: 24900, amount: .random(in: 0..<1)),
                .init(name: "Etherum", symbol: "ETH", price: 2000, amount: .random(in: 1..<10)),
                .init(name: "Solana", symbol: "SOL", price: 100, amount: .random(in: 300..<400)),
                .init(name: "Serum", symbol: "SRM", price: 1, amount: .random(in: 1..<10)),
                .init(name: "Crycoin", symbol: "CRYY", price: 1, amount: .random(in: 1..<10)),
                .init(name: "Dogecoin", symbol: "DOGE", price: 1, amount: .random(in: 1..<10)),
                .init(name: "Shiba INU", symbol: "SHIB", price: 1, amount: .random(in: 1..<10)),
                .init(name: "Lido DAO", symbol: "LDO", price: 3, amount: .random(in: 1..<10))
            ]
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
