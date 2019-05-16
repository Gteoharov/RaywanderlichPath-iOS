import UIKit

let number = Int.max
let numberDescription: String

switch number {
    case 0:
        numberDescription = "Zero"
    case 1...10:
        numberDescription = "Between 1 and 9"
    case let negativeNumber where negativeNumber < 0:
        numberDescription = "Negative"
    case _ where number > .max/2:
        numberDescription = "Very large!"
    default:
        break
}

let numberIsEven: Bool

switch number % 2 {
case 0:
    numberIsEven = true
default:
    numberIsEven = false
}

let animalString = "Elephant"
let isHousePet: Bool

switch animalString {
case "Dog", "Cat", "Hamster":
    isHousePet = true
default:
    isHousePet = false
}



