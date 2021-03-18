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
    player.map[0][5] = "*"

    printMap(map: player.map)



    let AI = Player(name: "AI")
//    let _ = Player(name: "AI")
    printMap(map: AI.map)

//    player.playerName = ("")

//    var mapPlayer = [
//        "..........",
//        "..........",
//        "..........",
//        "..........",
//        "..........",
//        "..........",
//        "..........",
//        "..........",
//        "..........",
//        ".........."]

//    var mapAI = mapPlayer

//var players: [Player] = []

//players.append()














}