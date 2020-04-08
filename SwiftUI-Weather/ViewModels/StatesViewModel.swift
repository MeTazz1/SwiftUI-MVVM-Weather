//
//  StatesViewModel.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import Foundation
import Combine

/// ViewModel for StateView
final class StatesViewModel: ObservableViewModel<[StateInfo]>  {
    
    /// Initiliaze objet and its properties
    init() {
        super.init(dataSource: [StateInfo]())
    }
    
    /// OS cleaning memory
    deinit {
        self.deinitData()
    }
}

/// StatesViewModel extension for ViewModelDataSource extension
extension StatesViewModel: ViewModelDataSource {
    
    /// Init the ViewModel data source by reaching JSON file
    func initData() {
        self.dataSource = Bundle.main.decode([StateInfo].self, from: "states.json")
    }
    
    /// Unload and deinit ViewModelDataSource
    func deinitData() {
        self.dataSource.removeAll()
    }
}
