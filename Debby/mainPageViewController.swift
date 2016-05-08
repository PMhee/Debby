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
    var animateDistance = CGFloat()
    var Money = [NSManagedObject]()
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
            numberFormatter.internationalCurrencySymbol = "THB"
            numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
            self.mSalary.text = numberFormatter.stringFromNumber(sal[0].valueForKey("salary")! as! NSNumber)!
        }
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
