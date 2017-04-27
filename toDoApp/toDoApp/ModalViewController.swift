//
//  ModalViewController.swift
//  toDoApp
//
//  Created by 翔太 on 2017/04/27.
//  Copyright © 2017年 syota. All rights reserved.
//

import UIKit

var todoItem = [String]()

class ModalViewController: UIViewController {
    
    @IBOutlet weak var itemText: UITextField!
    
    @IBAction func CancelButton(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        if itemText != nil {
            if UserDefaults.standard.object(forKey: "todoList") != nil {
                todoItem = UserDefaults.standard.object(forKey: "todoList") as! [String]
            }
            todoItem.append(itemText.text!)
            itemText.text = ""
            UserDefaults.standard.set(todoItem, forKey:"todoList")
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func tapSceen(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        itemText.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
