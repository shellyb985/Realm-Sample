//
//  Student.swift
//  Realm Swift
//
//  Created by Administrator on 12/12/17.
//  Copyright © 2017 spb. All rights reserved.
//

import RealmSwift

class Student: Object {

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var school = ""
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}

class Mark: Object {
    
    @objc dynamic var eng = ""
    @objc dynamic var maths = ""
    
}
