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
        textViewScores.backgroundColor = .clear
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

        guard score1 == 12 || score2 == 12 else { return }
        let vencedor = score1 == 12 ? (labelDupla1.text ?? "") : (labelDupla2.text ?? "")

        let linhaResultado = "\(labelDupla1.text!)\t(\(score1))x(\(score2))\t\(labelDupla2.text!)\n"
        let linhaSeparadora = "🏆 Vencedor: \(vencedor)\n-----------------------------\n"
        let linhaCompleta = linhaResultado + linhaSeparadora

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributedString = NSMutableAttributedString(string: linhaCompleta, attributes: [
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18)
        ])

        // Append to textViewScores
        let currentText = textViewScores.attributedText ?? NSAttributedString(string: "")
        let mutable = NSMutableAttributedString(attributedString: currentText)
        mutable.append(attributedString)
        textViewScores.attributedText = mutable

        let numberOfLines = textViewScores.text.components(separatedBy: "\n").count
        if numberOfLines > 10 {
            textViewScores.text = ""
        }

        labelScore1.text = "0"
        labelScore2.text = "0"

        // Lógica para contar vitórias e exibir alerta de melhor de 3
        let allLines = textViewScores.text.components(separatedBy: "\n")
        let vencedores = allLines.filter { $0.contains("🏆 Vencedor:") }
        if vencedores.count == 3 {
            let countDupla1 = vencedores.filter { $0.contains(labelDupla1.text ?? "") }.count
            let countDupla2 = vencedores.filter { $0.contains(labelDupla2.text ?? "") }.count

            var vencedorFinal = ""
            if countDupla1 > countDupla2 {
                vencedorFinal = labelDupla1.text ?? ""
            } else {
                vencedorFinal = labelDupla2.text ?? ""
            }

            let alerta = UIAlertController(title: "Fim de Jogo!", message: "🏆 \(vencedorFinal) venceu melhor de 3!\nPlacar final: \(countDupla1)x\(countDupla2)", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Começar outra partida", style: .default, handler: { _ in
                self.labelScore1.text = "0"
                self.labelScore2.text = "0"
                self.textViewScores.text = ""
            }))
            self.present(alerta, animated: true)

            // Vibrar o dispositivo
            let feedback = UINotificationFeedbackGenerator()
            feedback.notificationOccurred(.error)
            self.exibirAnimacaoVitoria(dupla: vencedorFinal)
        }
    }
    
    func exibirAnimacaoVitoria(dupla: String) {
        let animView = UIView(frame: self.view.bounds)
        animView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        animView.alpha = 0

        let label = UILabel()
        label.text = "🏆 Vitória de \(dupla)!"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.alpha = 0
        label.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false

        animView.addSubview(label)
        self.view.addSubview(animView)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: animView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: animView.centerYAnchor)
        ])

        UIView.animate(withDuration: 3.2, animations: {
            animView.alpha = 1
            label.alpha = 1
            label.transform = .identity
        }) { _ in
            UIView.animate(withDuration: 3.2, delay: 1.5, options: [], animations: {
                animView.alpha = 0
            }) { _ in
                animView.removeFromSuperview()
            }
        }
    }
    
}
