//
//  popSalaryViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/1/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Realm
class popSalaryViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var salary: UITextField!
    @IBOutlet weak var confirm: UIButton!
    var sal = Income.allObjects()
    @IBAction func clickConfirm(sender: UIButton) {
        let realm = RLMRealm.defaultRealm()
        let salary = Income()
        if sal.count < 1 {
        realm.beginWriteTransaction()
        salary.salary = Double(self.salary.text!)!
        realm.addObject(salary)
        try! realm.commitWriteTransaction()
        }else{
        realm.beginWriteTransaction()
        let s = sal[0] as! Income
        s.salary = Double(self.salary.text!)!
        try! realm.commitWriteTransaction()
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if sal.count < 1{
            self.salary.text = "0"
        }else{
            self.salary.text = String(sal[0].valueForKey("salary")!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirm.layer.cornerRadius = 12
        confirm.layer.borderWidth =  1
        confirm.layer.borderColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1.0).CGColor
        salary.delegate = self
        salary.becomeFirstResponder()
        salary.keyboardType = .NumberPad
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
