//
//  TodoEntryVC.swift
//  TodoList
//
//  Created by Omara on 20.10.18.
//  Copyright © 2018 Mahmoud Omara. All rights reserved.
//

import UIKit
import RealmSwift

class TodoEntryVC: UIViewController {
    
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleTF.becomeFirstResponder()
    }
    

    @IBAction func backBtnClicked(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        guard titleTF.text != "" else {
            let alertController = UIAlertController(title: "O.o", message: "You dont include title but title is mandatory.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        var todo : TodoItem!
        if descriptionTV.text != "" {
             todo = TodoItem(title: titleTF.text ?? "", description: descriptionTV.text ?? "")
        } else {
            todo = TodoItem(title: titleTF.text ?? "")
        }
        
        do {
           let realm = try Realm()
            try realm.write {
                realm.add(todo)
            }
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        self.navigationController?.popViewController(animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
