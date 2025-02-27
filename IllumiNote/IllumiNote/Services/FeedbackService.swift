//
//  FeedbackService.swift
//  IllumiNote
//
//  Created by Iva Chho on 2/19/25.
//
import Foundation

class FeedbackService {
    static let shared = FeedbackService()

    func calculateAccuracy(expectedNotes: [(String, Int)], playedNotes: [(String, Int)]) -> (Double, Double, Double) {
        print("calculating accuracy...")
        let totalExpected = expectedNotes.count
        guard totalExpected > 0 else { return (0.0, 0.0, 0.0) }

        var correctNotes = 0
        var totalDurationError = 0
        var totalExpectedDuration = 0

        for (index, (expectedNote, expectedDuration)) in expectedNotes.enumerated() {
            if index < playedNotes.count {
                let (playedNote, playedDuration) = playedNotes[index]

                // count correct notes
                if expectedNote == playedNote {
                    correctNotes += 1
                }

                // calculate timing error
                totalDurationError += abs(expectedDuration - playedDuration)
                totalExpectedDuration += expectedDuration
            }
        }

        // KEY ACCURACY:
        let keyAccuracy = (Double(correctNotes) / Double(totalExpected)) * 100

        // TIMING ACCURACY:
        let timingAccuracy: Double
        if totalExpectedDuration > 0 {
            timingAccuracy = 100 - ((Double(totalDurationError) / Double(totalExpectedDuration)) * 100)
        } else {
            timingAccuracy = 0.0
        }
        
        let overallScore = (keyAccuracy * 0.7) + (timingAccuracy * 0.3)

        return (keyAccuracy, timingAccuracy, overallScore)
    }
}
