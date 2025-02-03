//
//  WiFiService.swift
//  IllumiNote
//
//  Created by Iva Chho on 2/3/25.
//

import Foundation

class WiFiService : ObservableObject{
    @Published var isConnected : Bool = false
    
    func sendMIDIData(from jsonFileName: String){
        guard let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") else{
            print("JSON midi file not found")
            return
        }
        do{
            let jsonData = try Data(contentsOf: url)
            sendData(jsonData)
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
}
