//
//  ViewController.swift
//  MyProperty
//
//
//  Copyright © 2020 MyProperty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var f_name:String!
    var e_email:String!
    var u_pass:String!
    var r_pass:String!
    var i_data:Int!
    
    var users : [Appuser] = []
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let a1 = Appuser("abc","abc@abc.com", "123", "123")
        users.append(a1)
        let a2 = Appuser("abcd","abcd@abc.com", "1234", "1234")
        users.append(a2)
        let a3 = Appuser("abcde","abcde@abc.com", "12345", "12345")
        users.append(a3)
        
        if(i_data == 1){
            let a4 = Appuser(f_name,e_email,u_pass,r_pass)
            users.append(a4)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        let email_u = email.text!
        let pass_u = password.text!
        
        var myCount:Int = 0
            
            for user in users{
                if(user.email == email_u && user.password == pass_u){
                    myCount += 1
                }
            }
            
            if(myCount > 0){
                performSegue(withIdentifier: "loginInfo", sender: nil)
                print("Successful Login")
                myCount = 0
            }
            else if (email_u.isEmpty && pass_u.isEmpty){
                let alert = UIAlertController(title: "Login Error", message: "Please fill require fileds", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            }
            else {
                let alert = UIAlertController(title: "Login Error", message: "Emeil or Password is invalid", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
}
    

