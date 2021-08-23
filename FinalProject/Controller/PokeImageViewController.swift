//
//  PokeImageViewController.swift
//  FinalProject
//
//  Created by olga.krjuckova on 23/08/2021.
//

import UIKit

class PokeImageViewController: UIViewController {

    
    
    
    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthsTexField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var findButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func findWeekDayTapped(_ sender: Any) {
        
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        
        guard let day = Int(dayTextField.text!), let month = Int(monthsTexField.text!), let year = Int(yearTextField.text!) else {
            /*If not - Allert pop up for User
             Look for func warningPopup at aproximetely row 85. Here we only run this func.
             
             */
            warningPopUp(withTitle: "Input error", withMessage: "Date Text Fields Can't be Empty.")
            return
            
        }
        /* dateComponents.day = String(dayTextField.text)
 Not safe to cast! Use guard.
 */
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        guard let date = calendar.date(from: dateComponents) else {
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_EN")
        /* We put "EEEE" format to get day of week written in one whole word NSDateformatter.com */
        dateFormatter.dateFormat = "EEEE"
        
        
        
        switch findButton.titleLabel?.text {
        case "FIND":
            findButton.setTitle("CLEAR", for: .normal)
            if day >= 1 && day <= 31 && month >= 1 && month <= 12 {
                let weekDay = dateFormatter.string(from: date)
                self.resultLabel.text = weekDay.capitalized
            }else{
                clearTextInFields()               //Allert pop up for User
                warningPopUp(withTitle: "Wrong Date", withMessage: "Please, Enter the Correct Date.")
            }
        default:
            findButton.setTitle("FIND", for: .normal)
            clearTextInFields()                             }
      
    }
   
    func clearTextInFields(){
        dayTextField.text = ""
        monthsTexField.text = ""
        yearTextField.text = ""
        resultLabel.text = "Day Of The Week Inside Your Finder"
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func warningPopUp (withTitle title: String?, withMessage message: String?){
        /* build after popUp.addAction -  need to access main Thread (???- ask later)
         We put in "code" our popUp let,button and Action
         Dont forget to run func "warningPopUp" in all necessary places (commented as as "Allert")
 */
        DispatchQueue.main.async {
            let popUp = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            //to put our okButton inside of Allert
            popUp.addAction(okButton)
            self.present(popUp, animated: true, completion: nil)
        }
    
    }
    

    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DayFinder"{
        // Get the new view controller using segue.destination.
            
            let viewController = segue.destination as! InfoViewController
            
            
            // Pass the selected object to the new view controller.
            viewController.infoText = "DayFinder app helps You\nto find day of week for\ngiven date"
        
        }
        
}
    */
}
