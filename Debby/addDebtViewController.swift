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
    @IBOutlet weak var debby: UIButton!
    @IBOutlet weak var but1: UIButton!
    @IBOutlet weak var but2: UIButton!
    @IBOutlet weak var but3: UIButton!
    @IBOutlet weak var but4: UIButton!
    @IBOutlet weak var but5: UIButton!
    @IBOutlet weak var but6: UIButton!
    @IBOutlet weak var but7: UIButton!
    @IBOutlet weak var but8: UIButton!
    @IBOutlet weak var view1: UIImageView!
    @IBOutlet weak var view2: UIImageView!
    @IBOutlet weak var view3: UIImageView!
    @IBOutlet weak var view4: UIImageView!
    @IBOutlet weak var view5: UIImageView!
    @IBOutlet weak var view7: UIImageView!
    @IBOutlet weak var view8: UIImageView!
    @IBOutlet weak var view6: UIImageView!
    var type :String!
    var sum : Double!
    var picker:UIImagePickerController?=UIImagePickerController()
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
        if self.descriptionTextField.text! != "" || self.fullPriceTextField.text! != "" || self.interestTextField.text! != "" || instalmentTextField.text! != "" || self.sum != 0.0 || self.type != "" {
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
            expense.interest = Double(interestTextField.text!)!
            expense.period = Double(instalmentTextField.text!)!
            expense.type = self.type
            expense.sumDebt = self.sum
            expense.title = descriptionTextField.text!
            realm.addObject(expense)
            try! realm.commitWriteTransaction()
            
        }else{
            
        }
    }
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var photo: UIButton!
    @IBAction func takePhoto(sender: UIButton) {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            picker!.cameraCaptureMode = .Photo
            presentViewController(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .Alert)
            let ok = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alert.addAction(ok)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photo.setImage(chosenImage, forState: .Normal)
        dismissViewControllerAnimated(true, completion: nil)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.layer.borderWidth = 1
        photo.layer.borderColor = UIColor.whiteColor().CGColor
        but1.layer.cornerRadius = 40
        but2.layer.cornerRadius = 40
        but3.layer.cornerRadius = 40
        but4.layer.cornerRadius = 40
        but5.layer.cornerRadius = 40
        but6.layer.cornerRadius = 40
        but7.layer.cornerRadius = 40
        but8.layer.cornerRadius = 40
        but1.layer.borderColor = UIColor(red: 24/255, green: 35/255, blue: 48/255, alpha: 1).CGColor
        but2.layer.borderColor = UIColor(red: 95/255, green: 180/255, blue: 116/255, alpha: 1).CGColor
        but3.layer.borderColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1).CGColor
        but4.layer.borderColor = UIColor(red: 214/255, green: 137/255, blue: 16/255, alpha: 1).CGColor
        but5.layer.borderColor = UIColor(red: 173/255, green: 0/255, blue: 0/255, alpha: 1).CGColor
        but6.layer.borderColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1).CGColor
        but7.layer.borderColor = UIColor(red: 60/255, green: 27/255, blue: 112/255, alpha: 1).CGColor
        but8.layer.borderColor = UIColor(red: 232/255, green: 182/255, blue: 42/255, alpha: 1).CGColor
        picker?.delegate = self
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
