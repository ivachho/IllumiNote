import SwiftUI

struct Song: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let difficulty: Int
    let imageName: String // Image name for the song
    let composer: String
    let duration: String
    let bpm: Int
    let tempo: String
}

let songs: [Song] = [
    // Easy songs
    Song(title: "Mary Had a Little Lamb", difficulty: 1, imageName: "marylamb", composer: "Sarah Josepha Hale", duration: "1:30", bpm: 60, tempo: "slow"),
    Song(title: "Twinkle Twinkle Little Star", difficulty: 1, imageName: "twinklestar", composer: "Traditional", duration: "2:00", bpm: 70, tempo: "slow"),
    Song(title: "Jingle Bells", difficulty: 1, imageName: "jinglebell", composer: "James Lord Pierpont", duration: "1:50", bpm: 80, tempo: "medium"),
    Song(title: "Happy Birthday", difficulty: 1, imageName: "birthday", composer: "Patty Hill and Mildred J. Hill", duration: "1:20", bpm: 65, tempo: "slow"),
    Song(title: "Chopsticks", difficulty: 1, imageName: "chopsticks", composer: "Euphemia Allen", duration: "2:10", bpm: 75, tempo: "medium"),

    // Medium songs
    Song(title: "River Flows in You", difficulty: 2, imageName: "yiruma", composer: "Yiruma", duration: "3:00", bpm: 85, tempo: "medium"),
    Song(title: "Für Elise", difficulty: 2, imageName: "beethoven", composer: "Ludwig van Beethoven", duration: "2:30", bpm: 90, tempo: "medium"),
    Song(title: "Clair de lune", difficulty: 2, imageName: "debussy", composer: "Claude Debussy", duration: "5:00", bpm: 60, tempo: "slow"),
    Song(title: "Sonata No. 8", difficulty: 2, imageName: "mozart", composer: "Wolfgang Amadeus Mozart", duration: "4:30", bpm: 100, tempo: "fast"),
    Song(title: "Concerto No. 1", difficulty: 2, imageName: "chopin", composer: "Frédéric Chopin", duration: "10:00", bpm: 95, tempo: "medium"),

    // Hard songs
    Song(title: "Clocks", difficulty: 3, imageName: "coldplay", composer: "Coldplay", duration: "4:00", bpm: 120, tempo: "fast"),
    Song(title: "Bohemian Rhapsody", difficulty: 3, imageName: "queen", composer: "Queen", duration: "5:55", bpm: 72, tempo: "medium"),
    Song(title: "La Campanella", difficulty: 3, imageName: "liszt", composer: "Franz Liszt", duration: "4:30", bpm: 108, tempo: "fast"),
    Song(title: "Nocturne in C-sharp minor", difficulty: 3, imageName: "chopin", composer: "Frédéric Chopin", duration: "4:00", bpm: 70, tempo: "slow"),
    Song(title: "Piano Sonata No.29, Op.106", difficulty: 3, imageName: "beethoven", composer: "Ludwig van Beethoven", duration: "8:30", bpm: 90, tempo: "medium")
]

