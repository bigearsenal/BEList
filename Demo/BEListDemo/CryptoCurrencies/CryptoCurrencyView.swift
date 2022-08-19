//
//  CryptoCurrencyView.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import SwiftUI

struct CryptoCurrencyView: View {
    let item: CryptoCurrency
    var body: some View {
        HStack {
            Rectangle().frame(width: 50, height: 50, alignment: .top)
            VStack(alignment: .leading) {
                Text(item.name)
                Text(item.symbol).font(.caption).foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(item.price ?? 0)$")
                Text("\(item.amount ?? 0) \(item.symbol)").font(.caption).foregroundColor(.gray)
            }
        }
        .padding(.horizontal)
    }
}

struct CryptoCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CryptoCurrencyView(item: .init(name: "Bitcoin", symbol: "BTC", price: 24900, amount: 1))
    }
}
