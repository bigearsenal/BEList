//
//  HeaderView.swift
//  BEListDemo
//
//  Created by Chung Tran on 19/08/2022.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Text("My Wallet")
                .font(.system(size: 50))
            HStack {
                Button {
                    print("Edit button was tapped")
                } label: {
                    VStack {
                        Image(systemName: "plus").resizable().frame(width: 20, height: 20, alignment: .center)
                        Text("Buy")
                    }
                    .aspectRatio(contentMode: .fill)
                }.frame(minWidth: 0, maxWidth: .infinity)
                Button {
                    print("Edit button was tapped")
                } label: {
                    VStack {
                        Image(systemName: "arrow.up").resizable().frame(width: 20, height: 20, alignment: .center)
                        Text("Send")
                    }
                    .aspectRatio(contentMode: .fill)
                }.frame(minWidth: 0, maxWidth: .infinity)
                Button {
                    print("Edit button was tapped")
                } label: {
                    VStack {
                        Image(systemName: "arrow.down").resizable().frame(width: 20, height: 20, alignment: .center)
                        Text("Receive")
                    }
                    .aspectRatio(contentMode: .fill)
                }.frame(minWidth: 0, maxWidth: .infinity)
                Button {
                    print("Edit button was tapped")
                } label: {
                    VStack {
                        Image(systemName: "arrow.left.arrow.right").resizable().frame(width: 20, height: 20, alignment: .center)
                        Text("Swap")
                    }
                    .aspectRatio(contentMode: .fill)
                }.frame(minWidth: 0, maxWidth: .infinity)
            }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
