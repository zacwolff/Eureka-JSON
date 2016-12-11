//
//  ViewController.swift
//  Eureka JSON
//
//  Created by Zachary Hussein on 08/12/2016.
//  Copyright © 2016 GH4HUB Ghana Limited. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import SwiftyJSON

class ViewController: FormViewController
{
    let misikaURL: String = "https://demo.misika247.com:3000/cowrybank/api/mobile/"
    let parameters = ["action" : "openingAccount", "token" : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtc2lzZG4iOiIyMzMyNjYyMzA2NjgiLCJwaW4iOiIxNTY4In0.LYs-gT4pgzDtDiMpy0UQOUazEHf4UO1DqbxfWT3G2e8", "msisdn" : "233266230668"]
    
    var formsData = [[String:AnyObject]]()

    
    func getQuestions()
    {
        Alamofire.request(misikaURL, parameters: parameters).responseJSON { response in
            
            switch response.result
            {
            case .success:
                if let value = response.result.value
                {
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    
                    if json["status"].stringValue == "200"
                    {
                        print("Shit works")
                        let swiftyJsonVar = JSON(response.result.value!)
                        
                        if let questions = swiftyJsonVar["questions"].arrayObject
                        {
                            self.formsData = questions as! [[String:AnyObject]]
                            print("This is questions: ")
                            print (questions)
                            //let id = products["id"] as! String
                        }

                        
                        
                    }
                    else
                    {
                        print("Shit doesn't work")
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    private func setupForm()
    {

    }

    override func viewWillAppear(_ animated: Bool)
    {
        getQuestions()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
