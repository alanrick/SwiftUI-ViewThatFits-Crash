//
//  ResultHdr.swift
//  ScoreDIsplay
//
//  Created by AlanRick on 21.01.24.
//

import SwiftUI


@MainActor
struct ContResult  {
    private(set) var success:               Bool
    private(set) var points:       Int

    
    init(success: Bool,
         points: Int) {
        self.success                = true
        self.points                 = points
    }
    
    // MARK: - Update properties
    
    mutating func setOutcomeResult(_ outcome: Bool) {
        self.success = outcome
    }
    
    mutating func setNewPoints(_ newPoints: Int) {
        guard newPoints >= 0 && newPoints <= 4 else { return }
        self.points = newPoints
    }
    
}
  
// MARK: - Extensions

extension  ContResult {
    @MainActor static let sampleData = ContResult(success: true,
                                       points: 4  )
}
extension  ContResult {
    @MainActor static let exactMade = ContResult(success:  false,
                                      points: 0)
}
