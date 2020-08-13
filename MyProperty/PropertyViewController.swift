//
//  PropertyViewController.swift
//  MyProperty
//
//  Created by jeewan bhusal on 3.8.2020.
//  Copyright © 2020 MyProperty. All rights reserved.
//



    import UIKit

    //the base view which shows the view of PropertyViewCell class as table view
    //this class updates the values in the table
    //with the help of data received from the arrays in AddViewController
    class PropertyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
        //Local variables
        var houseArr: [String] = []
        var contactArr: [String] = []
        var priceArr: [String] = []
        var locationArr: [String] = []
        var describeArr: [String] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return houseArr.count
        } //end of tableview func
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let tempCell:PropertyViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PropertyViewCell
            
            tempCell.house.text = houseArr[indexPath.row]
            tempCell.contact.text = contactArr[indexPath.row]
            tempCell.price.text = priceArr[indexPath.row]
            tempCell.address.text = locationArr[indexPath.row]
            tempCell.describe.text = describeArr[indexPath.row]
            
            return tempCell
            
        }//end of tableView func
        
    }



