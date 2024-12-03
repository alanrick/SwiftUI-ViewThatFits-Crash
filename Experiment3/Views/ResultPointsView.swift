//
//  ResultPointsView.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 08.01.24.
//

import SwiftUI

struct ResultPointsView: View {
    
    var body: some View {
        
        VStack {
            
            // MARK: - Uncrash
            ViewThatFits {         // Removing ViewThatFits prevents the crash
                ShowPointsView( points: 4)
                
                ShowPointsView( points: 5)        
            }
        }
    }
}


#Preview {
    ResultPointsView()
        .fullPreview()
}
