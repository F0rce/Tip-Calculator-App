//
//  ViewController.swift
//  Trinkgeldrechner
//
//  Created by David Dodlek on 01.10.20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var rechnungsbetragTextField: UITextField!
    @IBOutlet weak var personenTextField: UITextField!
    
    @IBOutlet weak var prozentLabel: UILabel!
    @IBOutlet weak var prozentSlider: UISlider!

    @IBOutlet weak var trinkgeldLabel: UILabel!
    @IBOutlet weak var gesamtkostenLabel: UILabel!
    @IBOutlet weak var kostenProPersonLabel: UILabel!
    
    var trinkgeld = 0.0
    var gesamtkosten = 0.0
    var kostenProPerson = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prozentSlider.setValue(5.0, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func prozentSliderAction(_ sender: UISlider) {
        let prozentAsString = String(format: "%.0f", sender.value)
        prozentLabel.text = prozentAsString + " %"
        
        kostenAusrechnen()
    }
    
    @IBAction func prozentButtonsAction(_ sender: UIButton) {
        if sender.titleLabel?.text == "3 %" {
            prozentSlider.setValue(3.0, animated: true)
            prozentLabel.text = "3 %"
        } else if sender.titleLabel?.text == "5 %" {
            prozentSlider.setValue(5.0, animated: true)
            prozentLabel.text = "5 %"
        } else if sender.titleLabel?.text == "7 %" {
            prozentSlider.setValue(7.0, animated: true)
            prozentLabel.text = "7 %"
        }
        
        kostenAusrechnen()
    }
    
    func kostenAusrechnen() {
        if !(rechnungsbetragTextField.text!.isEmpty) && !(personenTextField.text!.isEmpty) {
            let rechnungsbetrag = Double(rechnungsbetragTextField.text!)!
            let prozensatz = Double(String(format: "%.0f", prozentSlider.value))!
            let personen = Double(personenTextField.text!)!
                   
            trinkgeld = (rechnungsbetrag * prozensatz) / 100
            gesamtkosten = rechnungsbetrag + trinkgeld
            kostenProPerson = gesamtkosten / personen
                   
            printUIElement();
        } else {
            erstelleAnzeige(message: "Bitte beide Textfelder befüllen")
        }
    }
    
    func erstelleAnzeige(message: String) {
        let alert = UIAlertController(title: "Fehler", message: message, preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "OK", style: .default) { (action) in }
        
        alert.addAction(action1);
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func printUIElement() {
        let stringTrinkgeld = String(format: "%.2F", trinkgeld)
        let stringGesamtkosten = String(format: "%.2F", gesamtkosten)
        let stringKostenProPerson = String(format: "%.2F", kostenProPerson)
        
        trinkgeldLabel.text = "Trinkgeld: " + stringTrinkgeld + " €"
        gesamtkostenLabel.text = "Gesamtkosten: " + stringGesamtkosten + " €"
        kostenProPersonLabel.text = "Kosten pro Person: " + stringKostenProPerson + " €"
    }

}
