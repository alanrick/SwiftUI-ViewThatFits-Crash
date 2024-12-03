//
//  OutcomeVM.swift
//  Experiment3
//
//  Created by AlanRick on 02.12.24.
//


//
//  OutcomeVM.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 22.11.24.
//

import SwiftUI

@MainActor
@Observable final class OutcomeVM {
    var result = ContResult.sampleData
    
    //  MARK: - Intent

    func setNewPointsIntent(_ newPoints: Int) {
        self.result.setNewPoints(newPoints)
    }

}




