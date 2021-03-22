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

func printMap(map: Array<Array<Character>>, isAI: Bool) {

    var numberLine = 0

    printLetters()
    for i in 0..<10 {
        numberLine += 1
        if numberLine != 10 {
            print("", terminator: " ")
        }
        print("\(numberLine)", terminator: " ")
        for j in 0..<10 {
            if isAI == true {
                if map[i][j] == "#" {
                    print(" .", terminator: " ")
                } else {
                    print(" \(map[i][j])", terminator: " ")
                }
            } else {
                print(" \(map[i][j])", terminator: " ")
            }
        }
        print("")
    }
    print("")
}

func checkValidpoint(x: Int, y: Int) -> Bool {
    return (x < 10 && x >= 0 && y >= 0 && y < 10)
}

func paintRoundShip(x: Int, y: Int, map: inout Array<Array<Character>>) {

    for i in -1...1 {
        for j in -1...1 {
            if checkValidpoint(x: x + i, y: y + j) == true && map[x + i][y + j] == "." {
                map[x + i][y + j] = "X"
            }
        }
    }
}

// write only 3 symbols - @ X * " " . TODO !!!!!! or write only "." if "#"

//func checkNewShip(map: inout Array<Array<Character>>, points: [Int]) -> Bool {
//
//    for num in 0..<(points.count) where num % 2 == 0 {
//        for i in -1...1 {
//            for j in -1...1 {
//                if checkValidpoint(x: points[num] + i, y: points[num + 1] + j) == true
//                           && map[points[num] + i][points[num + 1] + j] == "#" {
//                    return false
//                }
//            }
//        }
//    }
//    return true
//}

func createShip(map: inout Array<Array<Character>>, points: [Int]) {

    for i in 0..<(points.count) where i % 2 == 0 {
        map[points[i]][points[i + 1]] = "#"
    //    paintRoundShip(x: points[i], y: points[i + 1], map: &map)

    }

    for num in 0..<(points.count) where num % 2 == 0 {
        paintRoundShip(x: points[num], y: points[num + 1], map: &map)
    }
}

func putShip(map: inout Array<Array<Character>>, lenShip: Int) {

    var i = 0
    var x = Int.random(in: 0..<10)
    var y = Int.random(in: 0..<10)
    let isHorisontal = Int.random(in: 0..<2)

    while map[x][y] != "." {
        x = Int.random(in: 0..<10)
        y = Int.random(in: 0..<10)
    }
    var numbers = Array<Int>()
//    var x = 0
//    var y = 0

//
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
            if isHorisontal == 0 {
                x -= 1
            } else {
                y -= 1
            }
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
//        if (isHorisontal == 1  && (y < 0)) || (isHorisontal == 0 && x>=0){
//            x -= 1
//        } else if ( isHorisontal == 0 && (x < 0)) || (isHorisontal == 1 && y>=0) {
//            y -= 1
//        }
    }
    createShip(map: &map, points: numbers)
}

//func fillField(player: Player) {
//    for i in player.ships {
//        putShip(map: &player.map, lenShip: i)
//    }
//}

class Player {

    var shots = 0
    var isAI: Bool
    var countsShip: Int
    var playerName: String
    private var myMove: Bool
    private var map: Array<Array<Character>> = []

    private let fieldLine = ".........."
    private let ships = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]

    init(name: String, isAI: Bool) {
        self.isAI = isAI
        self.myMove = false
        self.playerName = name
        self.countsShip = ships.count
        for _ in 0...10 {
            map.append(Array(fieldLine))
        }
        fillFieldShips()
        changeMap()
    }

    func setMovePlayer(bool: Bool) {
        self.myMove = bool
    }

    func getMyMove() -> Bool {
        return self.myMove
    }

    private func fillFieldShips() {
        for i in self.ships {
            putShip(map: &self.map, lenShip: i)
        }
    }

    private func changeMap() { // TODO rename - delete helpful symbol in map! change X to dot

        for i in 0..<(self.map.count) {
            for j in 0..<(self.map[i].count) {
                if self.map[i][j] == "X" {
                    self.map[i][j] = "."
                }
            }
        }
    }

    func getMap() -> Array<Array<Character>> {
        return self.map
    }

    func makeShot(x: Int, y: Int) -> Bool {
        if self.map[x][y] == "." {
            self.map[x][y] = "*"
            print("Miss")
            self.myMove = true
            return false
        }
        else if self.map[x][y] == "#" {
            self.map[x][y] = "@"
            print("Good Job")
            self.myMove = false
            return true
        }
        return false
    }
}


//class Player

func startGame() {

    let player = Player(name: "Jan", isAI: false)

    printMap(map: player.getMap(), isAI: player.isAI)


    let AI = Player(name: "AI", isAI: true)
//    let _ = Player(name: "AI")
    printMap(map: AI.getMap(), isAI: AI.isAI)
    player.setMovePlayer(bool: true)

    for _ in 0...3 {

        if player.getMyMove() == true {
            parseCordPlayer(player: player, AI: AI)
        } else {
            print("AI Move. piu piu piu")
            player.setMovePlayer(bool: true)

        }
        printMap(map: player.getMap(), isAI: player.isAI)
        printMap(map: AI.getMap(), isAI: AI.isAI)
    }
}
//    var step = true
   // name = name?.trimmingCharacters(in: .whitespacesAndNewlines)
//    name = name?.replacingOccurrences(of: " ", with: "")
//    name?.trimmingCharacters(in: Character(" "))
//    print("\(name)")
//    while player.countsShip != 0 && AI.countsShip != 0 {
//        step += 1
//        if step == true {
//            var name = readLine()
//
//        } else {
//
//        }

//    if player.countsShip > 0 {
//        print("You WIN")
//    } else {
//        print("You are trying but You Losed ... Try again U can do it")
//    }
func checkValidLetter(inputSymbol: Character) -> Int {

    var index = 0
    let letters = "ABCDEFGHIJ"

    for sym in letters {
        if sym == inputSymbol {
            return index
        }
        index += 1
    }
    return 42
}


func getPoint(point: String?) -> (Bool, Int?, Int) {
//    var y = 0
    var x: Int?
    let str = Array(point ?? "")

    let y = checkValidLetter(inputSymbol: str[0])
    if y == 42 {
//        print("\(y)")
        return (false, 42, 42)
    }
    if str.count == 2 {
        x = Int(String(str[1]))
//        print("\(x ?? 42)")
    } else if str.count == 3 {
        x = Int(String(str[1...2]))
//        print("\(x ?? 42)")
    } else {
        print("Change points!")
        return (false, 42, 42)
    }
    x? -= 1
    return (true, x, y)
}

//func makeShot() {
//
//}

func parseCordPlayer(player: Player, AI: Player) {
    var point = readLine()
    point = point?.replacingOccurrences(of: " ", with: "")
    point = point?.uppercased()

    let (check, x, y) = getPoint(point: point)
    if check == true {
        print(" Cord X = \(x ?? 42); Cord Y = \(y) ")
        player.setMovePlayer(bool: AI.makeShot(x: x ?? 42, y: y))
    } else {
        print("Try Again: write X and Y!")
    }
}

//func getCord() {
//    parseCordPlayer()
//    if isAI == false {
//
//    } else {
//
//    }
//}









