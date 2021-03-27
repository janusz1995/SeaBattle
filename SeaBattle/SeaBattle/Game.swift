//
// Created by Iwan Skworcow on 3/18/21.
// Copyright (c) 2021 ___FULLUSERNAME___. All rights reserved.
//

import Foundation
//public typealias TerminalStyleCode = (open: String, close: String)

func printLetters() {

    let letters = " ABCDEFGHIJ"

    for character in letters {
        print(" \(character)", terminator: " ")
    }
    print("")
}

func printMap(map: Array<Array<Character>>, isAI: Bool) {

    var numberLine = 0

    if isAI == false {
        print("-----------Your Field-----------".green())
    } else {
        print("-----------Enemy Field----------".red())
    }
    printLetters()
    for i in 0..<10 {
        numberLine += 1
        if numberLine != 10 {
            print("", terminator: " ")
        }
        print("\(numberLine)", terminator: " ")
        for j in 0..<10 {
            if isAI == true {
                if map[i][j] == "#" { // .cornflowerBlue
                    print(" .", terminator: " ")
                } else if map[i][j] == "@" {
                    print(" \(map[i][j])".lightRed(), terminator: " ")
                } else {
                    print(" \(map[i][j])", terminator: " ")
                }
            } else {
                if map[i][j] == "#" {
                    print(" \(map[i][j])".lightGreen(), terminator: " ")
                } else {
                    print(" \(map[i][j])", terminator: " ")
                }
            }
        }
        print("")
    }
    if isAI == true {
        print("--------------------------------")
    }
}

// write only 3 symbols - @ X * " " . TODO !!!!!! or write only "." if "#"

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

    private var hit = false
    private var dir = Array<Int>()
    private var dirX: Int = 0
    private var dirY: Int = 0


    private var myMove: Bool
    private var shipIsAlive = true
    private var ships: Array<Ship> = []
    private var messages: [String] = []
    private var map: Array<Array<Character>> = []

    private let fieldLine = ".........."
    private let lengthsOfShips = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]

    init(name: String, isAI: Bool) {
        self.isAI = isAI
        self.myMove = false
        self.playerName = name
        self.aliveShips = lengthsOfShips.count

        for _ in 0..<10 {
            map.append(Array(fieldLine))
        }
        fillFieldShips()
        removeHelpfulSymInMap()
    }

    func printMessages() {
        for mg in messages {
            print("\(mg)")
        }
        messages.removeAll()
    }

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

    private func checkDeathShip(x: Int, y: Int, AI: Player) {
        for ship in ships {
            if ship.isAlive() == true {
                for i in 0..<ship.arrPoints.count where i % 2 == 0 {
                    if ship.arrPoints[i] == x && ship.arrPoints[i + 1] == y {
                        ship.minusLenShip()
                        if ship.isAlive() == false {
                            aliveShips -= 1
                            if isAI == false {
                                AI.dirX = 0
                                AI.dirY = 0
                                AI.dir.removeAll()
                                AI.hit = false
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
    }

    func addMessage(message: String) {
        self.messages.append(message)
    }

    // take damage
    func takeDamage(x: Int, y: Int, AI: Player) -> Bool {
        if self.map[x][y] == "." {
            self.map[x][y] = "*"
            if self.isAI == false {
                if AI.dirX != 0 || AI.dirY != 0 {
                    AI.dirX = -AI.dirX
                    AI.dirY = -AI.dirY
                    AI.dir[0] = x
                    AI.dir[1] = y
                    while map[AI.dir[0] + AI.dirX][AI.dir[1] + AI.dirY] == "@" {
                        AI.dir[0] += AI.dirX
                        AI.dir[1] += AI.dirY
                    }
                }
                else if AI.dir.count == 0 {
                    AI.hit = false
                }
                messages.append("Computer Missed!")
            } else {
//                else if self.dir.count == 0 {
//                    AI.hit = false
//                }
                messages.append("You Missed!")
            }
            return false
        }
        else if self.map[x][y] == "#" {
            self.map[x][y] = "@"

            if isAI == false {
                AI.hit = true
                if AI.dir.count == 2 {
                    AI.dirX = x - AI.dir[0]
                    AI.dirY = y - AI.dir[1]
                    AI.dir[0] = x
                    AI.dir[1] = y
                } else {
                    AI.dir.append(x)
                    AI.dir.append(y)
                }
                messages.append("Computer hit your ship!")
            } else {
//                if dir.count == 2 {
//                    dirX = x - dir[0]
//                    dirY = y - dir[1]
//                    dir[0] = x
//                    dir[1] = y
//                } else {
//                    dir.append(x)
//                    dir.append(y)
//                }
                messages.append("You hit computer ship!")
            }
            checkDeathShip(x: x, y: y, AI: AI)
            return true
        } else {
            // TODO What are you doing?
            print("WTF")
        }
        return false
    }


    private func getAgFree(player: inout Player) -> () {
        if true {

        }
    }

    func makeShotAI(player: inout Player) {
        var x = Int.random(in: 0..<10)
        var y = Int.random(in: 0..<10)


        if hit == true {
            x = dir[0]
            y = dir[1]
            if dirX != 0 || dirY != 0 {
                if dir[0] + dirX >= 0 && dir[0] + dirX < 10 {
                    x = dir[0] + dirX
                }
                if dir[1] + dirY >= 0 && dir[1] + dirY < 10 {
                    y = dir[1] + dirY
                }
                if x == dir[0] && y == dir[1] {
                    dirX = -dirX
                    dirY = -dirY
                    while player.getMap()[dir[0]][dir[1]] == "@" {
                        dir[0] += dirX
                        dir[1] += dirY
                    }
                }
            } else if x - 1 >= 0 && player.getMap()[x - 1][y] != "*" && player.getMap()[x - 1][y] != "@" && player.getMap()[x - 1][y] != "X" {
                x -= 1
            } else if x + 1 < 10 && player.getMap()[x + 1][y] != "*" && player.getMap()[x + 1][y] != "@" && player.getMap()[x + 1][y] != "X" {
                x += 1
            } else if y + 1 < 10 && player.getMap()[x][y + 1] != "*" && player.getMap()[x][y + 1] != "@" && player.getMap()[x][y + 1] != "X" {
                y += 1
            } else if y - 1 >= 0 && player.getMap()[x][y - 1] != "*" && player.getMap()[x][y - 1] != "@" && player.getMap()[x][y - 1] != "X" {
                y -= 1
            }
//            if dir.count != 0 {
//
//            } else {
//
//            }

        } else {
            while player.getMap()[x][y] == "@" || player.getMap()[x][y] == "X" || player.getMap()[x][y] == "*" {
                x = Int.random(in: 0..<10)
                y = Int.random(in: 0..<10)
            }
        }

        let check = player.takeDamage(x: x, y: y, AI: self)
        if check == false {
            player.setMove(bool: true)
//            player.setMove(bool: false)
        }


    }
//    func makeShotAI(player: Player) {
//
//
//        var x = Int.random(in: 0..<10)
//        var y = Int.random(in: 0..<10)
//
//        // let (x, y) = generateXandY()
//        while player.getMap()[x][y] != "." && player.getMap()[x][y] != "#" {
//            x = Int.random(in: 0..<10)
//            y = Int.random(in: 0..<10)
//        }
////    print("X ai = \(x), Y ai = \(y)")
//
//        let check = player.takeDamage(x: x, y: y)
//        if check == false {
//            player.setMove(bool: true)
//        }
//
//    }

}

func startGame() {

    var player = Player(name: "Jan", isAI: false)
    let AI = Player(name: "AI", isAI: true)

    player.setMove(bool: true)

    // game circle

    while player.aliveShips != 0 && AI.aliveShips != 0 {
//
//        for item in AI.getShips() {
//            print("\(item.getLenShip()) = \(item.arrPoints)")
//        }

//        AI.printMessages()
//        if player.getMyMove() == true {
//            printMap(map: player.getMap(), isAI: player.isAI)
//            printMap(map: AI.getMap(), isAI: AI.isAI)
////            AI.printMessages()
//            AI.printMessages()
//            player.printMessages()
//            print("Please enter X and Y: ", terminator: "")
//        }

//        if AI.getHit() == false && player.getMyMove() == true {
////            AI.printMessages()
////            player.printMessages()
////            print("Please enter X and Y: ", terminator: "")
//        }

        if player.getMyMove() == true {
            printMap(map: player.getMap(), isAI: player.isAI)
            printMap(map: AI.getMap(), isAI: AI.isAI)
            AI.printMessages()
            player.printMessages()
            print("Please enter X and Y: ", terminator: "")
            parseCordPlayer(player: player, AI: AI)
        } else {
            AI.makeShotAI(player: &player)
        }

    }

    printMap(map: player.getMap(), isAI: player.isAI)
    printMap(map: AI.getMap(), isAI: AI.isAI)

    if player.aliveShips > 0 {
        print("You WIN! :]")
    } else {
        print("You Lose :(")
    }
}

//func makeShotAI(player: Player) {
//
//
//    var x = Int.random(in: 0..<10)
//    var y = Int.random(in: 0..<10)
//
//    // let (x, y) = generateXandY()
//    while player.getMap()[x][y] == "@" || player.getMap()[x][y] == "X" || player.getMap()[x][y] == "*" {
//        x = Int.random(in: 0..<10)
//        y = Int.random(in: 0..<10)
//    }
////    print("X ai = \(x), Y ai = \(y)")
//
//    let check = player.takeDamage(x: x, y: y, player: self)
//    if check == false {
//        player.setMove(bool: true)
//    }
//
//}

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
//    print(str.count)
    if str.count != 0 {
        y = checkValidLetter(inputSymbol: str[0])
    }

    if y == 42 {
        return (false, x, y)
    }
    if str.count == 2 && str[1].isNumber {
        x = Int(String(str[1]))!
//        print("\(x ?? 42)")
    } else if str.count == 3 && str[1] == "1" && str[2] == "0" {
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
//        print(" Cord X = \(x); Cord Y = \(y) ")
        player.setMove(bool: AI.takeDamage(x: x, y: y, AI: AI))
    } else {
        player.addMessage(message: "Please enter VALID X and Y!")
    }
}


// TODO - array messages

