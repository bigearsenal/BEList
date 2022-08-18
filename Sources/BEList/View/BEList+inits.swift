import Foundation
import SwiftUI

//extension BEList where HeaderView == EmptyView {
//    init(
//        viewModel: BECollectionViewModel<T>,
//        cellType: Cell.Type,
//        @ViewBuilder footerView: () -> FooterView,
//        options: Options
//    ) {
//        self.init(
//            viewModel: viewModel,
//            headerView: { EmptyView() },
//            cellType: cellType,
//            footerView: footerView,
//            options: options
//        )
//    }
//}
//
//extension BEList where FooterView == EmptyView {
//    init(
//        viewModel: BECollectionViewModel<T>,
//        @ViewBuilder headerView: () -> HeaderView,
//        cellType: Cell.Type,
//        options: Options
//    ) {
//        self.init(
//            viewModel: viewModel,
//            headerView: headerView,
//            cellType: cellType,
//            footerView: { EmptyView() },
//            options: options
//        )
//    }
//}
//
//extension BEList where HeaderView == EmptyView, FooterView == EmptyView {
//    init(
//        viewModel: BECollectionViewModel<T>,
//        cellType: Cell.Type,
//        options: Options
//    ) {
//        self.init(
//            viewModel: viewModel,
//            headerView: { EmptyView() },
//            cellType: cellType,
//            footerView: { EmptyView() },
//            options: options
//        )
//    }
//}
