//
//  SongDetailView.swift
//  IllumiNote
//
//  Created by Iva Chho on 7/14/24.
//

import Foundation
import SwiftUI

struct SongDetailView: View{
    var songName: String
    var composer: String
    var duration: String
    var difficulty: String
    
    var body: some View{
        @EnvironmentObject var bluetoothService: BluetoothService
        @State var navigateToSession = false
        
        VStack(alignment: .leading, spacing: 20) {
            Text("Song Name: \(songName)").font(.title)
            Text("Composer: \(composer)").font(.subheadline)
            Text("Duration: \(duration)").font(.subheadline)
            Text("Difficulty: \(difficulty)").font(.subheadline)
            Spacer()
            Button(action: {
                            bluetoothService.sendMIDIData(from: "Example1")
                            navigateToSession = true
                        }) {
                            Text("Start Session")
                                .font(.title)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()

                        NavigationLink(destination: SessionView(), isActive: $navigateToSession) {
                            EmptyView()
                        }                    }
                    .navigationTitle("Song Details")
    }
}

struct SongDetailView_Previews: PreviewProvider{
    static var previews: some View {
        SongDetailView(songName: "Example Song", composer: "Composer Name", duration: "3:45", difficulty: "easy")
        }
}
