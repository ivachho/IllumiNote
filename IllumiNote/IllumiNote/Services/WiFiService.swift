//
//  WiFiService.swift
//  IllumiNote
//
//  Created by Iva Chho on 2/3/25.
//

import Foundation

class WiFiService : ObservableObject{
    @Published var isConnected : Bool = false
//    let url = URL(string: "http://192.168.4.1:5000/data")!  // Replace with your Raspberry Pi's actual IP
//    private let baseURL = "http://192.168.4.1:5000"

    
    func sendMIDIData(from jsonFileName: String){
        print("Sending MIDI data to raspberry pi")
        guard let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else{
            print("JSON midi file not found")
            return
        }
        do{
            
            let jsonData = try Data(contentsOf: url)
            sendData(jsonData)
            getFeedbackData(for: jsonFileName)
            
        } catch {
            print("Failed to load JSON data")
        }
    }
    
    
    func sendData(_ jsonData: Data){
        let url = URL(string: "http://192.168.4.1:5000/receive_json")! // change based on raspberry pi flask server
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            
            if let error = error{
                print("Error sending data: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Server response: \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
//    
    private func getFeedbackData(for songName: String){
        NotificationCenter.default.post(
                   name: Notification.Name("ProcessFeedback"),
                   object: nil,
                   userInfo: ["songName": songName]
               )
        
        print("Waiting for feedback data from raspberry pi")
        let url = URL(string: "http://192.168.4.1:5000/send_json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        func pollFeedback(){
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error polling feedback: \(error.localizedDescription)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
                    // no feedback yet, retry:
                    DispatchQueue.global().asyncAfter(deadline: .now() + 1){
                        pollFeedback()
                    }
                } else if let data = data{
                    // feedback data is ready
                    do{
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                               let playedNotesJSON = jsonResponse["played_notes"] as? [[String: Any]] {

                                                let playedNotes: [(String, Int)] = playedNotesJSON.compactMap { dict in
                                                    guard let note = dict["note"] as? String,
                                                          let duration = dict["duration"] as? Int else { return nil }
                                                    return (note, duration)
                                                }

                                                if let expectedNotes = loadExpectedNotes(for: songName) {
                                                    NotificationCenter.default.post(
                                                                                    name: Notification.Name("FeedbackDataReady"),
                                                                                    object: nil,
                                                                                    userInfo: [
                                                                                        "expectedNotes": expectedNotes,
                                                                                        "playedNotes": playedNotes
                                                                                    ]
                                                                                )
                                                }
                                            }
                    } catch {
                        print("JSON Parsing error: \(error)")
                    }
                }
            }
            task.resume()
        }
        pollFeedback() // start polling
    }
  
    // TESTING CODE -- COMMENT THIS AND UNCOMMENT ABOVE FOR ACTUAL TESTING
    private func getFeedbackData(for songName: String) {
        NotificationCenter.default.post(
                   name: Notification.Name("ProcessFeedback"),
                   object: nil,
                   userInfo: ["songName": songName]
               )
        
        print("Getting feedback data")
        let mockJSONResponse: [String: Any] = [
            "played_notes": [
                ["note": "D4", "duration": 480],
                ["note": "E4", "duration": 480],
                ["note": "C4", "duration": 480],
                ["note": "D4", "duration": 600],
                ["note": "E4", "duration": 480],
                ["note": "E4", "duration": 482],
                ["note": "E4", "duration": 960],
                ["note": "D4", "duration": 480],
                ["note": "D4", "duration": 480],
                ["note": "D4", "duration": 960],
                ["note": "E4", "duration": 700],
                ["note": "G4", "duration": 480],
                ["note": "G4", "duration": 960],
                ["note": "D4", "duration": 480],
                ["note": "G4", "duration": 480],
                ["note": "G4", "duration": 480],
                ["note": "D4", "duration": 480],
                ["note": "E4", "duration": 480],
                ["note": "E4", "duration": 480],
                ["note": "E4", "duration": 700],
                ["note": "E4", "duration": 480],
                ["note": "D4", "duration": 480],
                ["note": "D4", "duration": 480],
                ["note": "E4", "duration": 480],
                ["note": "D4", "duration": 480],
                ["note": "C4", "duration": 1920]
            ]
        ]
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { // Simulate network delay
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: mockJSONResponse, options: [])
                if let jsonResponse = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let playedNotesJSON = jsonResponse["played_notes"] as? [[String: Any]] {

                    let playedNotes: [(String, Int)] = playedNotesJSON.compactMap { dict in
                        guard let note = dict["note"] as? String,
                              let duration = dict["duration"] as? Int else { return nil }
                        return (note, duration)
                    }

                    if let expectedNotes = loadExpectedNotes(for: songName) {
                        NotificationCenter.default.post(
                                                name: Notification.Name("FeedbackDataReady"),
                                                object: nil,
                                                userInfo: [
                                                    "expectedNotes": expectedNotes,
                                                    "playedNotes": playedNotes
                                                ]
                                            )
                    }
                }
            } catch {
                print("JSON Parsing error: \(error)")
            }
        }
    }

}

// Load expected notes from JSON file
private func loadExpectedNotes(for songName: String) -> [(String, Int)]? {
    print("Loading expected notes")
    let fileName = songName.replacingOccurrences(of: " ", with: "_") // TODO: check if this even necessary?
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("JSON file for expected notes not found")
        return nil
    }

    do {
        let jsonData = try Data(contentsOf: url)
        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
           let notesArray = json["notes"] as? [[String: Any]] {
            return notesArray.compactMap { dict in
                guard let note = dict["note"] as? String,
                      let duration = dict["duration"] as? Int else { return nil }
                return (note, duration)
            }
        }
    } catch {
        print("Error reading JSON file: \(error)")
    }
    return nil
}
