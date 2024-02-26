//
//  SignupScreenView.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/1/23.
//

import UIKit

class SignupScreenView: UIView {

    var textFieldEmail:UITextField!
    var textFieldPassword:UITextField!
    var textFieldName:UITextField!
    
    var buttonSignup:UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setuptextFieldEmail()
        setuptextFieldPassword()
        setuptextFieldName()
        setupSignupButton()
        initConstraints()
       }
    
    func setuptextFieldEmail(){
        textFieldEmail = UITextField()
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.placeholder = "Enter email..."
        textFieldEmail.borderStyle = .roundedRect
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldEmail)
    }
    
    func setuptextFieldPassword(){
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Enter password..."
        textFieldPassword.borderStyle = .roundedRect
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldPassword)
    }
    
    func setuptextFieldName(){
        textFieldName = UITextField()
        textFieldName.placeholder = "Enter full name..."
        textFieldName.borderStyle = .roundedRect
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textFieldName)
    }
    
    func setupSignupButton(){
        buttonSignup = UIButton(type: .system)
        buttonSignup.setTitle("Submit", for: .normal)
        buttonSignup.backgroundColor = UIColor(red: 0.45 , green: 0.72 , blue: 1, alpha: 1.0)
        buttonSignup.setTitleColor(UIColor.white, for: .normal)
        buttonSignup.layer.cornerRadius = 20
        buttonSignup.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSignup)
    }
    
    //MARK: initialize the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            //MARK: contentWrapper constraints...
            textFieldEmail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 16),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            textFieldName.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 16),
            textFieldName.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant: 32),
            textFieldName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            
            buttonSignup.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 32),
            buttonSignup.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonSignup.widthAnchor.constraint(equalToConstant: 160),
            buttonSignup.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
