import UIKit

class Actor {
    let name: String
    var filmography: [String] = []
    
    init(name: String, filmography: [String]) {
        self.name = name
        self.filmography = filmography
    }
    
    func singOnForSequal(franchiseName: String) {
        filmography.append("Upcoming \(franchiseName) sequel")
    }
}

let gotgActor = Actor(name: "Zoe Saldana", filmography: ["Guardians of the galaxy"])
gotgActor.filmography.append("Avatar")

let starTrekStar = gotgActor
starTrekStar.filmography.append("Star Trek")

var avatarStar = starTrekStar
for franchiseName in avatarStar.filmography {
    avatarStar.singOnForSequal(franchiseName: franchiseName)
}

gotgActor.filmography
starTrekStar.filmography
avatarStar.filmography
