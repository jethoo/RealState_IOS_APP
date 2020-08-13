//
//  Appuser.swift
//  MyProperty
//
// 
//  Copyright © 2020 MyProperty. All rights reserved.
//

import Foundation

public class Appuser {
    
    var name:String = ""
    var email:String = ""
    var password:String = ""
    var retypepass:String = ""
    
    public init(_ myname:String,_ em:String,_ pass:String,_ repass:String){
        name = myname
        email = em
        password = pass
        retypepass = repass
    }
    
}
