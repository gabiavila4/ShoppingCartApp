//
//  ViewController.swift
//  ShoppingCartApp
//
//  Created by GABRIELA AVILA on 10/31/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var TFOutlet: UITextField!
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var cart = [String]()
    let defaults = UserDefaults.standard
    var TOrF = false
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        cart.append("Eggs")
        
        if let items = defaults.data(forKey: "theCart") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([String].self, from: items) {
                cart = decoded
            }
        }
       
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = cart[indexPath.row]
        return cell
    }
    
    //doesnt work
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
    else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    

    @IBAction func addAction(_ sender: UIButton) {
    for blah in cart{
        if (TFOutlet.text ?? "" == blah){
            let alert = UIAlertController(title: "Error", message: "Already Added This Item!", preferredStyle: .alert)
                
            let noAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
               
            alert.addAction(noAction)
               
            present(alert, animated: true, completion: nil)
            count = count + 1
        }
        
        }
        if count == 0{
            cart.append(TFOutlet.text ?? "")
            self.tableViewOutlet.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            cart.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cart) {
        defaults.set(encoded, forKey: "theCart")
        }
        
    }
    
    @IBAction func sortAction(_ sender: UIButton) {
        cart.sort()
        for blah in cart{
            print(blah)
        }
        self.tableViewOutlet.reloadData()
        
    }
    
    
    
}

