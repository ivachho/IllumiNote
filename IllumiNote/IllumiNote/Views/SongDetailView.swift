//
//  SongDetailView.swift
//  IllumiNote
//
//  Created by Iva Chho on 7/14/24.
//

import Foundation
import SwiftUI

enum Mode: String {
    case normal = "Normal"
    case learn = "Learn"
    case practice = "Practice"
}

struct SongDetailView: View{
    @State private var selectedMode: Mode = .normal
    @EnvironmentObject var bluetoothService: BluetoothService // Access the BluetoothService
    @EnvironmentObject var wifiService: WiFiService // Access the WifiService

    let song: Song
    
    
    let raspberryPiBluetoothAddress = "D8:3A:DD:D9:C2:C2"  // Replace with your Raspberry Pi's MAC address
    let rfcommPort: Int32 = 1  // RFCOMM port 1

    
    
    var body: some View {
//        @EnvironmentObject var bluetoothService: BluetoothService
        
        VStack{
            Spacer().frame(height: 100)
            Image(song.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            Text(song.title)
                .font(.title)
                .foregroundColor(.darkColor)
            Spacer().frame(height: 20)
            ScrollView(.vertical){
                VStack {
                    Text("Composer: \(song.composer)")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                    Text("Duration: \(song.duration)")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                    Text("Difficulty: \(song.difficulty == 1 ? "Easy" : song.difficulty == 2 ? "Medium" : "Hard")")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                    Text("BPM: \(song.bpm)")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                    Text("Tempo: \(song.tempo)")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                    Spacer().frame(height: 30)
                    // Mode Selection
                    Text("Mode:")
                        .font(.title2)
                        .foregroundColor(.darkColor)
                    HStack {
                        ForEach([Mode.normal, Mode.learn, Mode.practice], id: \.self) { mode in
                            Button(action: {
                                selectedMode = mode
                            }) {
                                Text(mode.rawValue)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 30)
                                            .fill(selectedMode == mode ? Color.lilac : Color.mistyBlue)
                                    )
                            }
                        }
                    }
                    .padding()
                    Spacer().frame(height: 1)

                    Button(action: {
                        // Replace spaces with underscores
                        let modifiedTitle = song.title.replacingOccurrences(of: " ", with: "_")
                        //bluetoothService.sendMIDIData(from: modifiedTitle) // Pass the modified title here
                        
                        wifiService.sendMIDIData(from: modifiedTitle)
                    }) {
                        NavigationLink(destination: SessionView(songTitle: song.title).environmentObject(wifiService)) {
                            Text("Start Session")
                                .font(.title)
                                .padding()
                                .background(Color.mistyBlue)
                                .foregroundColor(.darkColor)
                                .cornerRadius(10)
                        }
                    }
                    .padding()

//                    NavigationLink(destination: SessionView(), isActive: $navigateToSession) {
//                        EmptyView()
//                    }
//                    .navigationTitle("Song Details")
                }
                .padding()
                

            }
            
            Spacer()
            HStack {
                Spacer()
            }
            .padding()
//            .background(Color.darkColor)
            .background(Color.back)

        }
//        .background(Color.darkColor)
        .background(Color.back)

        .edgesIgnoringSafeArea(.all)
    }

}


struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleSong = Song(
            title: "Mary Had a Little Lamb",
            difficulty: 1,
            imageName: "marylamb",
            composer: "Sarah Josepha Hale",
            duration: "1:30",
            bpm: 60,
            tempo: "slow"
        )
        
        SongDetailView(song: sampleSong)
            //.environmentObject(BluetoothService())
            .environmentObject(WiFiService())
    }
}
