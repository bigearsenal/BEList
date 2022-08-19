//
//  ContentView.swift
//  BEListDemo
//
//  Created by Chung Tran on 18/08/2022.
//

import SwiftUI
import BEList
import Combine

@MainActor
class ContentViewModel: ObservableObject, BEListViewModelType {
    private let cryptoCurrenciesViewModel = CryptoCurrenciesViewModel()
    
    var sectionsPublisher: AnyPublisher<[BESectionData], Never> {
        
        let cryptoCurrencySectionsPublisher = Publishers.CombineLatest(
            cryptoCurrenciesViewModel.$state,
            cryptoCurrenciesViewModel.$data
        )
            .map { state, data -> BESectionData in
                .init(state: state, items: data, error: state == .error ? "Something went wrong": nil)
            }
        
        return cryptoCurrencySectionsPublisher.map {[$0]}
            .eraseToAnyPublisher()
    }
    
    func reload() {
        cryptoCurrenciesViewModel.reload()
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        self.viewModel = viewModel
        viewModel.reload()
    }
    
    var body: some View {
        BEList(
            viewModel: viewModel,
            headerView: { // Optional, can be omited
                HeaderView()
            },
            footerView: { // Optional, can be omited
                Text("End of list")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        ) { sectionIndex, sectionData in
            BESection(
                data: sectionData,
                onEmptyView: {Text("No friend found")},
                onLoadingView: {Text("Loading...")},
                onErrorView: {_ in
                    Text("Something went wrong, please try again later")
                    .foregroundColor(.red)
                }
            ) { item in
                CryptoCurrencyView(item: item as! CryptoCurrency)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
