//
// Created by Iwan Skworcow (drina) on 3/27/21.
// Copyright (c) 2021 Iwan Skworcow. All rights reserved.
//

import Foundation

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

    private let fieldLine = "          "
    private let lengthsOfShips = [4, 3, 3, 2, 2, 2, 1, 1, 1, 1]

    init(name: String, isAI: Bool) {
        self.isAI = isAI
        myMove = false
        playerName = name
        aliveShips = lengthsOfShips.count

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
        myMove = bool
    }

    func getMyMove() -> Bool {
        myMove
    }

    private func fillFieldShips() {
        for i in lengthsOfShips {
            ships.append(Ship(lenShip: i))
        }

        for it in ships {
            it.putShip(map: &map)
        }
    }

    private func removeHelpfulSymInMap() {
        for i in 0..<(map.count) {
            for j in 0..<(map[i].count) {
                if map[i][j] == DEATH_SHIP {
                    map[i][j] = EMPTY_POINT
                }
            }
        }
    }

    func getMap() -> Array<Array<Character>> {
        map
    }

    // TODO - DELETE WHEN FINISHED, THIS IS Help Getter!
//    func getShips() -> Array<Ship> {
//        return ships
//    }

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
        messages.append(message)
    }

    func takeDamage(x: Int, y: Int, AI: Player) -> Bool {
        if map[x][y] == EMPTY_POINT {
            map[x][y] = MISS
            if isAI == false {
                if AI.dirX != 0 || AI.dirY != 0 {
                    AI.dirX = -AI.dirX
                    AI.dirY = -AI.dirY
                    AI.dir[0] = x
                    AI.dir[1] = y
                    while map[AI.dir[0] + AI.dirX][AI.dir[1] + AI.dirY] == HIT_SHIP {
                        AI.dir[0] += AI.dirX
                        AI.dir[1] += AI.dirY
                    }
                }
                else if AI.dir.count == 0 {
                    AI.hit = false
                }
                messages.append("Computer Missed!")
            } else {
                messages.append("You Missed!")
            }
            return false
        }
        else if map[x][y] == ALIVE_SHIP {
            map[x][y] = HIT_SHIP

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
                messages.append("You hit computer ship!")
            }
            checkDeathShip(x: x, y: y, AI: AI)
            return true
        } else {
            messages.append("You've already shot here!")
            if isAI == false {
                return false
            }
            else {
                return true
            }

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
                    while player.getMap()[dir[0] + dirX][dir[1] + dirY] == HIT_SHIP {
                        dir[0] += dirX
                        dir[1] += dirY
                    }
                }
            } else if x - 1 >= 0 && checkPoints(x: x - 1, y: y, player: player) {
                x -= 1
            } else if x + 1 < 10 && checkPoints(x: x + 1, y: y, player: player) {
                x += 1
            } else if y + 1 < 10 && checkPoints(x: x, y: y + 1, player: player) {
                y += 1
            } else if y - 1 >= 0 && checkPoints(x: x, y: y - 1, player: player) {
                y -= 1
            }
        } else {
            while player.getMap()[x][y] == HIT_SHIP || player.getMap()[x][y] == DEATH_SHIP || player.getMap()[x][y] == MISS {
                x = Int.random(in: 0..<10)
                y = Int.random(in: 0..<10)
            }
        }

        let check = player.takeDamage(x: x, y: y, AI: self)
        if check == false {
            player.setMove(bool: true)
        }
    }

    private func checkPoints(x: Int, y: Int, player: Player) -> Bool {
        (player.getMap()[x][y] != MISS && player.getMap()[x][y] != HIT_SHIP &&
                player.getMap()[x][y] != DEATH_SHIP)
    }
}