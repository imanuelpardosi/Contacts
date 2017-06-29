//
//  ContactListView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class ContactListView: UIViewController {
    @IBOutlet weak var contactTable: UITableView!
    
    var presenter: ContactListPresenterProtocol?
    var contactList: [ContactModel] = []
    var arrIndexSection : NSArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        contactTable.tableFooterView = UIView()
        
        contactTable.delegate = self
        contactTable.dataSource = self
    }
}

extension ContactListView: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
       
        contactList.sort { (lhs: ContactModel, rhs: ContactModel) -> Bool in
            return lhs.firstName < rhs.firstName
        }
        let contact = contactList[indexPath.row]
        cell.set(forContact: contact)
        
        return cell
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.arrIndexSection as? [String] //Side Section title
    }
    
//    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return arrIndexSection.object(at: section) as? String
//    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(contactList[indexPath.row])
        presenter?.showContactDetail(forContact: contactList[indexPath.row])
    }
}

extension ContactListView: ContactListViewProtocol {
    func showPosts(with contacts: [ContactModel]) {
        contactList = contacts
        contactTable.reloadData()
    }
    
    func showError() {
        print("Internet not connected")
    }
    
    func showLoading() {
        print("Loading...")
    }
    
    func hideLoading() {
        print("Hide Loading")
    }
}
