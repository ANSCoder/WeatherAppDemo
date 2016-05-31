//
//  ViewController.swift
//  SoapParsing
//
//  Created by Anand on 30/05/16.
//  Copyright © 2016 Anand. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash


class ViewController: UIViewController {

    @IBOutlet weak var weatherWebview: UIWebView!
    var cityName:String?
    var stateName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //Yahoo weather API
        
        let reqs: String = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(cityName!)%2C%20\(stateName!)%22)&format=xml&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        
        //Call Web service here
        self.parseMyApi(reqs) { (result) -> Void in
            
            print("Result is here\(result)")
            
            //Showing on Web view
            self.weatherWebview.loadRequest(NSURLRequest(URL: NSURL(string: result)!))
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- Parsing API here
    func parseMyApi(is_URL: String, completion: (result: String) -> Void) {
    
        Alamofire.request(.GET, is_URL)
            .responseJSON { response in
                
                    let xmls = SWXMLHash.parse(response.data!)
                
                    func enumerate(indexer: XMLIndexer, level: Int) {
                        
                        for child in indexer.children {
                            
                            let name:String? = child.element!.name
                            
                            print("\(level) \(name)")
                            
                            // Take Link from XML data here 
                            
                            if name! == "link" {
                                
                                let text = child.element!.text
                                
                                if text?.isEmpty == false{
                                    
                                   print(text)
                                    
                                  // Finish here Process
                                  completion(result: text!)
                                
                                }

            
                            }
                            
                            enumerate(child, level: level + 1)
                        }
                        
                        
                    }
                
                enumerate(xmls, level: 0)
                
            }
        

       }
    

}

