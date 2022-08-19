import SwiftUI

/// ListView that is data driven
public struct BEList<HeaderView: View, FooterView: View>: View {
    public typealias SectionIndex = Int
    
    // MARK: - Public properties
    
    /// ViewModel that is responsible for data flow
    public let viewModel: BEListViewModelType
    
    /// Optional: Builder for the view on top of everything in ListView
    @ViewBuilder public var headerView: () -> HeaderView
    
    /// Optional: Builder for the view at the bottom of everything in ListView
    @ViewBuilder public var footerView: () -> FooterView
    
    /// Section builders
    public let sectionBuilder: (SectionIndex, BESectionData) -> BESectionType
    
    // MARK: - Private properties
    
    /// Sections' data that are controlled by viewModel's sectionsPublisher
    @State private var sections = [BESectionData]()
    
    // MARK: - Initializer
    public init(
        viewModel: BEListViewModelType,
        @ViewBuilder headerView: @escaping () -> HeaderView,
        @ViewBuilder footerView: @escaping () -> FooterView,
        sectionBuilder: @escaping (SectionIndex, BESectionData) -> BESectionType
    ) {
        self.viewModel = viewModel
        self.headerView = headerView
        self.footerView = footerView
        self.sectionBuilder = sectionBuilder
    }
    
    /// Body of the ListView
    public var body: some View {
        ScrollView {
            RefreshableView {
                
                headerView()
                
                ForEach(sections.enumerated().map{(index: $0.0, data: $0.1)}, id: \.0) { index, sectionData in
                    switch sectionData.layoutType {
                    case .lazyVStack:
                        LazyVStack {
                            sectionBuilder(index, sectionData).anyView
                        }
                    case .lazyVGrid(let columns):
                        LazyVGrid(
                            columns: sectionData.state == .loaded && sectionData.items.count > 0 ?
                                columns:
                                [GridItem(.flexible(minimum: 0, maximum: .greatestFiniteMagnitude))]
                            ) {
                            sectionBuilder(index, sectionData).anyView
                        }
                    }
                }
                    
                footerView()
            }
            
        }
        .refreshable {
            await MainActor.run {
                viewModel.reload()
            }
        }
        .onReceive(viewModel.sectionsPublisher) { sections in
            self.sections = sections
        }
    }
}

// MARK: - Overload initializers

extension BEList where HeaderView == EmptyView {
    /// Overload initializer to support optional HeaderView
    public init(
        viewModel: BEListViewModelType,
        @ViewBuilder footerView: @escaping () -> FooterView,
        sectionBuilder: @escaping (SectionIndex, BESectionData) -> BESectionType
    ) {
        self.init(
            viewModel: viewModel,
            headerView: { EmptyView() },
            footerView: footerView,
            sectionBuilder: sectionBuilder
        )
    }
}

extension BEList where FooterView == EmptyView {
    /// Overload initializer to support optional FooterView
    public init(
        viewModel: BEListViewModelType,
        @ViewBuilder headerView: @escaping () -> HeaderView,
        sectionBuilder: @escaping (SectionIndex, BESectionData) -> BESectionType
    ) {
        self.init(
            viewModel: viewModel,
            headerView: headerView,
            footerView: { EmptyView() },
            sectionBuilder: sectionBuilder
        )
    }
}

extension BEList where HeaderView == EmptyView, FooterView == EmptyView {
    /// Overload initializer to support optional HeaderView & FooterView
    public init(
        viewModel: BEListViewModelType,
        sectionBuilder: @escaping (SectionIndex, BESectionData) -> BESectionType
    ) {
        self.init(
            viewModel: viewModel,
            headerView: { EmptyView() },
            footerView: { EmptyView() },
            sectionBuilder: sectionBuilder
        )
    }
}
