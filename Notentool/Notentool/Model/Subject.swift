//
//  Subject.swift
//  Notentool
//
//  Created by Macbook Pro 15 on 01.03.18.
//  Copyright © 2018 Macbook Pro 15. All rights reserved.
//

import Foundation

//extension Array where Element == Double {
//    func averaged() -> Double {
//        return
//            reduce(0.0, { $0 + $1}) / Double(count)
//    }
//}



class Subject {
    
    let name: String
    
    var writtenGrades: [Grade] { return grades.filter({$0.type == .written}) }
    var oralGrades:    [Grade] { return grades.filter({$0.type == .oral}) }
    var grades:        [Grade] = []
    var gradeComposition = GradeComposition()

    
    
    init(name: String) {
        self.name = name
    }
    
    
    var averageGrade: Double? {
        if
            writtenGrades.count > 0 && oralGrades.count > 0 {
            
            let averageWrittenGrade = writtenGrades.reduce(0.0, {$0 + $1.doubleValue}) / Double(writtenGrades.count)
            let averageOralGrade    = oralGrades.reduce(0.0, {$0 + $1.doubleValue})    / Double(oralGrades.count)
            
            let wFactor = Double(gradeComposition.written) / 100.0
            let oFactor = Double(gradeComposition.oral) / 100.0
            
            let partW = averageWrittenGrade * wFactor
            let parO  = averageOralGrade * oFactor
            
            let average = partW + parO
            
            return average
        }
            
        else if oralGrades.isEmpty && writtenGrades.count > 0  {
           
            let writtenGrades        = self.writtenGrades
            let sumedWrittenGrades   = writtenGrades.reduce(0.0, {$0 + $1.doubleValue})
            let averageWrittenGrades = sumedWrittenGrades / Double(writtenGrades.count)
            return averageWrittenGrades
        }
        return nil
    }
    
    // enumerates through subject.grades finding the index of the grade matching the given object
    func indexOf(grade: Grade) -> Int? {
        var indexOfGradeInSubject: Int?
        
        self.grades.enumerated().forEach { //let index = $0, let _grade = $1
            // find grade that matches dateString
            //if _grade.dateString == grade.dateString { indexOfGradeInSubject = index }
            if $1.doesEqual(grade) { indexOfGradeInSubject = $0 }
        }
        return indexOfGradeInSubject
    }
    
//    var averageWrittenOralGrade: Double? {
//        if writtenGrades.count > 0 {
//            return writtenGrades.reduce(0.0, { $0 + $1.doubleValue}) / Double(writtenGrades.count)
//        }
//        return nil
//    }
//    var averageOralGrade: Double? {
//        if oralGrades.count > 0 {
//            return
//                oralGrades.reduce(0.0, { $0 + $1.doubleValue}) / Double(oralGrades.count)
//        }
//        return nil
//    }
    
}
