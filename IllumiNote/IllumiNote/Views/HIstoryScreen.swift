//
//  HIstoryScreen.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-23.
//

import SwiftUI

struct PlayedSong: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let image: String // Add image name or URL
    let dateTimePlayed: Date
}

struct HIstoryScreen: View {
    @State private var playedSongs: [PlayedSong] = [
        PlayedSong(title: "Mary Had a Little Lamb", image: "marylamb", dateTimePlayed: Date()),
        PlayedSong(title: "Twinkle Twinkle Little Star", image: "twinklestar", dateTimePlayed: Date()),
        PlayedSong(title: "Mary Had a Little Lamb", image: "marylamb", dateTimePlayed: Date())
    ] // Sample data
    @State private var selectedSong: PlayedSong? = nil

    var body: some View {
        VStack {
            Spacer().frame(height: 50)
            Text("Recently Played")
                .font(.title)
                .foregroundColor(.darkColor)
                .padding()
            ScrollView(.vertical){
                VStack {
                    ForEach(playedSongs) { song in
                        Button(action: {
                            selectedSong = song
                        }) {
                            HStack {
                                Image(song.image)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .cornerRadius(10)
                                Spacer().frame(width: 10)
                                Text(song.title)
                                    .foregroundColor(.ivory)
                                Spacer()
                                Text(DateFormatter.localizedString(from: song.dateTimePlayed, dateStyle: .short, timeStyle: .short))
                                    .foregroundColor(.lilac)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.mistyBlue))
                            .padding(.bottom, 5)
                        }
                    }
                }
                .padding()
            }

            Spacer()
            Text("Bluetooth Connected")
                .foregroundColor(.lilac)
                .padding()
            Spacer()
            HStack {
                Spacer()

                NavigationLink(destination: SongScreen()) {
                    Image(systemName: "music.note")
                        .foregroundColor(.mistyBlue)
                }
                Spacer()
                NavigationLink(destination: HomeScreen()) {
                    Image(systemName: "house.fill")
                        .foregroundColor(.mistyBlue)
                }
                Spacer()
                NavigationLink(destination: HIstoryScreen()) {
                    Image(systemName: "clock")
                        .foregroundColor(.darkColor)
                }
                Spacer()

            }
            .padding()
            .background(Color.back)
        }
        .background(Color.back)
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $selectedSong) { song in
            ResultsPopup(selectedSong: $selectedSong)
        }
    }
}

#Preview {
    HIstoryScreen()
}
