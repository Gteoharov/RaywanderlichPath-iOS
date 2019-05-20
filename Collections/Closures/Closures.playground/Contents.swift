import UIKit

typealias Operate = (Int, Int) -> (Int)

func add(number1: Int, number2: Int) -> Int {
    return number1 + number2
}

func printResultOf(_ a: Int, _ b: Int, operation: Operate) {
    let result = operation(a, b)
    print("Result is \(result)")
}

printResultOf(5, 3, operation: add)

//let multiply: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
//    return a * b
//}

//let multiply: (Int, Int) -> Int = { (a, b) in
//    a * b
//}

let multiply: (Int, Int) -> Int = {
    $0 * $1
}

let devide: Operate = { (a, b) in
    return a / b
}

multiply(4, 2)

printResultOf(6, 8, operation: multiply)
printResultOf(48, 8, operation: devide)

printResultOf(35, 5) {$0 - $1}

let voidClosure: () -> Void = {
    print("Yay, Swift!")
}

voidClosure()

var count = 0
let incrementCount = {
    count += 1
}

incrementCount()
incrementCount()
incrementCount()
incrementCount()
count

func makeCountingClosure() -> () -> Int {
    var count = 0
    let incrementCount: () -> Int = {
        count += 1
        return count
    }
    return incrementCount
}

let counter1 = makeCountingClosure()
let counter2 = makeCountingClosure()

counter1()
counter2()
counter1()
counter2()


//: # Closures & Collections
var names = ["Ivan", "Doncho", "Kenov", "Betunka"]

// sort() & sort(by:) - Sorts in place / mutates the original
names.sort()
names.sort { (a, b) -> Bool in
    a > b
}

// sorted() & sorted(by:) - Returns a new collection that is sorted
let longToShortNames = names.sorted {
    $0.count > $1.count
}

longToShortNames
names

//: 'filter'
var prices = [1.5, 10.00, 4.99, 2.30, 8.19]

//let largePrices = prices.filter { (price) -> Bool in
//    return price > 5
//}

let largePrice = prices.filter { $0 > 5 }

var arrayFilteredResults: [Double] = []
for price in prices where price > 5 {
    arrayFilteredResults.append(price)
}


//: 'map'

//let salePrice = prices.map { price -> Double in
//    return name * 0.9
//}

let salePrice = prices.map { $0 * 0.9 }
salePrice

var arrayForSalePrices: [Double] = []
for price in prices {
    arrayForSalePrices.append(price * 0.9)
}
arrayForSalePrices

//: 'reduce'
//let sum = prices.reduce(0) { result, price -> Double in
//    return result + price
//}

let sum = prices.reduce(0, +)


var doubleForSum = 0.0
for price in prices {
    doubleForSum += price
}
doubleForSum

var stock = [1.50: 5, 10.00: 2, 4.99: 20, 2.30: 5, 8.19: 30]

let stockSum = stock.reduce(into: []) { result, pair in
    result.append(pair.key * Double(pair.value))
}
stockSum

var arrayForStockValues: [Double] = []
for (price, quantity) in stock {
    let value = price * Double(quantity)
    arrayForStockValues.append(value)
}


//: 'compactMap' & 'flatMap'

let userInput = ["meow!", "15", "37.5", "seven"]

let validInput = userInput.compactMap { input in
    Int(input)
}

var arrayForValidInput: [Int] = []
for input in userInput {
    guard let input = Int(input) else {
        continue
    }
    arrayForValidInput.append(input)
}

arrayForValidInput

let arrayOfDwarfArrays = [
    ["Sleepy", "Grumpy", "Dor"],
    ["Thorin", "Nori"]
]

//let dwarvesAfterM = arrayOfDwarfArrays.flatMap { (array) -> [String] in
//    return array.filter({ (dwarf) -> Bool in
//        dwarf > "M"
//    })
//}

let dwarvesAfterM = arrayOfDwarfArrays.flatMap { $0.filter { $0 > "M" } }
dwarvesAfterM

let sortedDwarves = dwarvesAfterM.sorted()

var emptyDwarvesArray: [String] = []
for dwarves in arrayOfDwarfArrays {
    for customDwarve in dwarves {
        if customDwarve > "M" {
            emptyDwarvesArray.append(customDwarve)
        }
    }
}

emptyDwarvesArray

