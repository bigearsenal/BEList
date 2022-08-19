//
//  File.swift
//  
//
//  Created by Chung Tran on 19/08/2022.
//

import Foundation
import SwiftUI

struct RefreshableView<Content: View>: View {
    @Environment(\.refresh) private var refresh   // << refreshable injected !!
    @State private var isRefreshing = false
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack {
            if isRefreshing {
                ProgressView()    // ProgressView() ?? - no, it's boring :)
//                    .transition(.scale)
            }

            // simple demo card
            content()
        }
        .animation(.default, value: isRefreshing)
        .background(GeometryReader {
            // detect Pull-to-refresh
            Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
        })
        .onPreferenceChange(ViewOffsetKey.self) {
            if $0 < -80 && !isRefreshing {   // << any creteria we want !!
                isRefreshing = true
                Task {
                    await refresh?()           // << call refreshable !!
                    await MainActor.run {
                        isRefreshing = false
                    }
                }
            }
        }
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
