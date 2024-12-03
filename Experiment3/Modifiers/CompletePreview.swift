//
//  CompletePreview.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 02.10.24.
//


//     Use as a modifier for all previews that dump
//           typicalView(…)
//             .fullPreview()
//


import SwiftUI

extension View {
    func fullPreview() -> some View {
        modifier(completePreview())
    }
}

struct completePreview: ViewModifier {
    func body(content: Content) -> some View {
        preViewView(content)
    }
}

@MainActor
func preViewView(_ content: some View) -> some View {
     
    return    content
        .environment(OutcomeVM())
           
    
}


