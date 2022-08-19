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
    @ObservedObject var viewModel: FriendsViewModel
    
    init(viewModel: FriendsViewModel) {
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
                onErrorView: {_ in
                    Text("Something went wrong, please try again later")
                    .foregroundColor(.red)
                }
            ) { item in
                Text((item as! Friend).name)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
