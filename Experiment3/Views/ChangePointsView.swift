//
//  ChangePointsView.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 06.01.24.
//

import SwiftUI


struct ChangePointsView: View {
    let points: Int
    
    @Environment(OutcomeVM.self) private var outcomeVM
    
    var body: some View {
        
        Button(action: {
            
            // MARK: - Uncrash
            withAnimation {                                // Removing the animation prevents the crash
                outcomeVM.setNewPointsIntent(points)    // Removing the intent prevents the craash
            }
        } )
        { DisplayOnePointView(points: points,
                          // MARK: - Uncrash
                          selected: outcomeVM.result.points == points) // Making true prevents crash
        }
    }
}

#Preview {
    ChangePointsView(points: 4)
        .fullPreview()
}

