//
//  ViewController.swift
//  chat
//
//  Created by Gonzalo Romero on 06/11/2021.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message]? = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MessageManager().retrieve(){
            [weak self] result in
            switch result {
            case.success(let message):
                self?.messages = message
            case.failure(_):
                self?.messages = []
                print("there was an error")
            }
        }
    }
}

extension MessageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (messages![indexPath.row].username == "Me"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "sendCustomCell", for: indexPath) as! SendCustomTableViewCell
            
            cell.messageLabel.text = messages![indexPath.row].message
            cell.timeMessageLabel.text = messages![indexPath.row].timeMessage
            cell.sendView.layer.cornerRadius = 10
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "receiveCustomCell", for: indexPath) as! ReceiveCustomTableViewCell
        
        cell.messageLabel.text = messages![indexPath.row].message
        cell.timeLabel.text = messages![indexPath.row].timeMessage
        cell.usernameLabel.text = messages![indexPath.row].username
        cell.receiveView.layer.cornerRadius = 10
        
        return cell
    }
}

