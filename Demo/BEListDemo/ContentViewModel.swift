//
//  ContentViewModel.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import Foundation
import BEList
import Combine
import SwiftUI

@MainActor
class ContentViewModel: ObservableObject, BEListViewModelType {
    let cryptoCurrenciesViewModel = CryptoCurrenciesViewModel()
    let nftsViewModel = NFTsViewModel()
    
    var sectionsPublisher: AnyPublisher<[BESectionData], Never> {
        
        let cryptoCurrencySectionsPublisher = Publishers.CombineLatest(
            cryptoCurrenciesViewModel.$state,
            cryptoCurrenciesViewModel.$data
        )
            .map { state, data -> BESectionData in
                .init(
                    layoutType: .lazyVStack,
                    state: state,
                    items: data,
                    error: state == .error ? "Something went wrong": nil
                )
            }
        
        let nftSectionsPublisher = Publishers.CombineLatest(
            nftsViewModel.$state,
            nftsViewModel.$data
        )
            .map { state, data -> BESectionData in
                .init(
                    layoutType: .lazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]), // 2 columns
                    state: state,
                    items: data,
                    error: state == .error ? "Something went wrong": nil
                )
            }
        
        return Publishers.CombineLatest(
            cryptoCurrencySectionsPublisher,
            nftSectionsPublisher
        )
            .map {[$0, $1]}
            .eraseToAnyPublisher()
    }
    
    func reload() {
        cryptoCurrenciesViewModel.reload()
        nftsViewModel.reload()
    }
}
