//
//  ViewController.swift
//  HW7
//  Resources:
//  - Create Custom Data Models for API in Swift: https://medium.com/p/84ef7ed3b1f4
// - UI Image for UIBarButtonItem: https://www.appsdeveloperblog.com/uibarbuttonitem-with-image/
//  Created by Jefferson Cuartas on 10/31/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    
    var authToken: String!
    
    var delegate: LoginScreenController!
    
    var userNotes = [Note]()

    override func loadView() {
            view = mainScreen
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        
        //MARK: setting the delegate and data source...
        mainScreen.tableViewNotes.dataSource = self
        mainScreen.tableViewNotes.delegate = self
        
        //MARK: removing the separator line...
        mainScreen.tableViewNotes.separatorStyle = .none
        
        //then call getAllNotes
        getAllNotes()
        
        //icons
        let profileButtonImage = UIImage(systemName: "person.crop.circle")
        let logoutButtonImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        
        //navigation
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: profileButtonImage, style: .plain, target: self,
        action: #selector(onButtonProfileTapped)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: logoutButtonImage, style: .plain, target: self,
        action: #selector(onButtonLogoutTapped)
        )
        
        mainScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
    }
    
    func displayErrorAlert(message: String){
        let alert = UIAlertController(
            title: "Error!",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func onButtonLogoutTapped(){
        //remove token
        delegate.defaults.removeObject(forKey: "authToken")
        //redirect to login/screen or other screen
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onButtonProfileTapped(){
        let profileScreenController = ProfileScreenController()
        profileScreenController.authToken = authToken
        navigationController?.pushViewController(profileScreenController, animated: true)
    }
    
    @objc func onButtonAddTapped(){
        
        if let text = mainScreen.textFieldNote.text{
            if !text.isEmpty{
                addANewNote(note: text)
            } else {
                let msg = "Text field is required"
                displayErrorAlert(message: msg)
            }
        }
     }
    
    func clearAddViewFields(){
        mainScreen.textFieldNote.text = ""
      }
    
    }

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! NotesTableViewCell
        cell.labelNote.text = userNotes[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(userNotes[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            deleteNote(id: userNotes[indexPath.row].id)
        }
    }
}
