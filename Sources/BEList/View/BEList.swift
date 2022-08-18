import SwiftUI

/// ListView that is data driven
public struct BEList<HeaderView: View, FooterView: View>: View {
    
    // MARK: - Public properties
    
    /// ViewModel that is responsible for data flow
    public let viewModel: BEListViewModelType
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: () -> HeaderView
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: () -> FooterView
    
    /// Section builders
    public let sectionsBuilder: ([BESectionData]) -> [BESectionType]
    
    // MARK: - Private properties
    
    /// Sections' data that are controlled by viewModel's sectionsPublisher
    @State private var _sections = [BESectionData]()
    
    // MARK: - Initializer
    public init(
        viewModel: BEListViewModelType,
        @ViewBuilder headerView: @escaping () -> HeaderView,
        @ViewBuilder footerView: @escaping () -> FooterView,
        sectionsBuilder: @escaping ([BESectionData]) -> [BESectionType]
    ) {
        self.viewModel = viewModel
        self.headerView = headerView
        self.footerView = footerView
        self.sectionsBuilder = sectionsBuilder
    }
    
    /// Body of the ListView
    public var body: some View {
        List {
            headerView()
            
            ForEach(
                sectionsBuilder(_sections).enumerated()
                    .map {(index: $0, view: $1.anyView)},
                id: \.index
            ) { $0.view }
            
            footerView()
        }
        .refreshable {
            await viewModel.reload()
        }
        .onReceive(viewModel.sectionsPublisher) { sections in
            self._sections = sections
        }
    }
}

// MARK: - Overload initializers

extension BEList where HeaderView == EmptyView {
    /// Overload initializer to support optional HeaderView
    public init(
        viewModel: BEListViewModelType,
        @ViewBuilder footerView: @escaping () -> FooterView,
        sectionsBuilder: @escaping ([BESectionData]) -> [BESectionType]
    ) {
        self.init(
            viewModel: viewModel,
            headerView: { EmptyView() },
            footerView: footerView,
            sectionsBuilder: sectionsBuilder
        )
    }
}

extension BEList where FooterView == EmptyView {
    /// Overload initializer to support optional FooterView
    public init(
        viewModel: BEListViewModelType,
        @ViewBuilder headerView: @escaping () -> HeaderView,
        sectionsBuilder: @escaping ([BESectionData]) -> [BESectionType]
    ) {
        self.init(
            viewModel: viewModel,
            headerView: headerView,
            footerView: { EmptyView() },
            sectionsBuilder: sectionsBuilder
        )
    }
}

extension BEList where HeaderView == EmptyView, FooterView == EmptyView {
    /// Overload initializer to support optional HeaderView & FooterView
    public init(
        viewModel: BEListViewModelType,
        sectionsBuilder: @escaping ([BESectionData]) -> [BESectionType]
    ) {
        self.init(
            viewModel: viewModel,
            headerView: { EmptyView() },
            footerView: { EmptyView() },
            sectionsBuilder: sectionsBuilder
        )
    }
}
