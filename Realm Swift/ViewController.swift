//
//  ViewController.swift
//  Realm Swift
//
//  Created by Administrator on 12/12/17.
//  Copyright © 2017 spb. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var vwAddStudent: UIView!
    @IBOutlet weak var lblErrorInfo: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtSchool: UITextField!
    @IBOutlet weak var vwTxtFldContrainer: UIView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    var isEditStudentIndex = -1
    
    var studentList = Array<Student>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vwAddStudent.isHidden = true
        studentList = RealmManager.sharedInstance.getStudentList()
       // self.studentTableView.register(StudentCellTableViewCell.self, forCellReuseIdentifier: "StudentIdentifier")
        self.studentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.studentTableView.register(UINib.init(nibName: "StudentCellTableViewCell", bundle: nil), forCellReuseIdentifier: "StudentIdentifier")

        self.studentTableView.rowHeight = UITableViewAutomaticDimension
        self.studentTableView.estimatedRowHeight = 64.0;
        self.studentTableView.reloadData()
        reloadData()
        if studentList.count == 0 {
            self.vwAddStudent.isHidden = false
        }
        
        self.lblErrorInfo.text = ""
        self.vwAddStudent.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        self.vwTxtFldContrainer.layer.cornerRadius = 5.0
        self.btnDelete.layer.cornerRadius = 3.0
        self.btnSave.layer.cornerRadius = 3.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() -> Void {
        //studentList = RealmManager.sharedInstance.getStudentList()
        studentList = RealmManager.sharedInstance.getStudentList()
        self.studentTableView.reloadData()
    }
    
    func resetAddStudentView() -> Void {
        self.lblErrorInfo.text = ""
        self.txtName.text = ""
        self.txtAge.text = ""
        self.txtSchool.text = ""
        
    }

    //MARK: Button action
    @IBAction func onClickCancelStudentBtnClicked(_ sender: UIButton) {
        self.vwAddStudent.isHidden = true
        resetAddStudentView();
        isEditStudentIndex = -1
        self.view.endEditing(true)
    }
    @IBAction func onClickSaveStudentBtnClicked(_ sender: UIButton) {
        

        if (self.txtName.text?.isEmpty)! {
            lblErrorInfo.text = "Please enter name"
        }
        else if (self.txtAge.text?.isEmpty)! {
            lblErrorInfo.text = "Please enter age"
        }
        else if (self.txtSchool.text?.isEmpty)! {
            lblErrorInfo.text = "Please enter school"
        }
        else {
            lblErrorInfo.text = ""
            let id = RealmManager.sharedInstance.autoIncrementID()
            let name = self.txtName.text!
            let age = Int(self.txtAge.text!)!
            let school = self.txtSchool.text!
            
            if isEditStudentIndex == -1 {
                let student = Student(value: ["id":id, "name":name, "age":age, "school":school])
                RealmManager.sharedInstance.insertStudent(student: student)
            }
            else {
                let student = studentList[isEditStudentIndex]
                let updatedStudent = Student(value: ["id":student.id, "name":name, "age":age, "school":school])
                RealmManager.sharedInstance.updateStudent(student: updatedStudent)
            }
            
            reloadData()
            self.vwAddStudent.isHidden = true
            resetAddStudentView();
            isEditStudentIndex = -1
            self.view.endEditing(true)
        }
    }
    
    @IBAction func onClickAddStudentBtnClicked(_ sender: UIButton) {
        vwAddStudent.isHidden = false
    }
    @IBAction func onClickDeleteStudentBtnClicked(_ sender: UIButton) {
        let student = studentList[sender.tag]
        RealmManager.sharedInstance.deleteStudent(student: student)
        reloadData()
    }
    @IBAction func onClickEditStudentBtnClicked(_ sender: UIButton) {
        
        isEditStudentIndex = sender.tag
        let student = studentList[sender.tag]
        
        self.txtName.text = student.name
        self.txtAge.text = "\(student.age)"
        self.txtSchool.text = student.school
        
        self.vwAddStudent.isHidden = false
        
    }
    
    //MARK: UITableView Datasource and Delegate methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count;
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let identifier = "StudentIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentIdentifier") as! StudentCellTableViewCell
        
        let student = studentList[indexPath.row]
        cell.lblStudentName?.text = student.name
        cell.lblStudentAge?.text = "Age: \(student.age)"
        cell.lblSchoolName?.text = student.school

        cell.vwContainer?.layer.borderColor = UIColor.init(red: 16.0/255.0, green: 104.0/255.0, blue: 101.0/255.0, alpha: 1.0 ).cgColor
        cell.vwContainer?.layer.borderWidth = 1.0
        cell.vwContainer.layer.cornerRadius = 2.0;
        cell.btnEdit.layer.cornerRadius = 5.0;
        cell.btnDelete.layer.cornerRadius = 5.0
        
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        cell.btnDelete.addTarget(self, action: #selector(onClickDeleteStudentBtnClicked(_:)), for: .touchUpInside)
        cell.btnEdit.addTarget(self, action: #selector(onClickEditStudentBtnClicked(_:)), for: .touchUpInside)

        
        return cell
    }
    
    //UITextField Delegate methods
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        lblErrorInfo.text = ""
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    


}

