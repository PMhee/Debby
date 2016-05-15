//
//  GoProViewController.swift
//  Debby
//
//  Created by Tanakorn on 5/14/2559 BE.
//  Copyright © 2559 Tanakorn. All rights reserved.
//

import UIKit

class GoProViewController: UIViewController {

    @IBOutlet weak var goPro: UIButton!
    @IBAction func goPro(sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        goPro.layer.cornerRadius = 15
        goPro.layer.borderWidth = 1
        goPro.layer.borderColor = UIColor(red: 232/255, green: 107/255, blue: 107/255, alpha: 1.0).CGColor
        // Do any additional setup after loading the view.
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
