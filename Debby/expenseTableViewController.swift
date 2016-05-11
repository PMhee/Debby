//
//  expenseTableViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/1/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class expenseTableViewController: UITableViewController {
    var allExpense = [Expense]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func addData(){
        let expense = Expense.allObjects()
        if expense.count > 0 {
            for i in 0...expense.count-1 {
                print(expense[i].valueForKey("date")! as! NSDate)
                print(expense[i].valueForKey("title")! as! String)
                print(expense[i].valueForKey("downPrice")! as! Double)
                print(expense[i].valueForKey("fullPrice")! as! Double)
                print(expense[i].valueForKey("interest")! as! Double)
                print(expense[i].valueForKey("period")! as! Double)
                print(expense[i].valueForKey("sumDebt")! as! Double)
                print(expense[i].valueForKey("type")! as! String)
                allExpense.append(expense[i] as! Expense)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allExpense.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        let pic = cell.viewWithTag(1) as! UIImageView
        pic.image = UIImage(named: allExpense[indexPath.row].valueForKey("type")! as! String)
        let type = cell.viewWithTag(2) as! UILabel
        type.text = (allExpense[indexPath.row].valueForKey("type")! as? String)?.uppercaseString
        let sum = cell.viewWithTag(3) as! UILabel
        var numberFormatter = NSNumberFormatter()
        numberFormatter.internationalCurrencySymbol = "THB "
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
        sum.text = numberFormatter.stringFromNumber(allExpense[indexPath.row].valueForKey("sumDebt")! as! NSNumber)!
        return cell
    }
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
