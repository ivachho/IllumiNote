//
//  ResultsView.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2024-07-24.
//

import SwiftUI

struct ResultsPopup: View {
    @Binding var selectedSong: PlayedSong?

    @State private var noteAccuracy: Double = 0.8
    @State private var rhythmAccuracy: Double = 0.7
    @State private var tempoAccuracy: Double = 0.9

    var body: some View {
        VStack(spacing: 20) {
            Text("Results")
                .font(.headline)
                .padding(.top)

            VStack {
                Text("Note Accuracy")
                Slider(value: $noteAccuracy, in: 0...1)
                    .accentColor(.lilac)
                Text("\(Int(noteAccuracy * 100))%")
            }

            VStack {
                Text("Rhythm Accuracy")
                Slider(value: $rhythmAccuracy, in: 0...1)
                    .accentColor(.lilac)
                Text("\(Int(rhythmAccuracy * 100))%")
            }

            VStack {
                Text("Tempo Accuracy")
                Slider(value: $tempoAccuracy, in: 0...1)
                    .accentColor(.lilac)
                Text("\(Int(tempoAccuracy * 100))%")
            }

            VStack {
                Text("Feedback").font(.headline).padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Note Accuracy")
                    Text("Bar 3, Bar 7 had wrong notes")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text("Rhythm Accuracy")
                    Text("Bar 2, Bar 5 had wrong rhythm")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    Text("Tempo Accuracy")
                    Text("Target BPM: 120, Your BPM: 115")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Button(action: {
                selectedSong = nil
            }) {
                Text("Close")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.lilac)
                    .cornerRadius(10)
            }
            .padding(.bottom)

            Spacer()
        }
        .padding()
        .background(Color.ivory)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 20)
    }
}

struct ResultsPopup_Previews: PreviewProvider {
    @State static var selectedSong: PlayedSong? = PlayedSong(title: "Sample Song", image: "music.note", dateTimePlayed: Date())

    static var previews: some View {
        ResultsPopup(selectedSong: $selectedSong)
    }
}
