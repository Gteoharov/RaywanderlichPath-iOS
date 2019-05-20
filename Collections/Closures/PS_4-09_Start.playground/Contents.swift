/*:
 Copyright (c) 2018 Razeware LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 ---
 */
/*:
 # Challenge Time - Closures! 😎
 
 Create a constant array called `names` which contains some names as strings (any names will do — make sure there’s more than three though!). Now use `reduce` to create a string which is the concatenation of each name in the array.
 */


// TODO: Write solution here
let names = ["Stavreca", "Sashko", "Zvezsko", "Mishanera", "Bob"]
let concatenationNames = names.reduce("") { $0 + $1 }
concatenationNames
/*:
 Using the same `names` array, first filter the array to contain only names which have more than four characters in them, and then create the same concatenation of names as in the above exercise. (Hint: you can chain these operations together.)
 */


// TODO: Write solution here
let filteredNames = names.filter { $0.count > 4 }.reduce("") { $0 + $1 }
filteredNames

/*:
 Create a constant dictionary called `namesAndAges` which contains some names as strings mapped to ages as integers. Now use `filter` to create a dictionary containing only people under the age of 18.
 */


// TODO: Write solution here
let namesAndAges: [String : Int] = ["Nasko" : 19, "Izabela" : 26, "Stanimir" : 29, "Sasho" : 34, "Andreikata" : 1]
let underEighteen: [String : Int] = namesAndAges.filter { $0.value < 18 }
underEighteen
/*:
 Using the same `namesAndAges` dictionary, filter out the adults (those 18 or older) and then use `map` to convert to an array containing just the names (i.e. drop the ages).
 */


// TODO: Write solution here
let adultEightTeen = namesAndAges.filter { $0.value > 18}.map { $0.key }
adultEightTeen
