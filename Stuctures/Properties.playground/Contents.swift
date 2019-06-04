import UIKit

struct Wizzard {
    static let commonMagicalIngredients = [
        "Polyjuice Potion",
        "Eye of Haystack Needle",
        "The Force"
    ]
    
    var firstName: String {
        willSet {
            print("\(firstName) will be set to \(newValue)")
        }
        didSet {
            if firstName.contains(" ") {
                print("No sapces allowed! \(firstName) is not a first name. Reverting name to \(oldValue)")
                firstName = oldValue
            }
        }
    }
    var lastName: String
    
    var fullName: String {
        get { return "\(firstName) \(lastName)" }
        set {
            let nameSubstrings = newValue.split(separator: " ")
            
            guard nameSubstrings.count >= 2 else {
                print("\(newValue) is not a full name.")
                return
            }
            
            let nameStrings = nameSubstrings.map(String.init)
            firstName = nameStrings.first!
            lastName = nameStrings.last!
        }
    }
    
    lazy var magicalCreature = ""
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

var wizzard = Wizzard(firstName: "Gandalf", lastName: "Greyjoy")
wizzard.firstName = "Peshko"
wizzard.lastName = "Peshev"
wizzard.fullName

wizzard.fullName = "Severus Wenderlich"
wizzard.firstName = "Zvezdelin Kolev"
Wizzard.commonMagicalIngredients
