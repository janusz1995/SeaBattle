//
// Created by Iwan Skworcow (drina) on 3/27/21.
// Copyright (c) 2021 Iwan Skworcow. All rights reserved.
//

import Foundation

class Ship {

    var arrPoints = Array<Int>()
    private var lengthShip: Int
    private var shipIsAlive = true

    init(lenShip: Int) {
        lengthShip = lenShip
    }

    func isAlive() -> Bool {
        shipIsAlive
    }

    func getLenShip() -> Int {
        lengthShip
    }

    func putShip(map: inout Array<Array<Character>>) {

        var i = 0
        var points = Array<Int>()
        var x = Int.random(in: 0..<10)
        var y = Int.random(in: 0..<10)
        let isHorisontal = Int.random(in: 0..<2)

        while map[x][y] != EMPTY_POINT {
            x = Int.random(in: 0..<10)
            y = Int.random(in: 0..<10)
        }

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
            } else if map[x][y] != EMPTY_POINT {
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
            map[points[i]][points[i + 1]] = ALIVE_SHIP
        }
    }

    private func paintAroundShipPoint(x: Int, y: Int, map: inout Array<Array<Character>>) {
        for i in -1...1 {
            for j in -1...1 {
                if checkValidPoint(x: x + i, y: y + j) == true && (map[x + i][y + j] == EMPTY_POINT || map[x + i][y + j] == MISS) {
                    map[x + i][y + j] = DEATH_SHIP
                }
            }
        }
    }

    private func checkValidPoint(x: Int, y: Int) -> Bool {
        (x < 10 && x >= 0 && y >= 0 && y < 10)
    }

    func minusLenShip() {
        if 0 < lengthShip {
            lengthShip -= 1
        }
        if lengthShip == 0 {
            shipIsAlive = false
        }
    }
}
