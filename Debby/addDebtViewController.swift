//
//  addDebtViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/1/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Realm
class addDebtViewController: UIViewController,UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var but1: UIButton!
    @IBOutlet weak var but2: UIButton!
    @IBOutlet weak var but3: UIButton!
    @IBOutlet weak var but4: UIButton!
    @IBOutlet weak var but5: UIButton!
    @IBOutlet weak var but6: UIButton!
    @IBOutlet weak var but7: UIButton!
    @IBOutlet weak var but8: UIButton!
    @IBOutlet weak var chooseView: UIView!
    var type  = "type"
    var sum = 0.0
    @IBOutlet weak var moveUp: NSLayoutConstraint!
    @IBAction func clickBut1(sender: UIButton) {
        self.type = "Car"
        but1.layer.borderWidth = 1
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut2(sender: UIButton) {
        self.type = "Tv"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 1
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut3(sender: UIButton) {
        self.type = "Telephone"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 1
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut4(sender: UIButton) {
        self.type = "Washing Machine"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 1
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut5(sender: UIButton) {
        self.type = "Home"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 1
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut6(sender: UIButton) {
        self.type = "Refrigerator"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 1
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut7(sender: UIButton) {
        self.type = "Air Condition"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 1
        but8.layer.borderWidth = 0
    }
    @IBAction func clickBut8(sender: UIButton) {
        self.type = "Money"
        but1.layer.borderWidth = 0
        but2.layer.borderWidth = 0
        but3.layer.borderWidth = 0
        but4.layer.borderWidth = 0
        but5.layer.borderWidth = 0
        but6.layer.borderWidth = 0
        but7.layer.borderWidth = 0
        but8.layer.borderWidth = 1
    }
    @IBAction func clickAddDebt(sender: UIButton) {
        print(self.type)
        print(self.descriptionTextField.text!)
        print(self.fullPriceTextField.text!)
        print(self.interestTextField.text!)
        print(self.instalmentTextField.text!)
        print(self.sum)
        if self.fullPriceTextField.text! != "" && instalmentTextField.text! != "" && self.sum != 0.0 && self.type != "type" {
            let realm = RLMRealm.defaultRealm()
            let expense = Expense()
            realm.beginWriteTransaction()
            expense.date = NSDate()
            if downTextField.text != ""{
                expense.downPrice = Double(downTextField.text!)!
            }else{
                expense.downPrice = 0.0
            }
            expense.fullPrice = Double(fullPriceTextField.text!)!
            if interestTextField.text! == "" {
                expense.interest = 0.0
            }else{
            expense.interest = Double(interestTextField.text!)!
            }
            expense.period = Double(instalmentTextField.text!)!
            expense.type = self.type
            expense.sumDebt = self.sum
            expense.title = descriptionTextField.text!
            realm.addObject(expense)
            try! realm.commitWriteTransaction()
            performSegueWithIdentifier("add", sender: self)
        }else{
            let alertController = UIAlertController(title: "Error", message:
                "You didn't complete add debt", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
        func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var calMoney: UILabel!
    @IBAction func clickCalculate(sender: UIButton) {
        var full:Double!
        var down:Double!
        var interest:Double!
        var time:Double!
        if fullPriceTextField.text! != "" {
            full = (fullPriceTextField.text! as! NSString).doubleValue
        }else{
            full = 0
        }
        if downTextField.text! != "" {
            down = Double(downTextField.text!)!
        }else{
            down = 0
        }
        if interestTextField.text! != "" {
            interest = Double(interestTextField.text!)!
        }else{
            interest = 0
        }
        if instalmentTextField.text! != "" {
            time = Double(instalmentTextField.text!)!
            print(time)
        }else{
            time = 0
        }
        let numberFormatter = NSNumberFormatter()
        numberFormatter.internationalCurrencySymbol = "THB "
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
        calMoney.text =  numberFormatter.stringFromNumber(Calculate.shareInstance.normalDebtCal(full,down: down,interest: interest,time: time) as NSNumber)!
        self.sum = Calculate.shareInstance.normalDebtCal(full,down: down,interest: interest,time: time)
    }
    @IBOutlet weak var fullPriceTextField: UITextField!
    @IBOutlet weak var downTextField: UITextField!
    @IBOutlet weak var interestTextField: UITextField!
    @IBOutlet weak var instalmentTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        but1.layer.cornerRadius = but1.frame.height/2
        but2.layer.cornerRadius = but1.frame.height/2
        but3.layer.cornerRadius = but1.frame.height/2
        but4.layer.cornerRadius = but1.frame.height/2
        but5.layer.cornerRadius = but1.frame.height/2
        but6.layer.cornerRadius = but1.frame.height/2
        but7.layer.cornerRadius = but1.frame.height/2
        but8.layer.cornerRadius = but1.frame.height/2
        but1.layer.borderColor = UIColor(red: 24/255, green: 35/255, blue: 48/255, alpha: 1).CGColor
        but2.layer.borderColor = UIColor(red: 95/255, green: 180/255, blue: 116/255, alpha: 1).CGColor
        but3.layer.borderColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1).CGColor
        but4.layer.borderColor = UIColor(red: 214/255, green: 137/255, blue: 16/255, alpha: 1).CGColor
        but5.layer.borderColor = UIColor(red: 173/255, green: 0/255, blue: 0/255, alpha: 1).CGColor
        but6.layer.borderColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1).CGColor
        but7.layer.borderColor = UIColor(red: 60/255, green: 27/255, blue: 112/255, alpha: 1).CGColor
        but8.layer.borderColor = UIColor(red: 232/255, green: 182/255, blue: 42/255, alpha: 1).CGColor
        fullPriceTextField.delegate = self
        downTextField.delegate = self
        interestTextField.delegate = self
        instalmentTextField.delegate = self
        descriptionTextField.delegate = self
        // Do any additional setup after loading the view.
        
    }
    override func viewDidLayoutSubviews(){
        borderButtom(fullPriceTextField)
        borderButtom(downTextField)
        borderButtom(interestTextField)
        borderButtom(instalmentTextField)
        borderButtom(descriptionTextField)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        chooseView.hidden = false
         moveUp.constant = 170
        return true
    }
    func borderButtom(textField:UITextField){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.whiteColor().CGColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        chooseView.hidden = true
         moveUp.constant = 20
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
