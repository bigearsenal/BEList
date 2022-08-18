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
public struct BESection<HeaderView: View, CellView: View, EmptyView: View, LoadingView: View, FooterView: View>: View {
    
    // MARK: - Public properties
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: HeaderView
    
    /// Optional: Builder for ListView when data is empty
    @ViewBuilder public var emptyView: EmptyView
    
    /// Optional: Builder for ListView when data is loading
    @ViewBuilder public var loadingView: LoadingView // Optional
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: FooterView
    
    /// Builder for each cell of the section
    public let cellView: (AnyHashable) -> CellView
    
    // MARK: - Private properties
    
    /// Body of the section
    public var body: some View {
        fatalError()
    }
}
