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
                        Text(sectionIndex == 0 ? "SPL Tokens": sectionIndex == 1 ? "Hidden tokens": "NFTs").font(.title).padding()
                        Spacer()
                    }
                },
                onEmptyView: {Text(sectionIndex < 2 ? "No tokens found": "No NFT found")},
                onLoadingView: { ProgressView() },
                onErrorView: {_ in
                    HStack {
                        Text("Something went wrong, please try again later")
                            .foregroundColor(.red)
                        Button {
                            sectionIndex < 2 ? viewModel.cryptoCurrenciesViewModel.reload(): viewModel.nftsViewModel.reload()
                        } label: {
                            Text("Retry")
                        }
                    }
                }
            ) { index, item -> AnyView in
                if let crypto = item as? CryptoCurrency {
                    return AnyView(
                        CryptoCurrencyView(item: crypto)
                            .onTapGesture {
                                print(crypto)
                            }
                    )
                } else {
                    return AnyView(
                        NFTView(nft: item as! NFT)
                            .onTapGesture {
                                print(item)
                            }
                    )
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
