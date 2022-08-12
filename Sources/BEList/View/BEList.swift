import SwiftUI

public struct BEList<T: Hashable, HeaderView: View, Cell: View, FooterView: View>: View {
    @ObservedObject public var viewModel: BECollectionViewModel<T>
    private let headerView: HeaderView
    private let cell: (T?) -> Cell // nil for loading scene
    private let footerView: FooterView
    private let options: Options
    
    public init(
        viewModel: BECollectionViewModel<T>,
        @ViewBuilder headerView: () -> HeaderView,
        cell: @escaping (T?) -> Cell,
        @ViewBuilder footerView: () -> FooterView,
        options: Options
    ) {
        self.viewModel = viewModel
        self.headerView = headerView()
        self.cell = cell
        self.footerView = footerView()
        self.options = options
    }
    
    public var body: some View {
        List {
            headerView
            // data
            ForEach(viewModel.data, id: \.hashValue) { item in
                cell(item)
            }
            // loading cell
            if viewModel.state == .loading || viewModel.state == .initializing {
                ForEach(0..<options.numberOfLoadingCells, id: \.self) {_ in 
                    cell(nil)
                }
            }
            footerView
        }
    }
}

extension BEList {
    public struct Options {
        public let numberOfLoadingCells = 2
        
    }
}
