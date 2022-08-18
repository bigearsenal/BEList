import Foundation
import SwiftUI

/// Generic section type
public protocol BESectionType {
    var anyView: AnyView {get}
}

extension BESection: BESectionType {
    public var anyView: AnyView {
        AnyView(body)
    }
}

/// Default implementation for BESectionType
public struct BESection<
    HeaderView: View,
    CellView: View,
    OnEmptyView: View,
    OnLoadingView: View,
    FooterView: View
>: View {
    
    // MARK: - Public properties
    
    /// The info of the section
    public let data: BESectionData
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: () -> HeaderView
    
    /// Optional: Builder for ListView when data is empty
    @ViewBuilder public var onEmptyView: () -> OnEmptyView
    
    /// Optional: Builder for ListView when data is loading
    @ViewBuilder public var onLoadingView: () -> OnLoadingView // Optional
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: () -> FooterView
    
    /// Builder for each cell of the section
    public let cellBuilder: (AnyHashable) -> CellView
    
    // MARK: - Initializer
    public init(
        data: BESectionData,
        headerView: @escaping () -> HeaderView,
        onEmptyView: @escaping () -> OnEmptyView,
        onLoadingView: @escaping () -> OnLoadingView,
        footerView: @escaping () -> FooterView,
        cellBuilder: @escaping (AnyHashable) -> CellView
    ) {
        self.data = data
        self.headerView = headerView
        self.onEmptyView = onEmptyView
        self.onLoadingView = onLoadingView
        self.footerView = footerView
        self.cellBuilder = cellBuilder
    }
    
    /// Body of the section
    public var body: some View {
        Group {
            if data.state == .loaded && data.items.isEmpty {
                onEmptyView()
            } else {
                // all items
                ForEach(data.items, id: \.hashValue) { item in
                    cellBuilder(item)
                }
                
                // loading
                if data.state == .loading || data.state == .initializing {
                    onLoadingView()
                }
            }
        }
    }
}

// MARK: - Overload initializers

extension BESection where HeaderView == EmptyView {
    /// Overload initializer to support optional HeaderView
    public init(
        data: BESectionData,
        onEmptyView: @escaping () -> OnEmptyView,
        onLoadingView: @escaping () -> OnLoadingView,
        footerView: @escaping () -> FooterView,
        cellBuilder: @escaping (AnyHashable) -> CellView
    ) {
        self.init(
            data: data,
            headerView: { EmptyView() },
            onEmptyView: onEmptyView,
            onLoadingView: onLoadingView,
            footerView: footerView,
            cellBuilder: cellBuilder
        )
    }
}

extension BESection where FooterView == EmptyView {
    /// Overload initializer to support optional FooterView
    public init(
        data: BESectionData,
        headerView: @escaping () -> HeaderView,
        onEmptyView: @escaping () -> OnEmptyView,
        onLoadingView: @escaping () -> OnLoadingView,
        cellBuilder: @escaping (AnyHashable) -> CellView
    ) {
        self.init(
            data: data,
            headerView: headerView,
            onEmptyView: onEmptyView,
            onLoadingView: onLoadingView,
            footerView: { EmptyView() },
            cellBuilder: cellBuilder
        )
    }
}

extension BESection where HeaderView == EmptyView, FooterView == EmptyView {
    /// Overload initializer to support optional HeaderView & FooterView
    public init(
        data: BESectionData,
        onEmptyView: @escaping () -> OnEmptyView,
        onLoadingView: @escaping () -> OnLoadingView,
        cellBuilder: @escaping (AnyHashable) -> CellView
    ) {
        self.init(
            data: data,
            headerView: { EmptyView() },
            onEmptyView: onEmptyView,
            onLoadingView: onLoadingView,
            footerView: { EmptyView() },
            cellBuilder: cellBuilder
        )
    }
}
