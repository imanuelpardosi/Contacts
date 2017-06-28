//
//  ContactListView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class ContactListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var contactTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactTable.delegate = self
        contactTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell

        cell.set()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
    }
}
