import Foundation
import SwiftUI

extension BEList where HeaderView == EmptyView {
    init(
        viewModel: BECollectionViewModel<T>,
        cell: @escaping (T?) -> Cell,
        @ViewBuilder footerView: () -> FooterView,
        options: Options
    ) {
        self.init(
            viewModel: viewModel,
            headerView: { EmptyView() },
            cell: cell,
            footerView: footerView,
            options: options
        )
    }
}

extension BEList where FooterView == EmptyView {
    init(
        viewModel: BECollectionViewModel<T>,
        @ViewBuilder headerView: () -> HeaderView,
        cell: @escaping (T?) -> Cell,
        options: Options
    ) {
        self.init(
            viewModel: viewModel,
            headerView: headerView,
            cell: cell,
            footerView: { EmptyView() },
            options: options
        )
    }
}

extension BEList where HeaderView == EmptyView, FooterView == EmptyView {
    init(
        viewModel: BECollectionViewModel<T>,
        cell: @escaping (T?) -> Cell,
        options: Options
    ) {
        self.init(
            viewModel: viewModel,
            headerView: { EmptyView() },
            cell: cell,
            footerView: { EmptyView() },
            options: options
        )
    }
}

