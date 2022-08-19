import Foundation
import SwiftUI

/// Struct contains all information which is needed for a BESection
public struct BESectionData: Hashable {
    /// Layout type
    public let layoutType: BESectionLayoutType
    /// Loading state of the current section
    public let state: BEFetcherState
    /// Data in current section
    public let items: [AnyHashable]
    /// Error in current section
    public let error: AnyHashable?
    /// Optional: Addtional data
    public let info: AnyHashable?
    
    public init(layoutType: BESectionLayoutType = .lazyVStack, state: BEFetcherState, items: [AnyHashable], error: AnyHashable?, info: AnyHashable? = nil) {
        self.layoutType = layoutType
        self.state = state
        self.items = items
        self.error = error
        self.info = info
    }
}

/// Layout type for section
public enum BESectionLayoutType: Hashable {
    case lazyVStack
    case lazyVGrid//(columns: [GridItem])
}

//extension GridItem: Hashable {}
//
//extension GridItem.Size: Hashable {
//    public func hash(into hasher: inout Hasher) {
//
//    }
//
//    public static func == (lhs: GridItem.Size, rhs: GridItem.Size) -> Bool {
//        switch (lhs, rhs) {
//        case (.fixed(let fixed1), .fixed(let fixed2)):
//            return fixed1 == fixed2
//        case (.flexible(let minimum1, let maximum1), .flexible(let minimum2, let maximum2)):
//            return minimum1 == minimum2 && maximum1 == maximum2
//        case (.adaptive(let minimum1, let maximum1), .adaptive(let minimum2, let maximum2)):
//            return minimum1 == minimum2 && maximum1 == maximum2
//        default:
//            return false
//        }
//    }
//}
//
//extension SwiftUI.Alignment: Hashable {
//
//}
