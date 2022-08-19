import Foundation
import SwiftUI

extension GridItem: Hashable {
    public static func == (lhs: GridItem, rhs: GridItem) -> Bool {
        lhs.size == rhs.size && lhs.spacing == rhs.spacing && lhs.alignment == rhs.alignment
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(size)
        hasher.combine(spacing)
        hasher.combine(alignment)
    }
}

extension GridItem.Size: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .fixed(let float):
            hasher.combine("fixed#\(float)")
        case let .flexible(minimum, maximum):
            hasher.combine("flexible#minimum#\(minimum)#maximum#\(maximum)")
        case let .adaptive(minimum, maximum):
            hasher.combine("adaptive#minimum#\(minimum)#maximum#\(maximum)")
        @unknown default:
            hasher.combine("unknown")
        }
    }

    public static func == (lhs: GridItem.Size, rhs: GridItem.Size) -> Bool {
        switch (lhs, rhs) {
        case (.fixed(let fixed1), .fixed(let fixed2)):
            return fixed1 == fixed2
        case (.flexible(let minimum1, let maximum1), .flexible(let minimum2, let maximum2)):
            return minimum1 == minimum2 && maximum1 == maximum2
        case (.adaptive(let minimum1, let maximum1), .adaptive(let minimum2, let maximum2)):
            return minimum1 == minimum2 && maximum1 == maximum2
        default:
            return false
        }
    }
}

extension Alignment: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .topLeading:
            hasher.combine("topLeading")
        case .top:
            hasher.combine("top")
        case .topTrailing:
            hasher.combine("topTrailing")
        case .leading:
            hasher.combine("leading")
        case .center:
            hasher.combine("center")
        case .trailing:
            hasher.combine("trailing")
        case .bottomLeading:
            hasher.combine("bottomLeading")
        case .bottom:
            hasher.combine("bottom")
        case .bottomTrailing:
            hasher.combine("bottomTrailing")
        default:
            hasher.combine("unknown")
        }
    }
}
