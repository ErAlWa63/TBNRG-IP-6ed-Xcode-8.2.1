//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str

var nextYear: Int
var bodyTemp: Float
var hasPet: Bool
var arrayOfInts: [Int]
var dictionaryOfCapitalsByCountry: [String:String]
var winningLotteryNumbers: Set<Int>

let number = 42
let fmStation = 91.1

var countingUp = ["one", "two"]
let nameByParkingSpace = [13: "Alice", 27: "Bob"]

let secondElement = countingUp[1]

let emptyString = String()
let emptyArrayOfInts = [Int]()
let emptySetOfFloats = Set<Float>()
let defaultNumber = Int()
let defaultBool = Bool()

let meaningOfLife = String(number)
let availableRooms = Set([412, 205, 411])
let defaultFloat = Float()
let floatFromLiteral = Float(3.14)

let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi: Float = 3.14

countingUp.count
emptyString.isEmpty

countingUp.append("three")

var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.8
reading2 = 9.2
//reading3 = 9.7
//let avgReading = (reading1! + reading2! + reading3!) / 3

if let r1 = reading1,
    let r2 = reading1,
    let r3 = reading3 {
        let avgReading = (r1 + r2 + r3) / 3
} else {
    let errorString = "instrument reported a reading that was nil."
}

if let space13Assignee = nameByParkingSpace[13] {
    print("Key 13 is assigned in the dictionary!")
}
let space42Assignee: String? = nameByParkingSpace[42]

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

enum PieType: Int {
    case apple = 0
    case cherry
    case pecan
}

let favoritePie = PieType.apple
let name: String
switch favoritePie {
case .apple:
    name = "Apple"
case .cherry:
    name = "Cherry"
case .pecan:
    name = "Pecan"
}

let pieRawValue = PieType.pecan.rawValue
// pieRawValue is an Int with a value of 2

if let pieType = PieType(rawValue: pieRawValue) {
    // Got a valid 'pieType'!
}
//