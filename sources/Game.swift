//
// Created by Iwan Skworcow (drina) on 3/18/21.
// Copyright (c) 2021 Iwan Skworcow. All rights reserved.
//

import Foundation

public let ERROR = 42
public let MISS: Character = "*"
public let HIT_SHIP: Character = "@"
public let DEATH_SHIP: Character = "X"
public let ALIVE_SHIP: Character = "#"
public let EMPTY_POINT: Character = " "


func start() {
    let game = Game()
    game.startGame()
}

class Game {

    private func printLetters() {

        let letters = " ABCDEFGHIJ"

        for character in letters {
            print(" \(character)", terminator: " ")
        }
        print("")
    }

    private func printMap(map: Array<Array<Character>>, isAI: Bool) {

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
                    if map[i][j] == ALIVE_SHIP {
                        print("  ", terminator: " ")
                    } else if map[i][j] == HIT_SHIP {
                        print(" \(map[i][j])".lightRed(), terminator: " ")
                    } else {
                        print(" \(map[i][j])", terminator: " ")
                    }
                } else {
                    if map[i][j] == ALIVE_SHIP {
                        print(" \(map[i][j])".lightGreen(), terminator: " ")
                    } else if map[i][j] == HIT_SHIP {
                        print(" \(map[i][j])".lightRed(), terminator: " ")
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

    func startGame() {

        var player = Player(name: "Jan", isAI: false)
        let AI = Player(name: "AI", isAI: true)

        player.setMove(bool: true)

        while player.aliveShips > 0 && AI.aliveShips > 0 {

            if player.getMyMove() == true {
                printMap(map: player.getMap(), isAI: player.isAI)
                printMap(map: AI.getMap(), isAI: AI.isAI)
                AI.printMessages()
                player.printMessages()
                print("Please enter X and Y (example - h7): ", terminator: "")
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

    private func checkValidLetter(inputSymbol: Character) -> Int {

        var index = 0
        let letters = "ABCDEFGHIJ"

        for sym in letters {
            if sym == inputSymbol {
                return index
            }
            index += 1
        }
        return ERROR
    }

    private func getPoint(point: String?) -> (Bool, Int, Int) {

        var x = ERROR
        var y = ERROR
        let str = Array(point ?? "")

        if str.count != 0 {
            y = checkValidLetter(inputSymbol: str[0])
        }

        if y == ERROR {
            return (false, x, y)
        }
        if str.count == 2 && str[1].isNumber && str[1] != "0" {
            x = Int(String(str[1]))!
        } else if str.count == 3 && str[1] == "1" && str[2] == "0" {
            x = Int(String(str[1...2]))!
        } else {
            return (false, x, y)
        }
        x -= 1
        return (true, x, y)
    }

    private func parseCordPlayer(player: Player, AI: Player) {

        var point = readLine()

        point = point?.replacingOccurrences(of: " ", with: "")
        point = point?.uppercased()

        let (check, x, y) = getPoint(point: point)

        if check == true {
            player.setMove(bool: AI.takeDamage(x: x, y: y, AI: AI))
        } else {
            player.addMessage(message: "Please enter VALID X and Y!")
        }
    }
}