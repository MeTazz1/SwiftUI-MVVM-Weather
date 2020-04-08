//
//  StatesView.swift
//  SwiftUI-Weather
//
//  Created by Christophe Dellac on 4/6/20.
//  Copyright © 2020 Christophe Dellac. All rights reserved.
//

import SwiftUI

struct StatesView: View {
    
    @ObservedObject var viewModel : StatesViewModel
    
    @State private var navBarHidden = true
    
    var body: some View {
        NavigationView {
            List(self.viewModel.dataSource, id: \.id) { stateInfo in
                NavigationLink(destination: CitiesView(viewModel: CitiesViewModel(for: stateInfo))) {
                    Text("\(stateInfo.name)")
                    Spacer()
                    Text("\(stateInfo.abbreviation)")
                    .bold()
                }
            }
            .navigationBarTitle("States")
            .onAppear() {
                self.viewModel.initData()
            }
        }
    }
}

struct StatesView_Previews: PreviewProvider {
    static var previews: some View {
        StatesView(viewModel: StatesViewModel())
    }
}
