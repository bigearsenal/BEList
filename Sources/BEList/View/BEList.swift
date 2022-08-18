import SwiftUI

/// ListView that is data driven
public struct BEList<HeaderView: View, FooterView: View>: View {
    
    // MARK: - Public properties
    
    /// ViewModel that is responsible for data flow
    public let viewModel: BEListViewModelType
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: HeaderView
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: FooterView
    
    /// Section builders
    public let sectionsBuilder: ([BESectionData]) -> [BESectionType]
    
    // MARK: - Private properties
    
    /// Sections' data that are controlled by viewModel's sectionsPublisher
    @State private var _sections = [BESectionData]()
    
    // MARK: - ViewBuilder
    
    /// Body of the ListView
    public var body: some View {
        List {
            headerView
            
            ForEach(
                sectionsBuilder(_sections).enumerated()
                    .map {(index: $0, view: $1.anyView)},
                id: \.index
            ) { $0.view }
            
            footerView
        }
        .refreshable {
            await viewModel.reload()
        }
        .onReceive(viewModel.sectionsPublisher) { sections in
            self._sections = sections
        }
    }
}
