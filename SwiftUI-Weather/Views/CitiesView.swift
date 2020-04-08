//
//  CitiesView.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import SwiftUI

struct CitiesView: View {
    
    @ObservedObject var viewModel : CitiesViewModel

    var body: some View {
        List(self.viewModel.dataSource, id: \.id) { city in
            NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(for: city, in: self.viewModel.state))) {
                Text("\(city.name)")
            }
        }
        .navigationBarTitle("Cities of \(self.viewModel.state.name)")
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.viewModel.initData()
            }
        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static let stateInfo = StateInfo(name: "Texas", abbreviation: "TX")
    static var previews: some View {
        CitiesView(viewModel: CitiesViewModel(for: CitiesView_Previews.stateInfo))
    }
}
