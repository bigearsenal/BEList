//
//  ContentView.swift
//  BEListDemo
//
//  Created by Chung Tran on 18/08/2022.
//

import SwiftUI
import BEList
import Combine

struct ContentView: View {
    @ObservedObject var viewModel: MockViewModel
    
    init(viewModel: MockViewModel) {
        self.viewModel = viewModel
        viewModel.reload()
    }
    
    var body: some View {
        BEList(viewModel: viewModel) { sectionIndex, sectionData in
            BESection(
                data: sectionData,
                onEmptyView: {Text("No friend found")},
                onLoadingView: {Text("Loading...")},
                onErrorView: {_ in Text("Something went wrong, please try again later")})
            { item -> Text in
                let text = item as! String
                return Text(text)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}

class MockViewModel: BECollectionViewModel<String>, BEListViewModelType {
    enum Error: Swift.Error {
        case unknown
    }
    
    override func createRequest() async throws -> [String] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        let result = Int.random(in: 0..<5)
        if result == 0 {
            return []
        } else if result == 1 {
            throw Error.unknown
        } else {
            return ["Ty", "Phi", "Tai", "Long"]
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
