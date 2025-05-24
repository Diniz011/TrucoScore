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
      
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let matchViewController = segue.destination as? MatchViewController
        matchViewController?.Dupla1 = TextFieldDupla1.text ?? ""
        matchViewController?.Dupla2 = TextFieldDupla2.text ?? ""
        
        
    }
    
    @IBAction func iniciarPartida(_ sender: UIButton) {
        guard let dupla1 = TextFieldDupla1.text, !dupla1.isEmpty,
              let dupla2 = TextFieldDupla2.text, !dupla2.isEmpty else {
            let alert = UIAlertController(title: "Campos obrigatórios", message: "Por favor, preencha os nomes das duas duplas antes de iniciar a partida.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        performSegue(withIdentifier: "iniciarPartida", sender: sender)
    }
    
}
