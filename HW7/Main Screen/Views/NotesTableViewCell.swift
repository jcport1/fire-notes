//
//  NotesTableViewCell.swift
//  HW7
//
//  Created by Jefferson Cuartas on 10/31/23.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    var wrapperCellView: UIView!
    var labelNote: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelNote()
        
        initConstraints()
    }

    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelNote(){
        labelNote = UILabel()
        labelNote.font = UIFont.boldSystemFont(ofSize: 16)
        labelNote.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelNote)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            
            labelNote.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelNote.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelNote.heightAnchor.constraint(equalToConstant: 20),
            labelNote.widthAnchor.constraint(equalTo: wrapperCellView.widthAnchor),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 36)
            
        ])
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
