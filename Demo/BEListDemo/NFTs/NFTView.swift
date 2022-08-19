//
//  NFTView.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import SwiftUI

struct NFTView: View {
    let nft: NFT
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Rectangle().aspectRatio(contentMode: .fill)
                Spacer()
            }
            Text(nft.name)
        }
    }
}

struct NFTView_Previews: PreviewProvider {
    static var previews: some View {
        NFTView(nft: .init(name: "Angry dog"))
    }
}
