import Foundation
import SwiftUI

/// Struct contains all information which is needed for a BESection
public struct BESectionData: Hashable {
    /// Layout type
    public let layoutType: BESectionLayoutType
    /// Loading state of the current section
    public let state: BEListState
    /// Data in current section
    public let items: [AnyHashable]
    /// Error in current section
    public let error: AnyHashable?
    /// Optional: Addtional data
    public let info: AnyHashable?
    
    public init(layoutType: BESectionLayoutType = .lazyVStack, state: BEListState, items: [AnyHashable], error: AnyHashable?, info: AnyHashable? = nil) {
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
    case lazyVGrid(columns: [GridItem])
}
