//
//  ViewController.swift
//  toDoApp
//
//  Created by 翔太 on 2017/04/27.
//  Copyright © 2017年 syota. All rights reserved.
//

import UIKit

var cellArray = [String]()

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        toDoTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(ViewController.refresh(sender:)), for: .valueChanged)
        if UserDefaults.standard.object(forKey: "todoList") != nil {
            cellArray = UserDefaults.standard.object(forKey: "todoList") as! [String]
        }
    }

    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        // セルに表示する値を設定する
        cell.textLabel!.text = cellArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete{
            cellArray.remove(at: indexPath.row)
            UserDefaults.standard.set(cellArray, forKey: "todoList")
            toDoTableView.reloadData()
        }
    }
    
    func refresh(sender: UIRefreshControl) {
        // ここに通信処理などデータフェッチの処理を書く
        if UserDefaults.standard.object(forKey: "todoList") != nil {
            cellArray = UserDefaults.standard.object(forKey: "todoList") as! [String]
        }
        toDoTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.refreshControl.endRefreshing()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

