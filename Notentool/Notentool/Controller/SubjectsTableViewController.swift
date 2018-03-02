//
//  TableViewController.swift
//  Notentool
//
//  Created by Macbook Pro 15 on 28.02.18.
//  Copyright © 2018 Macbook Pro 15. All rights reserved.
//

import UIKit



class SubjectsTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.prompt = "Grades"
        title = "Subjects"

        tableView.reloadData()
    }
    
    var subjects: [Subject] {
        return Subjects.shared.value
    }
}


extension SubjectsTableViewController {
    
   
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "SubjectsTableViewController.cellIdentifier", for: indexPath)
        
        let row = indexPath.row
        let subject = Subjects.shared.value[row]
        cell.detailTextLabel?.text = subject.averageGrade != nil ? "\(subject.averageGrade!)" : ""
        cell.textLabel?.text = subject.name
        cell.accessoryType = .detailButton
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension SubjectsTableViewController {
    // taped info-button
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: String(describing: OptionsViewController.self)) as! OptionsViewController
        vc.subject = Subjects.shared.value[indexPath.row]
        navigationController?.show(vc, sender: self)
        
    }
    // transition -> GradesTableViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = navigationController?.storyboard?.instantiateViewController(withIdentifier: String(describing: GradesTableViewController.self)) as! GradesTableViewController
        
        let subject = subjects[indexPath.row]
        vc.subject = subject
        
        navigationController?.show(vc, sender: self)
    }
}






