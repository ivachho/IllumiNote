import SwiftUI
import Combine

struct SessionView: View {
    let songTitle: String
    @State private var songData: JsonSong?
    @State private var isResultsReady = false
    @State private var cancellable: AnyCancellable? // Combine subscription
    @EnvironmentObject var wifiService: WiFiService // Use WiFiService instead of BluetoothService
    @EnvironmentObject var feedbackViewService: FeedbackViewService
    @State private var showFeedbackScreen = false
//
//        .onChange(of: feedbackViewModel.feedbackReceived) { newValue in
//                  if newValue {
//                      showFeedbackScreen = true
//                  }
//              }
    var body: some View {
        NavigationView {
            VStack {
                if let songData = songData {
                    Text("Session in Progress: \(songData.title)")
                        .font(.largeTitle)
                        .padding()

                    Button("End Session") {
                        // Simulate receiving results for testing
                        // Example for WiFi, modify as needed for actual logic
                        
                        isResultsReady = true
                    }
                    .padding()
                } else {
                    Text("Loading Song...")
                        .font(.title)
                        .padding()
                }
            }
            .onAppear {
                loadSongData()
                sendDataToRaspberryPi() // Trigger the MIDI data transfer
            }
            .navigationTitle("Session")
//            .navigationDestination(isPresented: $isResultsReady) {
//                ResultsPopup(selectedSong: .constant(nil))
//            }
            .fullScreenCover(isPresented: $showFeedbackScreen) {
                            FeedbackView()
                                .environmentObject(feedbackViewService)
                                .onAppear {
                                    print("FeedbackView appeared")
                                }
                        }
                        .onReceive(feedbackViewService.objectWillChange) { _ in
                            print("FeedbackViewService object will change")
                        }
                        .onReceive(feedbackViewService.$feedbackReceived) { value in
                            print("Received new value for feedbackReceived: \(value)")
                            if value {
                                print("change detected to feedbackReceived...")
                                showFeedbackScreen = true
                            }
                        }
        }
        .onAppear {
                    // Set up notification observers
                    NotificationCenter.default.addObserver(
                        forName: Notification.Name("FeedbackDataReady"),
                        object: nil,
                        queue: .main
                    ) { notification in
                        guard let userInfo = notification.userInfo,
                              let expectedNotes = userInfo["expectedNotes"] as? [(String, Int)],
                              let playedNotes = userInfo["playedNotes"] as? [(String, Int)] else {
                            return
                        }
                        feedbackViewService.processFeedback(
                            expectedNotes: expectedNotes,
                            playedNotes: playedNotes
                        )
                    }
                }
    }

    func loadSongData() {
        let fileName = songTitle.replacingOccurrences(of: " ", with: "_")
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                songData = try decoder.decode(JsonSong.self, from: data)
            } catch {
                print("Error loading song data: \(error)")
            }
        } else {
            print("Could not find the URL for the JSON file.")
        }
    }

    func sendDataToRaspberryPi() {
        let fileName = songTitle.replacingOccurrences(of: " ", with: "_")
        wifiService.sendMIDIData(from: fileName) // Use WiFiService to send data
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView(songTitle: "Mary_Had_a_Little_Lamb")
            .environmentObject(WiFiService()) // Use WiFiService here
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
