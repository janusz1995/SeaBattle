//
//  main.swift
//  SeaBattle
//
//  Created by Iwan Skworcow on 3/16/21.
//  Copyright © 2021 Iwan Skworcow. All rights reserved.
//

import Foundation

let world = "drina"
let horz = "abcdefghij"
//let vert: String = "0123456789"
//var list_arr: Array<Array<Int>> = (10)

var map = [
    "abcdefghij",
    "..........",
    "..........",
    "..........",
    "..........",
    "..........",
    "..........",
    "..........",
    "..........",
    "..........",
    ".........."]
//var i = 0
var count = 0

for i in map {
    if i == map[0] {
        print("  ", terminator: "")
        for character in i {
            print(" \(character)", terminator: "")
        }
    }
    else {
        count += 1
        if count != 10 {
            print(" ", terminator: "")
        }
        print("\(count)", terminator: "")
        for character in i {
            print(" \(character)", terminator: "")
        }
    }
    print("")
}

//    if i == 0 {
//        print("\(horz)")
//    }
//    print("\(Int(i + 1)) \(arr[count ..< count + 10])")
//
//    count += 10
//    i += 1
//for i in 1...10 {
//    print("\(i)")
//    list_arr.append(arr);
//}

//var arr = [Int](_ :0, _: 10)

//print("\(arr)")

//print("Hello, World!")
