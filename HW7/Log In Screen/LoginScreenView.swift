//
//  LoginScreenView.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/1/23.
//

import UIKit

class LoginScreenView: UIView {
    
    var textFieldEmail:UITextField!
    var textFieldPassword:UITextField!
    
    var buttonLogin:UIButton!
    
    var buttonSignup:UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setuptextFieldEmail()
        setuptextFieldPassword()
        setupLoginButton()
        setupSignUpButton()
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
    
    func setupLoginButton(){
        buttonLogin = UIButton(type: .system)
        buttonLogin.setTitle("Log In", for: .normal)
        buttonLogin.backgroundColor = UIColor(red: 0.45 , green: 0.72 , blue: 1, alpha: 1.0)
        buttonLogin.setTitleColor(UIColor.white, for: .normal)
        buttonLogin.layer.cornerRadius = 20
        buttonLogin.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonLogin)
    }
    
    func setupSignUpButton(){
        buttonSignup = UIButton(type: .system)
        buttonSignup.setTitle("Sign Up", for: .normal)
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
            
            buttonLogin.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 32),
            buttonLogin.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonLogin.widthAnchor.constraint(equalToConstant: 160),
            buttonLogin.heightAnchor.constraint(equalToConstant: 40),
            
            buttonSignup.topAnchor.constraint(equalTo: buttonLogin.bottomAnchor, constant: 24),
            buttonSignup.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
