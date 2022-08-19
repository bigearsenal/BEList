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
    OnErrorView: View,
    FooterView: View
>: View {
    
    // MARK: - Public properties
    /// Item's index type
    public typealias ItemIndex = Int
    
    /// The info of the section
    public let data: BESectionData
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: () -> HeaderView
    
    /// Optional: Builder for ListView when data is empty
    @ViewBuilder public var onEmptyView: () -> OnEmptyView
    
    /// Optional: Builder for ListView when data is loading
    @ViewBuilder public var onLoadingView: () -> OnLoadingView
    
    /// Optional: Builder for ListView when error occur
    @ViewBuilder public let onErrorView: (AnyHashable) -> OnErrorView
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: () -> FooterView
    
    /// Builder for each cell of the section
    @ViewBuilder public let cellBuilder: (ItemIndex, AnyHashable) -> CellView
    
    // MARK: - Initializer
    /// Default BESection
    /// - Parameters:
    ///   - data: section's data
    ///   - headerView: headerView that is on top of this section
    ///   - onEmptyView: the view that will be shown when the section is empty
    ///   - onLoadingView: the view that will be shown when the data on the section is being loaded
    ///   - onErrorView: the view that will be shown when there is any error on loading data in section
    ///   - footerView: footerView that is at the bottom of the section
    ///   - cellBuilder: View builder for each cells in section
    public init(
        data: BESectionData,
        headerView: @escaping () -> HeaderView,
        onEmptyView: @escaping () -> OnEmptyView,
        onLoadingView: @escaping () -> OnLoadingView,
        onErrorView: @escaping (AnyHashable) -> OnErrorView,
        footerView: @escaping () -> FooterView,
        cellBuilder: @escaping (ItemIndex, AnyHashable) -> CellView
    ) {
        self.data = data
        self.headerView = headerView
        self.onEmptyView = onEmptyView
        self.onLoadingView = onLoadingView
        self.onErrorView = onErrorView
        self.footerView = footerView
        self.cellBuilder = cellBuilder
    }
    
    /// Body of the section
    public var body: some View {
        VStack {
            headerView()
            
            switch data.layoutType {
            case .lazyVStack:
                LazyVStack {
                    content
                }
            case .lazyVGrid(let columns):
                LazyVGrid(
                    columns: data.state == .loaded && data.items.count > 0 ?
                        columns:
                        [GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude))]
                    ) {
                    content
                }
            }
            
            footerView()
        }
    }
    
    private var content: some View {
        Group {
            if data.state == .loaded && data.items.isEmpty {
                onEmptyView()
            } else {
                // all items
                ForEach(data.items, id: \.hashValue) { item in
                    cellBuilder(data.items.firstIndex(of: item)!, item)
                }
                
                // loading
                if data.state == .loading || data.state == .initializing {
                    onLoadingView()
                }
                
                // error
                if let error = data.error {
                    onErrorView(error)
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
        onErrorView: @escaping (AnyHashable) -> OnErrorView,
        footerView: @escaping () -> FooterView,
        cellBuilder: @escaping (ItemIndex, AnyHashable) -> CellView
    ) {
        self.init(
            data: data,
            headerView: { EmptyView() },
            onEmptyView: onEmptyView,
            onLoadingView: onLoadingView,
            onErrorView: onErrorView,
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
        onErrorView: @escaping (AnyHashable) -> OnErrorView,
        cellBuilder: @escaping (ItemIndex, AnyHashable) -> CellView
    ) {
        self.init(
            data: data,
            headerView: headerView,
            onEmptyView: onEmptyView,
            onLoadingView: onLoadingView,
            onErrorView: onErrorView,
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
        onErrorView: @escaping (AnyHashable) -> OnErrorView,
        cellBuilder: @escaping (ItemIndex, AnyHashable) -> CellView
    ) {
        self.init(
            data: data,
            headerView: { EmptyView() },
            onEmptyView: onEmptyView,
            onLoadingView: onLoadingView,
            onErrorView: onErrorView,
            footerView: { EmptyView() },
            cellBuilder: cellBuilder
        )
    }
}
