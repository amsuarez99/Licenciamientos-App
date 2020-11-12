//
//  CuestionariosController.swift
//  Cuestionario
//
//  Created by user180523 on 11/5/20.
//

import UIKit

class CuestionariosController: UIViewController {
    let data = ["Tema 1", "Tema 2"]
    

    private let tableView : UITableView = {
       let tv = UITableView()
        tv.backgroundColor = .lightGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private let titulo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "CUESTIONARIOS", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(TemaCell.self, forCellReuseIdentifier: "cell")
        setupView()
    }

    private func setupView() {
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: -50),
            titulo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

extension CuestionariosController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! TemaCell
        cell.nameLabel.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (self.tableView.frame.height) * 0.15
    }
}

class TemaCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        label.font = Constants.App.Fonts.titleFont
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardView : UIView = {
        let v = UIView()
//        v.backgroundColor = Constants.App.Colors.orangeTint
        v.backgroundColor = .systemIndigo
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            cardView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            cardView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
        
        cardView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
}