//
//  ParseJson.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2025-01-19.
//

import Foundation

struct JsonSong: Codable {
    var title: String
    var key: String
    var tempo: Int
    var notes: [Note]
}


struct Note: Codable {
    var note: String
    var duration: Int
}


class ParseJson {
    static func loadSong(from fileName: String) -> JsonSong? {
        guard let url = Bundle.main.url(forResource: "SongInfo/\(fileName)", withExtension: "json") else {
            print("File not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let song = try JSONDecoder().decode(JsonSong.self, from: data)
            return song
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}

