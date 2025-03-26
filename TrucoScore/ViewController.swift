//
//  ViewController.swift
//  TrucoScore
//
//  Created by Cauê Diniz on 27/02/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var TextFieldDupla1: UITextField!
    @IBOutlet weak var TextFieldDupla2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let matchViewController = segue.destination as? MatchViewController
        matchViewController?.Dupla1 = TextFieldDupla1.text ?? ""
        matchViewController?.Dupla2 = TextFieldDupla2.text ?? ""
        
        
    }
    
    
}

