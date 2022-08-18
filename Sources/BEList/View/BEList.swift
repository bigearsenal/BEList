import SwiftUI

public protocol CellView: View {
    static func loaded(_ data: AnyHashable) -> Self
    static func loading() -> Self
}

public struct BEList<T: Hashable, HeaderView: View, Cell: CellView, FooterView: View>: View {
    @ObservedObject public var viewModel: BECollectionViewModel<T>
    private let headerView: HeaderView
    private let cellType: Cell.Type
    private let footerView: FooterView
    private let options: Options
    
    public init(
        viewModel: BECollectionViewModel<T>,
        @ViewBuilder headerView: () -> HeaderView,
        cellType: Cell.Type,
        @ViewBuilder footerView: () -> FooterView,
        options: Options
    ) {
        self.viewModel = viewModel
        self.headerView = headerView()
        self.cellType = cellType
        self.footerView = footerView()
        self.options = options
    }
    
    public var body: some View {
        List {
            headerView
            // data
            ForEach(viewModel.data, id: \.hashValue) { item in
                cellType.loaded(item)
            }
            // loading cell
            if viewModel.state == .loading || viewModel.state == .initializing {
                ForEach(0..<options.numberOfLoadingCells, id: \.self) {_ in
                    cellType.loading()
                }
            }
            footerView
        }
        .refreshable {
            await viewModel.reload()
        }
    }
}

extension BEList {
    public struct Options {
        public let numberOfLoadingCells = 2
        
    }
}
