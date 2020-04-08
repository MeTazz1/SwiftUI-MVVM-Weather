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
final class CitiesViewModel: ObservableViewModel<[CityInfo]>  {
    
    /// The selected state
    var state: StateInfo
    
    /// Initiliaze objet and its properties
    init(for state: StateInfo) {
        self.state = state
        super.init(dataSource: [CityInfo]())
    }
    
    /// OS cleaning memory
    deinit {
        self.deinitData()
    }
}

/// StatesViewModel extension for ViewModelDataSource extension
extension CitiesViewModel: ViewModelDataSource {
    
    /// Init the ViewModel data source by reaching JSON file
    func initData() {
        let cities = Bundle.main.decode(Dictionary<String, [String]>.self, from: "cities.json")
        if let stateCities = cities[self.state.name] {
            self.dataSource = stateCities.map { CityInfo(name: $0, state: self.state.name) }
            self.dataSource.sort(by: { $0.name < $1.name })
        }
    }
    
    /// Unload and deinit ViewModelDataSource
    func deinitData() {
        self.dataSource.removeAll()
    }
}
