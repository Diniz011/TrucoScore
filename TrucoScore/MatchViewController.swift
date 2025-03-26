//
//  MatchViewController.swift
//  TrucoScore
//
//  Created by Cauê Diniz on 27/02/24.
//

import UIKit

class MatchViewController: UIViewController {
    
    
    @IBOutlet weak var labelDupla1: UILabel!
    @IBOutlet weak var labelDupla2: UILabel!
    @IBOutlet weak var labelScore1: UILabel!
    @IBOutlet weak var labelScore2: UILabel!
    @IBOutlet weak var textViewScores: UITextView!
    
    
    var Dupla1: String = ""
    var Dupla2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelDupla1.text = Dupla1.isEmpty ? "Dupla 1" : Dupla1
        labelDupla2.text = Dupla2.isEmpty ? "Dupla 2" : Dupla2
    }
    
    @IBAction func addScore1(_ sender: UIButton) {
        var score1 = Int(labelScore1.text!) ?? 0
        score1 = adicionaScore(score: score1)
        labelScore1.text = "\(score1)"
    }
    @IBAction func addScore2(_ sender: UIButton) {
        var score2 = Int(labelScore2.text!) ?? 0
        score2 = adicionaScore(score: score2)
        labelScore2.text = "\(score2)"
    }
    @IBAction func removeScore1(_ sender: UIButton) {
        var score1 = Int(labelScore1.text!) ?? 0
        score1 = removeScore(score: score1)
        labelScore1.text = "\(score1)"
    }
    @IBAction func removeScore2(_ sender: UIButton) {
        var score2 = Int(labelScore2.text!) ?? 0
        score2 = removeScore(score: score2)
        labelScore2.text = "\(score2)"
    }
    
    func adicionaScore(score: Int) -> Int {
        var newScore = score
        if newScore < 12 {
            newScore += 1
            return newScore
        }
        
        return newScore
    }
    
    func removeScore(score: Int) -> Int {
        var newScore = score
        if newScore > 0 {
            newScore -= 1
            return newScore
        }
        
        return newScore
    }
    
    
    @IBAction func endMatch(_ sender: UIButton) {
        let score1 = Int(labelScore1.text!) ?? 0
        let score2 = Int(labelScore2.text!) ?? 0
        textViewScores.text += "\(labelDupla1.text!) \t\t(\(score1))x(\(score2))\t\t \(labelDupla2.text!)\n"
        
        labelScore1.text = "0"
        labelScore2.text = "0"
    }
    
    
}
