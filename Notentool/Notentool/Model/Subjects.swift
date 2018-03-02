//
//  Subjects.swift
//  Notentool
//
//  Created by Macbook Pro 15 on 01.03.18.
//  Copyright © 2018 Macbook Pro 15. All rights reserved.
//

import Foundation



class Subjects {
    static let shared = Subjects()
    
    var value = [
        math,
        Subject(name: "BWL"),
        Subject(name: "SE"),
        Subject(name: "BKOM"),
        Subject(name: "DB"),
        Subject(name: "NE"),
        Subject(name: "E"),
        Subject(name: "EDO"),
        Subject(name: "MC"),
    ]
    
    private init(){}
}



fileprivate var math: Subject = {
    let m = Subject(name: "M")
    
    m.grades = [
        Grade(type: .written, doubleValue: 2, date: Date.new(day: "01", month: "12", year: "18")!),
        Grade(type: .written, doubleValue: 3, date: Date.new(day: "01", month: "12", year: "18")!),
        Grade(type: .oral, doubleValue: 1, date: Date.new(day: "01", month: "12", year: "18")!)

    ]
    return m
}()
