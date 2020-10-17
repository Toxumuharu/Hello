//
//  TableTableViewController.swift
//  Hello
//
//  Created by Toxumuharu on 2020/10/18.
//  Copyright © 2020 toxumuharu.com. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var hellos = [Hello]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getHellos()
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        print("plusButtonTapped")
        addHelloToCoreData()
        getHellos()
    }
    
    func addHelloToCoreData(){
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var newHello = Hello(context: context)
        newHello.label = "Hello!"
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func getHellos(){
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if let hellosFromCoreData = try? context.fetch(Hello.fetchRequest()){
            if let hellos = hellosFromCoreData as? [Hello] {
                self.hellos = hellos
                tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hellos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = hellos[indexPath.row].label
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(hellos[indexPath.row])
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        getHellos()
    }

}
