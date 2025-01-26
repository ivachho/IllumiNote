//
//  SheetMusicView.swift
//  IllumiNote
//
//  Created by Jessie Huang on 2025-01-19.
//

//import SwiftUI
//
//struct SheetMusicView: View {
//    var song: JsonSong
//
//    var body: some View {
//        VStack {
//            Text(song.title)
//                .font(.largeTitle)
//                .padding()
//
////            ForEach(song.notes) { note in
////                Text("\(note.note) - Duration: \(note.duration)")
////                    .font(.title)
////                    .padding(2)
////            }
//        }
//    }
//}
//
//struct SheetMusicView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Sample song for preview
//        let sampleSong = JsonSong(
//            title: "Twinkle Twinkle",
//            key: "C Major",
//            tempo: 60,
//            notes: [
//                Note(note: "C4", duration: 1),
//                Note(note: "C4", duration: 1),
//                Note(note: "G4", duration: 1)
//            ]
//        )
//        SheetMusicView(song: sampleSong)
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
import SwiftUI

struct HorizontalStaffLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

struct VerticalBarLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        return path
    }
}

struct TrebleClef: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.2, y: height * 0.7))
        path.addCurve(
            to: CGPoint(x: width * 0.8, y: height * 0.3),
            control1: CGPoint(x: width * 0.1, y: height * 0.4),
            control2: CGPoint(x: width * 0.9, y: height * 0.6)
        )
        path.addCurve(
            to: CGPoint(x: width * 0.3, y: height * 0.95),
            control1: CGPoint(x: width * 0.7, y: height * 0.1),
            control2: CGPoint(x: width * 0.2, y: height * 0.8)
        )
        return path
    }
}

struct SheetMusicView: View {
    let song: JsonSong
    let staffLineSpacing: CGFloat = 8
    let noteSpacing: CGFloat = 40  // Reduced spacing between notes
    let notesPerBar = 4
    
    func getStaffPosition(for note: String) -> CGFloat {
        let notePositions: [String: CGFloat] = [
            "C4": 6,
            "D4": 5,
            "E4": 4,
            "F4": 3,
            "G4": 2,
            "A4": 1,
            "B4": 0,
            "C5": -1,
            "D5": -2,
            "E5": -3,
            "F5": -4,
            "G5": -5
        ]
        return (notePositions[note] ?? 0) * (staffLineSpacing / 2)
    }
    
    func getNoteShape(duration: Int) -> some View {
        if duration == 1920 { // Whole note
            return AnyView(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 12, height: 12)
            )
        } else if duration == 960 { // Half note
            return AnyView(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 12, height: 12)
            )
        } else { // Quarter note or shorter
            return AnyView(
                Circle()
                    .fill(Color.black)
                    .frame(width: 12, height: 12)
            )
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Title and metadata
                HStack {
                    Text(song.title)
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Key: \(song.key)")
                        Text("Tempo: \(song.tempo) BPM")
                    }
                    .font(.system(size: 14))
                }
                .padding(.horizontal)
                
                // Staff and notes
                ScrollView(.horizontal, showsIndicators: true) {
                    ZStack {
                        // Staff lines
                        VStack(spacing: staffLineSpacing) {
                            ForEach(0..<5) { _ in
                                HorizontalStaffLine()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(height: 1)
                            }
                        }
                        .frame(height: staffLineSpacing * 4)
                        
                        // Bar lines
                        HStack(spacing: noteSpacing * 4) {
                            ForEach(0...song.notes.count / 4, id: \.self) { _ in
                                VerticalBarLine()
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 1, height: staffLineSpacing * 4)
                            }
                        }
                        
                        // Treble clef
                        TrebleClef()
                            .stroke(Color.black, lineWidth: 2)
                            .frame(width: 30, height: staffLineSpacing * 6)
                            .offset(x: -noteSpacing * 2)
                        
                        // Time signature (4/4)
                        Text("4")
                            .font(.system(size: 20, weight: .bold))
                            .offset(x: -noteSpacing, y: -staffLineSpacing)
                        Text("4")
                            .font(.system(size: 20, weight: .bold))
                            .offset(x: -noteSpacing, y: staffLineSpacing)
                        
                        // Notes
                        HStack(spacing: noteSpacing) {
                            ForEach(Array(song.notes.enumerated()), id: \.offset) { index, note in
                                getNoteShape(duration: note.duration)
                                    .offset(y: getStaffPosition(for: note.note))
                            }
                        }
                        .offset(x: noteSpacing)
                    }
                    .frame(width: CGFloat(song.notes.count + 4) * noteSpacing)
                    .padding()
                }
                .frame(height: 150)
            }
            .padding(.vertical)
            .rotationEffect(.degrees(90))
            .frame(width: geometry.size.height, height: geometry.size.width)
            .offset(x: (geometry.size.width - geometry.size.height) / 2,
                   y: (geometry.size.height - geometry.size.width) / 2)
        }
    }
}

struct SheetMusicView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleSong = JsonSong(
            title: "Mary Had a Little Lamb (Simple Version)",
            key: "C Major",
            tempo: 120,
            notes: [
                Note(note: "E4", duration: 480),
                Note(note: "D4", duration: 480),
                Note(note: "C4", duration: 480),
                Note(note: "D4", duration: 480),
                // Add more notes as needed
            ]
        )
        
        SheetMusicView(song: sampleSong)
    }
}
