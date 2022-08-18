import Foundation

/// Struct contains all information which is needed for a BESection
public struct BESectionData: Hashable {
    /// Loading state of the current section
    public let state: BEFetcherState
    /// Data in current section
    public let data: [AnyHashable]
    /// Optional: Addtional data
    public let info: AnyHashable?
}
