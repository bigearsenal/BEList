import Foundation
import SwiftUI

public protocol BESectionType {
    var anyView: AnyView {get}
}

extension BESection: BESectionType {
    public var anyView: AnyView {
        AnyView(body)
    }
}

public struct BESection<HeaderView: View, CellView: View, EmptyView: View, LoadingView: View, FooterView: View>: View {
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: HeaderView
    
    /// Optional: Builder for ListView when data is empty
    @ViewBuilder public var emptyView: EmptyView
    
    /// Optional: Builder for ListView when data is loading
    @ViewBuilder public var loadingView: LoadingView // Optional
    
    /// Builder for each cell of the section
    public let cellView: (AnyHashable) -> CellView
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: FooterView
    
    public var body: some View {
        BEList(viewModel: <#T##BEListViewModelType#>) {
            <#code#>
        } footerView: {
            <#code#>
        } sectionsBuilder: { <#[BEListSection]#> in
            <#code#>
        }

    }
}
