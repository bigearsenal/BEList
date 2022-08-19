//
//  ContentView.swift
//  BEListDemo
//
//  Created by Chung Tran on 18/08/2022.
//

import SwiftUI
import BEList

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
                headerView: { // Optional, can be omited
                    HStack {
                        Text(sectionIndex == 0 ? "SPL Tokens": "NFTs").font(.title).padding()
                        Spacer()
                    }
                },
                onEmptyView: {Text(sectionIndex == 0 ? "No tokens found": "No NFT found")},
                onLoadingView: {Text("Loading...")},
                onErrorView: {_ in
                    Text("Something went wrong, please try again later")
                    .foregroundColor(.red)
                }
            ) { index, item -> AnyView in
                if let crypto = item as? CryptoCurrency {
                    return AnyView(CryptoCurrencyView(item: crypto))
                } else {
                    return AnyView(NFTView(nft: item as! NFT))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
