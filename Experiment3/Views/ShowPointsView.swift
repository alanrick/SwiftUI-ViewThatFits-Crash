//
//  ShowPointsView.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 15.04.24.
//

import SwiftUI


struct ShowPointsView: View {
    let points: Int
    
    var body: some View {
        HStack  {
            ForEach(1...points, id: \.self) { number in
                    ChangePointsView( points: number)
            }
        }
    }
}


#Preview {
    ShowPointsView( points: 5)
        .fullPreview()
}

