//
//  RealmManager.swift
//  Realm Swift
//
//  Created by Administrator on 12/12/17.
//  Copyright © 2017 spb. All rights reserved.
//

import UIKit
import RealmSwift


class RealmManager: NSObject {
    
    static let sharedInstance = RealmManager()
    let realm = try! Realm()

    override init() {
        super.init()
        startRealm()
        realmConfiguration()
    }
    
    //Starting
    func startRealm() -> Void {
        _ = realm.configuration.fileURL!.deletingLastPathComponent().path
    }
 
    //Configuration
    func realmConfiguration() -> Void {
        var config = Realm.Configuration(objectTypes: [Student.self])
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("sample.realm")
        Realm.Configuration.defaultConfiguration = config
    }
    
    //insert
    func insertStudent(student: Student) -> Void {
        try! realm.write {
            realm.add(student)
        }
    }
    
    //Get
    func getStudentList() -> [Student] {
        let list = realm.objects(Student.self)
        var studentList = Array<Student>()
        for item in list {
            studentList.append(item)
        }
        return studentList
    }
    
    //Update
    func updateStudent(student: Student) -> Void {
        let student1 = realm.objects(Student.self).filter("id == \(student.id)").first
        try! realm.write {
            student1?.name = student.name
            student1?.age = student.age
            student1?.school = student.school
        }
    }
    
    //Delete
    func deleteStudent(student: Student) -> Void {
        try! realm.write {
            realm.delete(student)
        }
    }
    
    //Auto increment id
    func autoIncrementID() -> Int {
        let count = realm.objects(Student.self).max(ofProperty: "id") as Int? ?? 0
        return count+1
    }
    
    

    
}
