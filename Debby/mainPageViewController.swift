//
//  mainPageViewController.swift
//  Debby
//
//  Created by Tanakorn on 4/29/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import CoreData
import Realm
class mainPageViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var mSalary: UILabel!
    @IBOutlet weak var mExpense: UILabel!
    @IBOutlet weak var mTotal: UILabel!
    @IBOutlet weak var numberDebt: UILabel!
    @IBOutlet weak var fastDebt: UILabel!
    @IBOutlet weak var slowDebt: UILabel!
    @IBOutlet weak var smallDebt: UILabel!
    @IBOutlet weak var bigDebt: UILabel!
    var animateDistance = CGFloat()
    var Money = [NSManagedObject]()
    var allExpense = [Expense]()
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    @IBAction func clickAddNewDebt(sender: UIButton) {
        
        UIView.animateWithDuration(0.15 ,
                                   animations: {
                                    self.addNewDebt.transform = CGAffineTransformMakeScale(0.95, 0.95)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.15){
                                        self.addNewDebt.transform = CGAffineTransformIdentity
                                    }
        })
        delay(0.4){
            self.performSegueWithIdentifier("addDibt", sender: self)
        }
    }
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    @IBAction func clickSalary(sender: UIButton) {
        UIView.animateWithDuration(0.15 ,
                                   animations: {
                                    self.addSalary.transform = CGAffineTransformMakeScale(0.95, 0.95)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.15){
                                        self.addSalary.transform = CGAffineTransformIdentity
                                    }
        })
        delay(0.4){
            self.performSegueWithIdentifier("popSalary", sender: self)
        }
    }
    @IBOutlet weak var addSalary: UIButton!
    
    
    @IBAction func clickExpense(sender: UIButton) {
        UIView.animateWithDuration(0.15 ,
                                   animations: {
                                    self.addExpense.transform = CGAffineTransformMakeScale(0.95, 0.95)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.15){
                                        self.addExpense.transform = CGAffineTransformIdentity
                                    }
        })
        delay(0.4){
            self.performSegueWithIdentifier("popExpense", sender: self)
        }
        
    }
    @IBOutlet weak var addExpense: UIButton!
    @IBAction func clickSetting(sender: UIButton) {
        UIView.animateWithDuration(0.15 ,
                                   animations: {
                                    self.addSetting.transform = CGAffineTransformMakeScale(0.95, 0.95)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.15){
                                        self.addSetting.transform = CGAffineTransformIdentity
                                    }
        })
        delay(0.4){
            
        }
        
    }
    @IBOutlet weak var addSetting: UIButton!
    @IBOutlet weak var addNewDebt: UIButton!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var sal = Income.allObjects()
        if sal.count < 1{
            self.mSalary.text = "THB 0.00"
        }else{
            var numberFormatter = NSNumberFormatter()
            numberFormatter.internationalCurrencySymbol = "THB "
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
            self.mSalary.text = numberFormatter.stringFromNumber(sal[0].valueForKey("salary")! as! NSNumber)!
        }
        var numberFormatter = NSNumberFormatter()
        numberFormatter.internationalCurrencySymbol = "THB "
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
        self.mExpense.text = numberFormatter.stringFromNumber(calExpence() as! NSNumber)!
        initAllData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(RLMRealm.defaultRealm().path)
        //        let realm = RLMRealm.defaultRealm()
        //        let salary = Income()
        //        salary.salary = 300.0
        //        realm.beginWriteTransaction()
        //        realm.addObject(salary)
        //        try! realm.commitWriteTransaction()
        var popoverContent = (self.storyboard?.instantiateViewControllerWithIdentifier("popSalary"))! as UIViewController
        var nav = UINavigationController(rootViewController: popoverContent)
        nav.modalPresentationStyle = UIModalPresentationStyle.Popover
        var popover = nav.popoverPresentationController
        popoverContent.preferredContentSize = CGSizeMake(100,100)
        popover!.delegate = self
        popover!.sourceView = self.view
        popover!.sourceRect = CGRectMake(100,100,0,0)
        self.presentViewController(nav, animated: true, completion: nil)
        addNewDebt.layer.cornerRadius = 5
        addSalary.layer.cornerRadius = 5
        addExpense.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func calExpence() -> Double{
        let expense = Expense.allObjects()
        var sum : Double = 0.0
        if expense.count > 0 {
            for i in 0...expense.count-1 {
                print(expense[i].valueForKey("sumDebt")! as! Double)
                allExpense.append(expense[i] as! Expense)
                sum += expense[i].valueForKey("sumDebt")! as! Double
            }
        }
        return sum
    }
    func initAllData(){
        var salary = Income.allObjects()
        var minT = DBL_MAX
        var maxT  = DBL_MIN
        var minM = DBL_MAX
        var maxM = DBL_MIN
        var sum = 0.0
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        let s = allExpense[0] as! Expense
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        s.date = dateFormat.dateFromString("2015-07-12")
        try! realm.commitWriteTransaction()
        if allExpense.count > 0 {
            for i in 0...allExpense.count-1{
                let date = NSDate()
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components([.Day , .Month , .Year], fromDate: date)
                let y1 =  components.year
                let m1 = components.month
                let d1 = components.day
                let start = allExpense[i].valueForKey("date") as! NSDate
                let com = calendar.components([.Day , .Month , .Year], fromDate: start)
                let y2 =  com.year
                let m2 = com.month
                let d2 = com.day
                var end = 0
                if y1-y2 > 1 {
                    end = (y1-y2-1)*12
                    var cal = m1-m2-1
                    if cal < 0 {
                        cal += 2*cal
                    }
                    end += cal
                }else{
                    if y1-y2 == 1{
                        end = 12 - m2
                        end += m1-1
                    }else{
                    end = m1-m2-1
                    }
                }
                if minM > (allExpense[i].valueForKey("sumDebt")! as! Double) {
                    minM = allExpense[i].valueForKey("sumDebt")! as! Double
                }
                if maxM < (allExpense[i].valueForKey("sumDebt")! as! Double) {
                    maxM = allExpense[i].valueForKey("sumDebt")! as! Double
                }
                if minT > (allExpense[i].valueForKey("period")! as! Double - Double(end)){
                    minT = allExpense[i].valueForKey("period")! as! Double - Double(end)
                }
                if maxT < (allExpense[i].valueForKey("period")! as! Double - Double(end)){
                    maxT = allExpense[i].valueForKey("period")! as! Double - Double(end)
                }
                sum += allExpense[i].valueForKey("sumDebt")! as! Double
                
            }
            var sal :Double!
            if salary.count < 1{
                sal = 0.0
                
            }else{
                sal = salary[0].valueForKey("salary")! as! Double
            }
            let exp : Double = sum
            let numberFormatter = NSNumberFormatter()
            numberFormatter.internationalCurrencySymbol = "THB "
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
            let total = sal-exp
            print(total)
            mTotal.text = numberFormatter.stringFromNumber(total as NSNumber)!
            numberDebt.text = String(allExpense.count) + " debts"
            fastDebt.text = String(Int(minT)) + " m"
            slowDebt.text = String(Int(maxT)) + " m"
            numberFormatter.internationalCurrencySymbol = ""
            smallDebt.text = numberFormatter.stringFromNumber(minM as NSNumber)! + " THB"
            bigDebt.text = numberFormatter.stringFromNumber(maxM as NSNumber)! + " THB"
        }else if salary.count > 0{
            let numberFormatter = NSNumberFormatter()
            numberFormatter.internationalCurrencySymbol = "THB "
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
            let sal = salary[0].valueForKey("salary")! as! Double
            mTotal.text = numberFormatter.stringFromNumber(sal as NSNumber)!
            numberDebt.text = "no debt"
            fastDebt.text = "no debt"
            slowDebt.text = "no debt"
            smallDebt.text = "no debt"
            bigDebt.text = "no debt"
        }else{
            mTotal.text = "THB 0.00"
            numberDebt.text = "no debt"
            fastDebt.text = "no debt"
            slowDebt.text = "no debt"
            smallDebt.text = "no debt"
            bigDebt.text = "no debt"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "popSalary"{
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
            
            
            let des = segue.destinationViewController as! popSalaryViewController
        }
        if segue.identifier == "popExpense"{
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
            
        }
        
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
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
