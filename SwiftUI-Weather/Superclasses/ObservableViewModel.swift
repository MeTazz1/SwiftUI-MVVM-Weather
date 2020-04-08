//
//  ObservableViewModel.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/7/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation

/// ObservableViewModel super class for all ViewModels
class ObservableViewModel<T>: ObservableObject {
    
    /// The published data source
    @Published public var dataSource: T
    
    /// Generic initializer
    init(dataSource: T) {
        self.dataSource = dataSource
    }
}
