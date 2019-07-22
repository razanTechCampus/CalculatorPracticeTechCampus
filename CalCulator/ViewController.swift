//
//  ViewController.swift
//  CalCulator
//
//  Created by TechCampus on 7/17/19.
//  Copyright © 2019 TechCampus. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    //Mark: IBOutlets
    //IBOutlets are created to form a connection between UI in storyboard and the file that contains the code
    //IBOutlets enables code to chnage btn backgroundColor for example or to update UI as we did for lblResult text
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    @IBOutlet weak var btn7: UIButton!
    @IBOutlet weak var btn8: UIButton!
    @IBOutlet weak var btn9: UIButton!
    @IBOutlet weak var btnPoint: UIButton!
    @IBOutlet weak var btnEqual: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    @IBOutlet weak var btnMultiply: UIButton!
    @IBOutlet weak var btnDivide: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    
    //MARK: private variables
    
    //in this case we declared these variables to make use of them and save values
    private var valueA: Double = 0
    private var valueB: Double = 0
    
    //this variable is used to check the operator value is empty string or = or + (which case, check "btnOperatorClicked" method)
    private var currentOperator: String = ""
    
    //this boolean will show us if the AC button clicked
    private var refreshLabel: Bool = true
    
    //Mark: override properties
    //this variable is already implemented in the parent class UIViewController, we override it to change status bar from black text to white (by default the preferred status bar style is black text)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: IBActions
    //IBAction declares to the code that this button will have an action when clicked and the action that will be made is between the { }
    
    //whenever the user clicks on AC button this action will be called automatically, AC clears everything so it returns the calculator to the main state where all values are nil
    @IBAction func btnAllCancelClicked(_ sender: Any) {
        valueA = 0
        valueB = 0
        currentOperator = ""
        refreshLabel = true
        lblResult.text = "0"
    }
    
    //any number that is clicked this method will be called
    @IBAction func btnNumberClicked(_ sender: UIButton) {
        //value gives the value of the current button clicked, you can get this value from current title which is a property for UIButton. the ! since we are sure that all buttons has a title we implemented these titles in storyboard
        var value = sender.currentTitle!
        var currentText = ""
        
        //if the lblResult value is different than 0 and the refreshlbl boolean is not true than we are adding another number for example: we have 1 in lblResult which is not 0 and the refreshLbl is false than currentText is 1
        if lblResult.text != "0" && !refreshLabel {
            currentText = lblResult.text!
        }
        
        //if currentText value is 0 and value is 0 (value means the button we clicked) than the value will be 0
        if currentText == "0" && value == "0" {
            value = ""
        }
        
        //in this case if the user clicked on the point . button we have to check first if currentText is empty than we have 0.
        //also we have to check if the value contains a point before which is impossible to add 2 points in a number, so we use the range method which searches in a text for a specific character in this case will have to search if a point exists. if user added point before than we set value as empty
        if value == "." {
            if currentText == "" {
                value = "0."
            } else if currentText.range(of: ".") != nil {
                value = ""
            }
        }
        //false to indicate that we didn't clear the values in lblResult
        refreshLabel = false
        
        //set the current number in lblResult
        lblResult.text = "\(currentText)\(value)"
    }
    
    //whenever an operator (+ - = ÷ x) is clicked this method will be called
    @IBAction func btnOperatorClicked(_ sender: UIButton) {
        //first check if lblResult text is empty string
        if lblResult.text != "" {
            //if lblResult text contains value then create a constant that will hold the operator value which we get from the current title of the button clicked (+ , - , ....)
            let newOperator = sender.titleLabel?.text!
            refreshLabel = true
            //in this case we have to check if the currentOperator is empty and user clicked on other operators than = then the value in lblResult will be given to valueA
            //else valueB will be given the value in lblResult and then we will check which operator is clicked now and accordingly the operations will happen
            if currentOperator == "" && newOperator != "=" {
                valueA = Double(lblResult.text!)!
                currentOperator = newOperator!
            } else {
                valueB = Double(lblResult.text!)!
                var result: Double = 0
                switch currentOperator {
                case "+":
                    result = valueA + valueB
                case "-":
                    result = valueA - valueB
                case "×":
                    result = valueA * valueB
                case "÷":
                    result = valueA / valueB
                default:
                    result = valueB
                }
                currentOperator = ""
                valueA = 0
                valueB = 0
                
                //this case happens if we clicked on operators other than =
                //we gave reult to valueA so if user clicked on + for example we will be adding the latest result to a new value
                if newOperator != "=" {
                    valueA = result
                    currentOperator = newOperator!
                }
                //setting the value in lblResult to show it to user
                lblResult.text = String(result)
            }
        }
    }
}

