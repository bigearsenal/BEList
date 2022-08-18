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
        BEList(
            viewModel: viewModel,
            headerView: { // Optional, can be omited
                Text("My friends")
                    .font(.system(size: 50))
                
            },
            footerView: { // Optional, can be omited
                Text("All: \(viewModel.data.count) friend(s)")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
        ) { sectionIndex, sectionData in
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
        let result = Int.random(in: 0..<10)
        if result == 0 {
            return []
        } else if result == 1 {
            throw Error.unknown
        } else {
            return ["Ty", "Phi", "Tai", "Long"] + Array(5..<Int.random(in: 6..<9)).map {"Friend #\($0)"}
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
