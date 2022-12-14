//
//  File.swift
//  
//
//  Created by Chung Tran on 18/08/2022.
//

import Foundation
import Combine

@MainActor
public protocol BEListViewModelType {
    var sectionsPublisher: AnyPublisher<[BESectionData], Never> { get }
    func reload()
}
