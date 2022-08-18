import Foundation

/// Struct contains all information which is needed for a BESection
public struct BESectionData: Hashable {
    /// Loading state of the current section
    public let state: BEFetcherState
    /// Data in current section
    public let items: [AnyHashable]
    /// Error in current section
    public let error: AnyHashable?
    /// Optional: Addtional data
    public let info: AnyHashable?
}
