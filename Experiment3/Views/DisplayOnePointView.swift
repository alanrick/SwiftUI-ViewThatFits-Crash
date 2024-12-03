//
//  SingleTrickView.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 15.04.24.
//

import SwiftUI

struct DisplayOnePointView: View {
    let points: Int
    let selected: Bool
    
    var body: some View {
  
        ZStack {
   
            // MARK: - Uncrash
            if selected  {                        // Removing the if statement  prevents the crash.
                Circle().fill(.yellow)
            } else {
                Circle().fill(.yellow)
            }
                    
            Text("\(points)").bold(selected)
        }
        .frame(width: 50, height: 50)    
    }
}


#Preview {
    DisplayOnePointView(points: 7,  selected: true)
        .fullPreview()
}

