//
//  MainScreenView.swift
//  HW7
//
//  Created by Jefferson Cuartas on 10/31/23.
//

import UIKit

class MainScreenView: UIView {
    
    //MARK: tableView for notes...
    var tableViewNotes: UITableView!
    
    //MARK: bottom view for adding a note...
    var bottomAddView:UIView!
    var textFieldNote:UITextField!
    var buttonAdd:UIButton!
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.backgroundColor = .white
            
        setupTableViewNotes()
        setupBottomAddView()
        setupTextFieldAddName()
        setupButtonAdd()
        initConstraints()
       }
    
    //MARK: the table view to show the list of contacts...
    func setupTableViewNotes(){
        tableViewNotes = UITableView()
        tableViewNotes.register(NotesTableViewCell.self, forCellReuseIdentifier: "notes")
        tableViewNotes.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewNotes)
    }
    
    //MARK: the bottom add contact view....
    func setupBottomAddView(){
        bottomAddView = UIView()
        bottomAddView.backgroundColor = .white
        bottomAddView.layer.cornerRadius = 6
        bottomAddView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomAddView.layer.shadowOffset = .zero
        bottomAddView.layer.shadowRadius = 4.0
        bottomAddView.layer.shadowOpacity = 0.7
        bottomAddView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomAddView)
    }
    
    func setupTextFieldAddName(){
        textFieldNote = UITextField()
        textFieldNote.placeholder = "Enter text"
        textFieldNote.borderStyle = .roundedRect
        textFieldNote.translatesAutoresizingMaskIntoConstraints = false
        bottomAddView.addSubview(textFieldNote)
    }
    
    func setupButtonAdd(){
           buttonAdd = UIButton(type: .system)
           buttonAdd.titleLabel?.font = .boldSystemFont(ofSize: 16)
           buttonAdd.setTitle("Add Note", for: .normal)
           buttonAdd.translatesAutoresizingMaskIntoConstraints = false
           bottomAddView.addSubview(buttonAdd)
       }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            //bottom add view...
            bottomAddView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -8),
            bottomAddView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            bottomAddView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            buttonAdd.bottomAnchor.constraint(equalTo: bottomAddView.bottomAnchor, constant: -8),
            buttonAdd.leadingAnchor.constraint(equalTo: bottomAddView.leadingAnchor, constant: 4),
            buttonAdd.trailingAnchor.constraint(equalTo: bottomAddView.trailingAnchor, constant: -4),
            
            textFieldNote.bottomAnchor.constraint(equalTo: buttonAdd.topAnchor, constant: -8),
            textFieldNote.leadingAnchor.constraint(equalTo: buttonAdd.leadingAnchor, constant: 4),
            textFieldNote.trailingAnchor.constraint(equalTo: buttonAdd.trailingAnchor, constant: -4),
            
            bottomAddView.topAnchor.constraint(equalTo: textFieldNote.topAnchor, constant: -8),
            
            tableViewNotes.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            tableViewNotes.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewNotes.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewNotes.bottomAnchor.constraint(equalTo: bottomAddView.topAnchor, constant: -8),
            ])
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
