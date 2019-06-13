import UIKit

struct Actor {
    let name: String
    var filmography: [String] = []
    
    mutating func singOnForSequal(franchiseName: String) {
        filmography.append("Upcoming \(franchiseName) sequel")
    }
}

var gotgActor = Actor(name: "Zoe Saldana", filmography: ["Guardians of the galaxy"])
gotgActor.filmography.append("Avatar")

var starTrekStar = gotgActor
starTrekStar.filmography.append("Star Trek")

var avatarStar = starTrekStar
for franchiseName in avatarStar.filmography {
    avatarStar.singOnForSequal(franchiseName: franchiseName)
}
