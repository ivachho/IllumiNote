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

    var songName: String
    var composer: String
    var duration: String
    var difficulty: String
    
    var body: some View {
        @EnvironmentObject var bluetoothService: BluetoothService
        @State var navigateToSession = false
        
    
        VStack{
            Spacer().frame(height: 100)
            Text("Song Name:")
                .font(.title)
                .foregroundColor(.ivory)
//                .padding()
            Text("\(songName)")
                .font(.title2)
                .foregroundColor(.ivory)
//                .padding()
            Spacer().frame(height: 80)
            ScrollView(.vertical){
                VStack {
                    Text("Composer: \(composer)")
                        .font(.title2)
                        .foregroundColor(.ivory)
//                        .padding()
                    Text("Duration: \(duration)")
                        .font(.title2)
                        .foregroundColor(.ivory)
//                        .padding()
                    Text("Difficulty: \(difficulty)")
                        .font(.title2)
                        .foregroundColor(.ivory)
//                        .padding()
                    Spacer().frame(height: 80)
                    // Mode Selection
                    Text("Mode:")
                        .font(.title2)
                        .foregroundColor(.ivory)
//                        .padding()
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
                    Spacer().frame(height: 80)

                    Button(action: {
                        bluetoothService.sendMIDIData(from: "Example1")
//                        navigateToSession = true
                    }) {
                        NavigationLink(destination: SessionView()) {
                            Text("Start Session")
                                .font(.title)
                                .padding()
                                .background(Color.lilac)
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
            .background(Color.darkColor)
        }
        .background(Color.darkColor)
        .edgesIgnoringSafeArea(.all)
    }
    
//    var body: some View{
//        
//        VStack(alignment: .leading, spacing: 20) {
//            Text("Song Name: \(songName)").font(.title)
//            Text("Composer: \(composer)").font(.subheadline)
//            Text("Duration: \(duration)").font(.subheadline)
//            Text("Difficulty: \(difficulty)").font(.subheadline)
//            Spacer()
//            Button(action: {
//                            bluetoothService.sendMIDIData(from: "Example1")
//                            navigateToSession = true
//                        }) {
//                            Text("Start Session")
//                                .font(.title)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                        }
//                        .padding()
//
//                        NavigationLink(destination: SessionView(), isActive: $navigateToSession) {
//                            EmptyView()
//                        }                    }
//                    .navigationTitle("Song Details")
//    }
}

struct SongDetailView_Previews: PreviewProvider{
    static var previews: some View {
        SongDetailView(songName: "Example Song", composer: "Composer Name", duration: "3:45", difficulty: "easy")
        }
}
