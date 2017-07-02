//
//  AddEditContactView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/2/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class AddEditContactView: UIViewController {
    
    var colorUtilities: ColorUtilities = ColorUtilities()
    override func viewDidLoad() {
        super.viewDidLoad()
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem = doneItem
        self.navigationController?.navigationBar.tintColor = colorUtilities.colorFromHex(hex: "#50E3C2")
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func doneTapped() {
        print("Done")
    }
}
