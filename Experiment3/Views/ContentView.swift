//
//  ContentView.swift
//  Experiment3
//
//  Created by AlanRick on 02.12.24.
//

import SwiftUI

struct ContentView: View {
    @State var resultVM = OutcomeVM()

    var body: some View {
        VStack {
            
            // MARK: - Uncrash
            Text("hello world")      // Removing this line prevents the crash
            ResultPointsView()
                .environment(resultVM)
        }
    }
}

#Preview {
    ContentView()
}
