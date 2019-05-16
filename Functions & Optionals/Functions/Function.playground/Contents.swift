import UIKit

func printMeow() {
    print("Meow")
}

printMeow()

func printMultipleOfFive(multiplier: Int) {
    print("5 * \(multiplier) = \(multiplier * 5)")
}

printMultipleOfFive(multiplier: 10)

func printMultiplierOf(number: Int, multiplier: Int = 1) {
    print("\(number) * \(multiplier) = \(number * multiplier)")
}

printMultiplierOf(number: 4, multiplier: 2)
printMultiplierOf(number: 15)

func multiply(_ factor1: Int,_ factor2: Int) -> Int {
    return factor1 * factor2
}

let result = multiply(5, 10)
print(result)

func multiplyAndDivide(_ number: Int, by factor: Int) -> (product: Int, quotient: Int) {
    return (number * factor, number / factor)
}
let results = multiplyAndDivide(4, by: 2)
let (product, quotient) = results
product
quotient


/// Overrloading

func printMultipleOf(number: Int, multiplier: Int) {
    print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(_ number: Int, multiplier: Int = 1) {
    print("\(number) * \(multiplier) = \(number * multiplier)")
}

func printMultipleOf(_ number: Double, multiplier: Double) {
    print("\(number) * \(multiplier) = \(number * multiplier)")
}

printMultipleOf(7.5, multiplier: 7.5)
printMultipleOf(3)

func getValue() -> Int {
    return 31
}

func getValue() -> String {
    return "meow"
}

let valueInt: Int = getValue()

func add(number1: Int, number2: Int) -> Int {
    return number1 + number2
}

var function = add

function(5, 7)

func subtract(number1: Int, number2: Int) -> Int {
    return number1 - number2
}

function = subtract
function(5, 7)

typealias Operate = (Int, Int) -> Int

func printResult(_ operation: Operate, _ a: Int, _ b: Int) {
    let result = operation(a, b)
    print(result)
}

printResult(add, 4, 2)
printResult(subtract, 4, 2)
