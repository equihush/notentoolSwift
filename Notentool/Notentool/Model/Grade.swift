//
//  Grades.swift
//  Notentool
//
//  Created by Macbook Pro 15 on 01.03.18.
//  Copyright © 2018 Macbook Pro 15. All rights reserved.
//

import Foundation




enum GradeType: String {
    case oral, written
}

class Grade {
    let type: GradeType
    let doubleValue: Double
    let date: Date
    
    init(type: GradeType, doubleValue: Double, date: Date) {
        self.type = type
        self.doubleValue = doubleValue
        self.date = date
    }
}


extension Grade {
    var stringValue: String { return "\(doubleValue)"}
    var dateString:  String { return date.string(format: .dd_mm_yy) }
}

extension Grade {
    /*
     matches if type, doubleValue, dateString are all equal
     */
    func doesEqual(_ grade: Grade) -> Bool {
        return
            self.type == grade.type &&
            self.doubleValue == grade.doubleValue &&
            self.dateString == grade.dateString
    }
}

extension Date {
    
    enum DateFormat: String {
        // format: "dd.mm.yy"  example: "01.01.2017"
        case dd_mm_yy = "dd.MM.yy"
    }
    // format: "dd.mm.yy"  example: "01.01.2017"
    static func new(day: String, month: String, year: String) -> Date? {
        
        // let dateComponents = DateComponents(year: 1, month: 2, day: 3)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return
            dateFormatter.date(from: "\(day).\(month).\(year)")
    }
    
    
    // format: "dd.mm.yy"  example: "01.01.2017"
    func string(format: DateFormat) -> String {
        
        let dateFormatter = DateFormatter()
        let format = format.rawValue
        dateFormatter.dateFormat = format
        return
            dateFormatter.string(from: self)
    }
}
