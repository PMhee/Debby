//
//  DebtTableViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/1/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Charts
class DebtTableViewController: UITableViewController,UIPopoverPresentationControllerDelegate{
    var selectedCellIndexPath: NSIndexPath?
    let selectedCellHeight: CGFloat = 400.0
    let unselectedCellHeight: CGFloat = 101.0
    var allExpense = [Expense]()
    @IBOutlet weak var add: UIBarButtonItem!
    @IBAction func clickAdd(sender: UIBarButtonItem) {
            delay(0.4){
            self.performSegueWithIdentifier("addDebt", sender: self)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        addData()
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
        let data = ["Full Price","Paid"]
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        let y1 =  components.year
        let m1 = components.month
        let d1 = components.day
        let start = allExpense[indexPath.row].valueForKey("date") as! NSDate
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
        let pic = cell.viewWithTag(1) as! UIImageView
        pic.image = UIImage(named: allExpense[indexPath.row].valueForKey("type")! as! String)
        let type = cell.viewWithTag(2) as! UILabel
        type.text = (allExpense[indexPath.row].valueForKey("type")! as? String)?.uppercaseString
        let sum = cell.viewWithTag(3) as! UILabel
        var numberFormatter = NSNumberFormatter()
        numberFormatter.internationalCurrencySymbol = "THB "
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyISOCodeStyle
        sum.text = numberFormatter.stringFromNumber(allExpense[indexPath.row].valueForKey("sumDebt")! as! NSNumber)!
        let interest = cell.viewWithTag(4) as! UILabel
        interest.text = "interest rate "+String(Int(allExpense[indexPath.row].valueForKey("interest")! as! Double)) + " %"
        let time = cell.viewWithTag(5) as! UILabel
        time.text = "only "+String(Int((allExpense[indexPath.row].valueForKey("period") as! Double)-Double(end))) + " months left"
        let tt = cell.viewWithTag(6) as! UILabel
        tt.text = allExpense[indexPath.row].valueForKey("title")! as! String
        let pieChart = cell.viewWithTag(7) as! PieChartView
        var paid:Double = Double(end)*(allExpense[indexPath.row].valueForKey("sumDebt") as! Double)
        var number :[Double] = [allExpense[indexPath.row].valueForKey("fullPrice")! as! Double,paid]
        setChart(data, values: number, pieChart: pieChart)
        return cell
    }
    func setChart(dataPoints: [String], values: [Double],pieChart : PieChartView) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        pieChart.data = pieChartData
        
        var colors: [UIColor] = []
        let color1 = UIColor(red: 173/255, green: 0/255, blue: 0/255, alpha: 1)
        colors.append(color1)
        let color2 = UIColor(red: 214/255, green: 137/255, blue: 16/255, alpha: 1)
        colors.append(color2)
        let color3 = UIColor(red: 51/255, green: 62/255, blue: 90/255, alpha: 1)
        colors.append(color3)
        let color4 = UIColor(red: 84/255, green: 110/255, blue: 122/255, alpha: 1)
        colors.append(color4)
        let color5 = UIColor(red: 159/255, green: 208/255, blue: 187/255, alpha: 1)
        colors.append(color5)
        
        pieChartDataSet.colors = colors
        }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(selectedCellIndexPath)
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
        }
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if selectedCellIndexPath == indexPath {
                return selectedCellHeight
        }
        return unselectedCellHeight
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
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addDebt"{
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
    }
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
