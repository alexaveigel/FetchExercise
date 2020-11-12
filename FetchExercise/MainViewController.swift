//
//  MainViewController.swift
//  FetchExercise
//
//  Created by Admin on 11/12/20.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchItems = [FetchItem]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let dataRequest = FetchRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        getItems()
    }
    
    func getItems() {
        dataRequest.fetchData() { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let items):
                
                let filtered =  items.filter {
                    if let name = $0.name {
                        return !name.isEmpty
                    }
                    return false
                }
                
                let sorted = filtered.sorted {
                    
                    if $0.listId == $1.listId && $0.name != $1.name {
                        return $0.name ?? "N/A" < $1.name ?? "N/A"
                    }
                    else {
                        return $0.listId < $1.listId
                    }
                }
                self?.fetchItems = sorted
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell") as? MainTableViewCell
        let item = fetchItems[indexPath.row]
        
        cell?.listId.text = "List ID: \(item.listId.description)"
        cell?.name.text = "Name: \(item.name ?? "N/A")"
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
