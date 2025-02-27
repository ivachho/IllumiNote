//
//  FeedbackViewService.swift
//  IllumiNote
//
//  Created by Iva Chho on 2/19/25.
//

// TODO: is this safe to run multiple times? does it reset??
import Foundation

class FeedbackViewService: ObservableObject {
    @Published var keyAccuracy: Double = 0.0
    @Published var timingAccuracy: Double = 0.0
    @Published var overallScore: Double = 0.0
    @Published var feedbackReceived = false  // For triggering the screen transition

    func processFeedback(expectedNotes: [(String, Int)], playedNotes: [(String, Int)]) {
        print("processing feedback in feedbackViewService.swift")
        let (keyAcc, timingAcc, overall) = FeedbackService.shared.calculateAccuracy(
            expectedNotes: expectedNotes,
            playedNotes: playedNotes
        )

        DispatchQueue.main.async {
            self.objectWillChange.send()
            self.keyAccuracy = keyAcc
            self.timingAccuracy = timingAcc
            self.overallScore = overall
            self.feedbackReceived = true  // Update state to transition screen
            print("key accuracy: ", keyAcc)
            print("timing accuracy: ", timingAcc)
            print("overall score: ", overall)
            print("feedback calculated and received. feedbackReceived value set to true")
        }
    }
}
