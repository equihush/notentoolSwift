//
//  OptionsViewController.swift
//  Notentool
//
//  Created by Macbook Pro 15 on 01.03.18.
//  Copyright © 2018 Macbook Pro 15. All rights reserved.
//

import UIKit




class OptionsViewController: UIViewController {

    @IBOutlet weak var writtenTextField: UITextField!
    @IBOutlet weak var oralTextField: UITextField!
    @IBOutlet weak var editGradeCompositionButton: UIButton!
    
    
    var subject: Subject?
    var writtenToOralGradeCompositionFactor: Double {
        return
            Double(subject!.gradeComposition.written) / Double(subject!.gradeComposition.oral)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.prompt = "Composition"
        title = subject?.name
        setUIToDefaultState()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func toggleTextFieldsIsEnabled(_ sender: Any) {
        if
            "change" == editGradeCompositionButton.titleLabel?.text {
            
            writtenTextField.isEnabled = true
            oralTextField.isEnabled    = true
            // style
            writtenTextField.backgroundColor = .cyan
            oralTextField.backgroundColor    = .cyan
            writtenTextField.borderStyle     = .roundedRect
            oralTextField.borderStyle        = .roundedRect
            
            
            
            // swap button title
            editGradeCompositionButton.setTitle("save", for: .normal)
        }
        else if
            "save" == editGradeCompositionButton.titleLabel?.text {
            
            // save values
            subject!.gradeComposition.written = Int(writtenTextField.text ?? "0")!
            subject!.gradeComposition.oral    = Int(oralTextField.text ?? "0")!
            
            setUIToDefaultState()
        }
    }
    
    func setUIToDefaultState() {
        
        writtenTextField.isEnabled = false
        oralTextField.isEnabled    = false
        // style
        writtenTextField.backgroundColor = .white
        oralTextField.backgroundColor    = .white
        writtenTextField.borderStyle     = .none
        oralTextField.borderStyle        = .none
        
        // values
        writtenTextField.text = "\(subject!.gradeComposition.written)"
        oralTextField.text    = "\(subject!.gradeComposition.oral)"
        
        // dismiss keyboard
        writtenTextField.resignFirstResponder()
        oralTextField.resignFirstResponder()
        
        editGradeCompositionButton.setTitle("change", for: .normal)
    }
    

}
