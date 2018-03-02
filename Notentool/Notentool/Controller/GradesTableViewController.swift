//
//  GradesTableViewController.swift
//  Notentool
//
//  Created by Macbook Pro 15 on 28.02.18.
//  Copyright © 2018 Macbook Pro 15. All rights reserved.
//

import UIKit

class GradesTableViewController: UITableViewController {
    
    var subject: Subject!
    var chosenGradeType: GradeType?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = subject!.name
    }
    
    @IBAction func addGrade(_ sender: Any) {
        showChooseGradeTypeActionSheet()
    }
}




fileprivate typealias MakingNewGrade = GradesTableViewController
extension MakingNewGrade {
    
    func showChooseGradeTypeActionSheet() {
        
        let ac = UIAlertController(title: "new Grade", message: nil, preferredStyle: .actionSheet)
        let written = UIAlertAction(title: "written", style: .default) { (_) in
            self.chosenGradeType = .written
            self.showAddNewGradeAlertView(gradeType: .written)
        }
        let oral = UIAlertAction(title: "oral", style: .default) { (_) in
            self.chosenGradeType = .oral
            self.showAddNewGradeAlertView(gradeType: .oral)
        }
        ac.addAction(written)
        ac.addAction(oral)
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))

        navigationController?.present(ac, animated: true, completion: nil)
    }
    
    func showAddNewGradeAlertView(gradeType: GradeType) {
        
        var valueTextField: UITextField?
        var dateTextField: UITextField?
        
        let ac = UIAlertController(title: gradeType.rawValue, message: nil, preferredStyle: .alert)
        // grade.value
        ac.addTextField { valueTextField = $0
            valueTextField?.placeholder = "1.0"
            valueTextField?.keyboardType = .numbersAndPunctuation
        }
        // date
        ac.addTextField { dateTextField = $0
            let now = Date()
            let dateString = now.string(format: .dd_mm_yy)
            dateTextField?.text = dateString
            dateTextField?.keyboardType = .numbersAndPunctuation
        }
        let ok = UIAlertAction(title: "save", style: .default) { (_) in
            
            // get grade value
            let value = (valueTextField?.text ?? "error")
            let nr = Double(value) == nil ? 1000 : Double(valueTextField!.text!)!
            
            // get date
            let dateComponents = dateTextField!.text!.split(separator: ".").map({"\($0)"})
            let date = Date.new(day: dateComponents[0], month: dateComponents[1], year: dateComponents[2]) ?? Date.distantFuture
            
            // get gradeType: written/oral
            let gradeType: GradeType = self.chosenGradeType == .written ? .written : .oral
            let grade = Grade(type: gradeType, doubleValue: nr, date: date)
            
            // add new grade
            self.subject!.grades.append(grade)
            self.tableView.reloadData()
        }
        ac.addAction(ok)
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        navigationController?.present(ac, animated: true, completion: nil)
    }
}






fileprivate typealias TableView = GradesTableViewController
extension TableView {
    
    // cell.tap
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var grade: Grade!
        var indexOfGradeInSubjectGrades: Int!
        let row = indexPath.row
        var valueTextField: UITextField?
        var dateTextField: UITextField?
        let ac = UIAlertController(title: "change grade", message: nil, preferredStyle: .alert)
        
        
        switch indexPath.section {
        case 0:
            grade = subject!.writtenGrades[row]
            // to update grade object in subject.grades we need the index of the grade to update from subject.grades
            // index differs from indexpath.row because of multiple sections
            indexOfGradeInSubjectGrades = self.subject!.indexOf(grade: grade)!
        case 1:
            grade = subject!.oralGrades[row]
            // to update grade object in subject.grades we need the index of the grade to update from subject.grades
            // index differs from indexpath.row because of multiple sections
            indexOfGradeInSubjectGrades = self.subject!.indexOf(grade: grade)!
        default: fatalError("case not implemented for indexPath.section: \(indexPath.section)")
        }
        
        
        // grade.value
        ac.addTextField { valueTextField = $0
            valueTextField?.text = grade.stringValue
            valueTextField?.keyboardType = .numbersAndPunctuation
        }
        // date
        ac.addTextField { dateTextField = $0
            dateTextField?.text = grade.dateString
            dateTextField?.keyboardType = .numbersAndPunctuation
        }
        
        
        let save = UIAlertAction(title: "save", style: .default) { (_) in
            
            // get grade value
            let value = (valueTextField?.text ?? "error")
            let nr = Double(value) == nil ? 1000 : Double(valueTextField!.text!)!
            // get date
            let dateComponents = dateTextField!.text!.split(separator: ".").map({"\($0)"})
            let date = Date.new(day: dateComponents[0], month: dateComponents[1], year: dateComponents[2]) ?? Date.distantFuture
            // make update object
            let updatedGrade = Grade(type: grade.type, doubleValue: nr, date: date)
            
            self.subject!.grades[indexOfGradeInSubjectGrades] = updatedGrade
            
            self.tableView.reloadData()
        }
        
        let delete = UIAlertAction(title: "delete", style: .default) { (_) in
            self.subject!.grades.remove(at: indexOfGradeInSubjectGrades)
            self.tableView.reloadData()
        }
        
        ac.addAction(save)
        ac.addAction(delete)
        ac.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        self.navigationController?.present(ac, animated: true, completion: nil)
    }
    
    
    
    //  cell.info-button.taped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    }
    
    
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print(indexPath?.row)
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // written + oral
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let writtenGrades = subject!.writtenGrades.count
        let oralGrades    = subject!.oralGrades.count
        
        switch section {
        case 0: return writtenGrades
        case 1: return oralGrades
        default: fatalError("case not implemented")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var grade: Grade?
        let row  = indexPath.row

        switch indexPath.section {
        case 0: grade = subject!.writtenGrades[row]
        case 1: grade = subject!.oralGrades[row]
        default: break
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GradesTableViewController.cellIdentifier", for: indexPath)
        cell.textLabel?.text = grade!.dateString
        cell.detailTextLabel?.text = grade!.stringValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "written"
        case 1: return "oral"
        default: fatalError("case not implemented")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

