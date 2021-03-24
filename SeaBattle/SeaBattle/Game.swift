//
// Created by Iwan Skworcow on 3/18/21.
// Copyright (c) 2021 ___FULLUSERNAME___. All rights reserved.
//

import Foundation

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

//func putShip(map: inout Array<Array<Character>>, lenShip: Int) {
//
//    var i = 0
//    var x = Int.random(in: 0..<10)
//    var y = Int.random(in: 0..<10)
//    let isHorisontal = Int.random(in: 0..<2)
//
//    while map[x][y] != "." {
//        x = Int.random(in: 0..<10)
//        y = Int.random(in: 0..<10)
//    }
//    var numbers = Array<Int>()
////    var x = 0
////    var y = 0
//
////
////    print("x start = \(x), y start = \(y)")
////    print("x = \(x + 1), y = \(y + 1)")
//
//    while i < lenShip {
//        if x < 0 || y < 0 {
//            i = 0
//            numbers.removeAll()
//            if x < 0 {
//                x = 9
//                if isHorisontal == 0 {
//                    y -= 1
//                }
//            } else {
//                y = 9
//                if isHorisontal == 1 {
//                    x -= 1
//                }
//            }
//        } else if map[x][y] != "." {
//            i = 0
//            numbers.removeAll()
//            if isHorisontal == 0 {
//                x -= 1
//            } else {
//                y -= 1
//            }
//        } else {
//            numbers.append(x)
//            numbers.append(y)
//            i += 1
//            if isHorisontal == 0 {
//                x -= 1
//            } else {
//                y -= 1
//            }
//        }
//    }
//    createShip(map: &map, points: numbers)
//}

//func fillField(player: Player) {
//    for i in player.ships {
//        putShip(map: &player.map, lenShip: i)
//    }
//}

class Ship {

    var arrPoints = Array<Int>()

    private var lengthShip: Int
    private var shipIsAlive = true

    init(lenShip: Int) {
        self.lengthShip = lenShip
    }

    func isAlive() -> Bool {
        return self.shipIsAlive
    }

    func getLenShip() -> Int {
        return self.lengthShip
    }

    func putShip(map: inout Array<Array<Character>>) {

        var i = 0
        var points = Array<Int>()
        var x = Int.random(in: 0..<10)
        var y = Int.random(in: 0..<10)
        let isHorisontal = Int.random(in: 0..<2)

        while map[x][y] != "." {
            x = Int.random(in: 0..<10)
            y = Int.random(in: 0..<10)
        }
//    print("x start = \(x), y start = \(y)")
//    print("x = \(x + 1), y = \(y + 1)")

        while i < lengthShip {
            if x < 0 || y < 0 {
                i = 0
                points.removeAll()
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
                points.removeAll()
                if isHorisontal == 0 {
                    x -= 1
                } else {
                    y -= 1
                }
            } else {
                points.append(x)
                points.append(y)
                i += 1
                if isHorisontal == 0 {
                    x -= 1
                } else {
                    y -= 1
                }
            }
        }

        arrPoints = points
        createShip(map: &map, points: points)
        paintAroundShip(map: &map, points: points)
    }

    func paintAroundShip(map: inout Array<Array<Character>>, points: [Int]) {
        for num in 0..<(points.count) where num % 2 == 0 {
            paintAroundShipPoint(x: points[num], y: points[num + 1], map: &map)
        }
    }

    private func createShip(map: inout Array<Array<Character>>, points: [Int]) {
        for i in 0..<(points.count) where i % 2 == 0 {
            map[points[i]][points[i + 1]] = "#"
        }
    }

    private func paintAroundShipPoint(x: Int, y: Int, map: inout Array<Array<Character>>) {
        for i in -1...1 {
            for j in -1...1 {
                if checkValidpoint(x: x + i, y: y + j) == true && (map[x + i][y + j] == "." || map[x + i][y + j] == "*" ){
                    map[x + i][y + j] = "X"
                }
            }
        }
    }

    private func checkValidpoint(x: Int, y: Int) -> Bool {
        return (x < 10 && x >= 0 && y >= 0 && y < 10)
    }

    func minusLenShip() {
        if 0 < lengthShip {
            lengthShip -= 1
        }
        if lengthShip == 0 {
            self.shipIsAlive = false
        }
    }
}


class Player {

    var isAI: Bool
    var aliveShips: Int
    var playerName: String

//    private var dir: Int
//    private var firstHit: (Int, Int)
//    private var lastHit: (Int, Int)
    private var messages: [String] = []

    private var myMove: Bool
    private var shipIsAlive = true
    private var ships = Array<Ship>()
    private var map: Array<Array<Character>> = []

    private let fieldLine = ".........."
    private let lengthsOfShips = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]

    init(name: String, isAI: Bool) {
        self.isAI = isAI
        self.myMove = false
        self.playerName = name
        self.aliveShips = lengthsOfShips.count

        for _ in 0...10 {
            map.append(Array(fieldLine))
        }

//        setDefaultFirstHit()
        fillFieldShips()
        removeHelpfulSymInMap()
    }

    func printMessages() {
        for mg in messages {
            print("\(mg)")
        }
        messages.removeAll()
    }
//    private func setDefaultFirstHit() {
//        self.firstHit = (-1, -1)
//    }

    func setMove(bool: Bool) {
        self.myMove = bool
    }

    func getMyMove() -> Bool {
        return self.myMove
    }

    private func fillFieldShips() {
        for i in self.lengthsOfShips {
           self.ships.append(Ship(lenShip: i))
        }

        for it in self.ships {
            it.putShip(map: &map)
        }
    }

    private func removeHelpfulSymInMap() {
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

    // TODO - DELETE WHEN FINISHED, THIS IS Help Getter!
    func getShips() -> Array<Ship> {
        return ships
    }

    private func checkDeathShip(x: Int, y: Int) {
        for ship in ships {
            if ship.isAlive() == true {
                for i in 0..<ship.arrPoints.count where i % 2 == 0 {
                    if ship.arrPoints[i] == x && ship.arrPoints[i + 1] == y {
                        ship.minusLenShip()
                        if ship.isAlive() == false {
                            aliveShips -= 1
                            if isAI == false {
                                messages.append("Computer killed your ship!")
                            } else {
                                messages.append("You killed computer ship!")
                            }
                            ship.paintAroundShip(map: &map, points: ship.arrPoints)
                        }
                        break;
                    }
                }
            }
        }
        //
    }

    // take damage
    func takeDamage(x: Int, y: Int) -> Bool {
        if self.map[x][y] == "." {
            self.map[x][y] = "*"
//            messages.append("Miss")
            if self.isAI == false {
                messages.append("Computer Missed!")
            } else {
                messages.append("You Missed!")
            }
//            print("Miss")
//            self.myMove = true
            return false
        }
        else if self.map[x][y] == "#" {
            self.map[x][y] = "@"
//            if isAI == true {
//                if firstHit != (-1, -1) {
//                    firstHit = (x, y)
//                }
//                lastHit = ()
//            }
            if isAI == false {
                messages.append("Computer hit your ship!")
            } else {
                messages.append("You hit computer ship!")
            }
            checkDeathShip(x: x, y: y)
//            print("Good Job!")
//            self.myMove = false
            return true
        } else {
            // TODO What are you doing?
            print("WTF")
        }
        return false
    }
}

func startGame() {

    let player = Player(name: "Jan", isAI: false)
//    printMap(map: player.getMap(), isAI: player.isAI)

    let AI = Player(name: "AI", isAI: true)
//    printMap(map: AI.getMap(), isAI: AI.isAI)

    player.setMove(bool: true)

    // game circle
    while player.aliveShips != 0 && AI.aliveShips != 0 {

        for item in AI.getShips() {
            print("\(item.getLenShip()) = \(item.arrPoints)")
        }

        if player.getMyMove() == true {
            printMap(map: player.getMap(), isAI: player.isAI)
            printMap(map: AI.getMap(), isAI: AI.isAI)
            AI.printMessages()
        } else {
            player.printMessages()
        }

        if player.getMyMove() == true {
            parseCordPlayer(player: player, AI: AI)
        } else {
            print("AI Move. piu piu piu")
            makeShotAI(player: player)
//            player.setMove(bool: true)
        }

    }

    if player.aliveShips > 0 {
        print("You WIN! :]")
    } else {
        print("You Lose :(")
    }

}

func makeShotAI(player: Player) {


    var x = Int.random(in: 0..<10)
    var y = Int.random(in: 0..<10)

    // let (x, y) = generateXandY()
    while player.getMap()[x][y] != "." && player.getMap()[x][y] != "#" {
        x = Int.random(in: 0..<10)
        y = Int.random(in: 0..<10)
    }
    print("X ai = \(x), Y ai = \(y)")

    let check = player.takeDamage(x: x, y: y)
    if check == false {
        player.setMove(bool: true)
    }

}

//func generateXandY() -> (Int, Int) {
//}

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

func getPoint(point: String?) -> (Bool, Int, Int) {

    var x = 42
    var y = 42
    let str = Array(point ?? "")
    print(str.count)
    if str.count != 0 {
        y = checkValidLetter(inputSymbol: str[0])
    }

    if y == 42 {
        return (false, x, y)
    }
    if str.count == 2 && str[1].isNumber {
        x = Int(String(str[1]))!
//        print("\(x ?? 42)")
    } else if str.count == 3 && str[1].isNumber && str[2].isNumber {
        x = Int(String(str[1...2]))!
//        print("\(x ?? 42)")
    } else {
        return (false, x, y)
    }
    x -= 1
    return (true, x, y)
}

func parseCordPlayer(player: Player, AI: Player) {

    var point = readLine()

    point = point?.replacingOccurrences(of: " ", with: "")
    point = point?.uppercased()

    let (check, x, y) = getPoint(point: point)
    if check == true {
        print(" Cord X = \(x); Cord Y = \(y) ")
        player.setMove(bool: AI.takeDamage(x: x, y: y))
    } else {
//        player.
        print("Please enter VALID X and Y!")
    }
}


// TODO - array messages

