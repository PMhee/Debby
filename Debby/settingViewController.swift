//
//  settingViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/1/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit
import Realm
class settingViewController: UIViewController,UIPopoverPresentationControllerDelegate {
    @IBAction func clickShare(sender: UIButton) {
        let vc = UIActivityViewController(activityItems: ["https://www.facebook.com/Debby-1702576426665297/?fref=ts"], applicationActivities: nil)
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func reset(sender: UIButton) {
        let realm = RLMRealm.defaultRealm()
        realm.beginWriteTransaction()
        realm.deleteAllObjects()
        try! realm.commitWriteTransaction()
    }
    @IBAction func contact(sender: UIButton) {
        if let requestUrl = NSURL(string: "https://www.facebook.com/Debby-1702576426665297/?ref=aymt_homepage_panel") {
            UIApplication.sharedApplication().openURL(requestUrl)
        }
    }
    @IBOutlet weak var upgrade: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        upgrade.layer.cornerRadius = 15
        upgrade.layer.borderWidth = 1
        upgrade.layer.borderColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1.0).CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .None
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pro"{
            let vc = segue.destinationViewController
            let controller = vc.popoverPresentationController
            if controller != nil {
                controller?.delegate = self
            }
    }
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
