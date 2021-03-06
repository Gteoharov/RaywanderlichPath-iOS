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
struct Grade {
  var letter: Character
  var points: Double
  var credits: Double
}

class Person {
  var firstName: String
  var lastName: String

  required init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}

class Student: Person {
  var grades: [Grade] = []
   
}
extension Student {
    convenience init(transfer: Student) {
        self.init(firstName: transfer.firstName, lastName: transfer.lastName)
        grades = transfer.grades
    }
}

let jon = Person(firstName: "Jon", lastName: "Snow")
let jane = Student(firstName: "Jane", lastName: "Bruks")

jon.firstName
jane.firstName

let historyGrade = Grade(letter: "B", points: 7, credits: 3)
jane.grades.append(historyGrade)

class  SchoolBandMember: Student {
    var minimumPracticeTime = 2
}

class StudentAthlete: Student {
    var isEligible: Bool {
        return grades.filter { $0.letter == "F" } .count < 3
    }
    var sports: [String]
    
    init(firstName: String, lastName: String, sports: [String]) {
        self.sports = sports
        super.init(firstName: firstName, lastName: lastName)
    }
    
    required convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName, lastName: lastName, sports: [])
    }
    
    convenience init(transfer: StudentAthlete) {
        self.init(firstName: transfer.firstName, lastName: transfer.lastName, sports: transfer.sports)
        grades = transfer.grades
    }
    
    override var grades: [Grade] {
        didSet {
            if !isEligible {
                print("It's time to study")
            }
        }
    }
}

let jessy = SchoolBandMember(firstName: "Jessy", lastName: "Catterwaul")
let kaloyan = StudentAthlete(firstName: "Kaloqn", lastName: "Stoqnov", sports: ["Wrestling", "Football"])

let array = [jane, jessy, kaloyan]

let student = kaloyan as Student
let athlete = student as! StudentAthlete

let utterFailureGrade = Grade(letter: "F", points: 0, credits: 0)
athlete.grades.append(utterFailureGrade)
athlete.grades.append(utterFailureGrade)
athlete.grades.append(utterFailureGrade)

func getEveningActivity(student: Student) -> String {
    if let bandMember = student as? SchoolBandMember {
        return "Practicing for at least \(bandMember.minimumPracticeTime)"
    } else {
        return "Hitting the books!"
    }
}

getEveningActivity(student: jessy)
getEveningActivity(student: jane)

StudentAthlete(firstName: "Petko", lastName: "Petkov")
StudentAthlete(transfer: kaloyan).sports
