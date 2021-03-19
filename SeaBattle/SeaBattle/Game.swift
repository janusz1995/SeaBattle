//
// Created by Iwan Skworcow on 3/18/21.
// Copyright (c) 2021 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

//extension String {
//
//    var length: Int {
//        return count
//    }
//
//    subscript (i: Int) -> String {
//        return self[i ..< i + 1]
//    }
//
//    func substring(fromIndex: Int) -> String {
//        return self[min(fromIndex, length) ..< length]
//    }
//
//    func substring(toIndex: Int) -> String {
//        return self[0 ..< max(0, toIndex)]
//    }
//
//    subscript (r: Range<Int>) -> String {
//        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
//                upper: min(length, max(0, r.upperBound))))
//        let start = index(startIndex, offsetBy: range.lowerBound)
//        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
//        return String(self[start ..< end])
//    }
//}


func printLetters() {

    let letters = " ABCDEFGHIJ"

    for character in letters {
        print(" \(character)", terminator: " ")
    }
    print("")
}

func printMap(map: Array<Array<Character>>) {

    var numberLine = 0

    printLetters()
    for i in 0..<10 {
        numberLine += 1
        if numberLine != 10 {
            print("", terminator: " ")
        }
        print("\(numberLine)", terminator: " ")
        for j in 0..<10 {
            print(" \(map[i][j])", terminator: " ")
        }
        print("")
    }
    print("")
}

//func x y XXXXXXXXX{}

func CheckX(x: Int, y: Int) -> Bool
{
    return (x < 10 && x > 0 && y > 0 && y < 10)
}

func paintRoundShip(x: Int, y: Int, map: inout Array<Array<Character>>) {


    x y && map[x][y]=='.'
    x-1 y
    x+1 y
    x-1 y-1
    x+1 y-1
    x-1 y+1
    x+1 y+1
    if (map[x][y]=="#") {
        paintRoundShip(x: x, y: y, map: map)
    }
}

func createShip(map: inout Array<Array<Character>>, points: [Int]) {

    var i: Int  = 0
    while i < points.count {
        map[points[i]][points[i + 1]] = "#"
        i += 2
    }

}



//func x y CheckKillAllShip -> Bool {}


func putShip(map: inout Array<Array<Character>>, lenShip: Int) {

    var i = 0
    var x = Int.random(in: 0..<10)
    var y = Int.random(in: 0..<10)
    let isHorisontal = Int.random(in: 0..<2)

    var numbers = Array<Int>()
//    var x = 0
//    var y = 0


//    print("x start = \(x), y start = \(y)")
//    print("x = \(x + 1), y = \(y + 1)")

    while i < lenShip {
        if x < 0 || y < 0 {
            i = 0
            numbers.removeAll()
            if x < 0 {
                x = 9
                if isHorisontal == 0 {
                    y -= 1
                }
            } else {
                y = 9
                if isHorisontal == 1 {
                    x -= 1
                }
            }
        } else if map[x][y] != "." {
            i = 0
            numbers.removeAll()
        } else {
            numbers.append(x)
            numbers.append(y)
            i += 1
            if isHorisontal == 0 {
                x -= 1
            } else {
                y -= 1
            }
        }
    }
    createShip(map: &map, points: numbers)
}



class Player {

    var playerName: String
    var map: Array<Array<Character>> = []

    let fieldLine = ".........."

    init(name: String) {
        self.playerName = name

        for _ in 0...10 {
            map.append(Array(fieldLine))
        }
    }
}


//class Player

func startGame() {

//    let _ = Player(name: "Jan")
    let player = Player(name: "Jan")
//    player.map[0][5] = "*"

    putShip(map: &player.map, lenShip: 4)
    printMap(map: player.map)


    let AI = Player(name: "AI")
//    let _ = Player(name: "AI")
    printMap(map: AI.map)















}