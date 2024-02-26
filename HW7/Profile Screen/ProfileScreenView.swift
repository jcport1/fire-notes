//
//  ProfileScreenView.swift
//  HW7
//
//  Created by Jefferson Cuartas on 11/5/23.
//

import UIKit

class ProfileScreenView: UIView {
    
    var textLabelName:UILabel!
    var textLabelEmail:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupNameLabel()
        setupEmailLabel()
        
        initConstraints()
       }
    
    func setupNameLabel(){
        textLabelName = UILabel()
        textLabelName.font = UIFont.boldSystemFont(ofSize: 24)
        textLabelName.text = "Name:"
        textLabelName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabelName)
    }
    
    func setupEmailLabel(){
        textLabelEmail = UILabel()
        textLabelEmail.text = "Email:"
        textLabelEmail.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textLabelEmail)
    }
    
    //MARK: initialize the constraints...
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            //MARK: contentWrapper constraints...
            textLabelName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            textLabelName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            
            textLabelEmail.topAnchor.constraint(equalTo: textLabelName.topAnchor, constant: 32),
            textLabelEmail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
