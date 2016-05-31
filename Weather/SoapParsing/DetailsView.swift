//
//  DetailsView.swift
//  SoapParsing
//
//  Created by Anand on 31/05/16.
//  Copyright © 2016 ANSCoder. All rights reserved.
//

import UIKit

class DetailsView: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtCityName: UITextField!
    @IBOutlet weak var txtStateName: UITextField!
    
    let destinationView:String = "seeweather"
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Text field delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func actionGotoseeWeather(sender: AnyObject) {
        
        if txtStateName.text! == ""{
            
                 showAlertView()
        }else if txtCityName.text! == ""{
            
                 showAlertView()
        }else {
            //Navigation here
            self.performSegueWithIdentifier(destinationView, sender: nil)
        }
        
    }

    //MARK: - Alert View
    internal func showAlertView() {
        let alert = UIAlertController(title:"Please Enter City and State name for better location wise weather.", message: nil, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .Cancel, handler: { (action) -> Void in
            //Dismiss Alert view
        }))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == destinationView {
          let browser = segue.destinationViewController as! ViewController
           browser.cityName =  txtCityName.text!
           browser.stateName = txtStateName.text!
        }

    }
    

}
