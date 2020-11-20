//
//  MedallasController.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 20/11/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class MedallasController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let titulo: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "MEDALLAS", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.biggerTitleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .none
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView.collectionViewLayout = layout
        
        collectionView?.register(MedalCard.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.showsHorizontalScrollIndicator = true
        setupViews()
    }

    private func setupViews() {
//        self.view.backgroundColor = .systemIndigo
//        collectionView.backgroundColor = .systemIndigo
        self.view.backgroundColor = .white
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.8),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.view.addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -50),
            titulo.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataSingleton.shared.cuestionarios.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MedalCard
        var imageString = DataSingleton.shared.cuestionarios[indexPath.item].getFoto()
        cell.medalName = DataSingleton.shared.cuestionarios[indexPath.item].getTema()
        if DataSingleton.shared.cuestionarios[indexPath.row].isDisponible() {
            cell.color = Constants.App.Colors.grayTint
            cell.card.layer.shadowRadius = 10
            cell.card.backgroundColor = .systemGray6
        } else {
            cell.color = Constants.App.Colors.grayTint
            imageString.append("-1")
            cell.card.layer.shadowRadius = 5
            cell.card.backgroundColor = .systemGray3
        }
        cell.medal.image = UIImage(named: imageString)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.8, height: self.view.frame.height)
    }

    override func viewWillAppear(_ animated: Bool) {
//        setupNav()
        self.collectionView.reloadData()
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
//    private func setupNav() {
//        UINavigationBar.appearance().barTintColor = .white
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Constants.App.Colors.grayTint]
//        UINavigationBar.appearance().tintColor = Constants.App.Colors.grayTint
//    }
}

class MedalCard: UICollectionViewCell {
    
    var medalName: String? {
        didSet {
            guard let unwrappedName = medalName else { return }
            
            let attributedText = NSMutableAttributedString(string: unwrappedName, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            descriptionTextView.attributedText = attributedText
            descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
            descriptionTextView.textAlignment = .center
            descriptionTextView.isEditable = false
            descriptionTextView.isScrollEnabled = false
        }
    }
    
    var color: UIColor? {
        didSet {
            guard let unwrappedColor = color else { return }
            descriptionTextView.textColor = color
        }
    }
    
    var medal: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var card: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 15
        v.clipsToBounds = true
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 1
        v.layer.shadowOffset = .zero
        v.layer.shadowRadius = 10
        v.layer.masksToBounds = false
        return v
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .none
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        
        addSubview(card)
        NSLayoutConstraint.activate([
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.centerYAnchor.constraint(equalTo: centerYAnchor),
            card.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            card.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
//
        card.addSubview(medal)
        NSLayoutConstraint.activate([
            medal.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            medal.centerYAnchor.constraint(equalTo: card.centerYAnchor, constant: -50),
            medal.heightAnchor.constraint(equalTo: card.heightAnchor, multiplier: 0.55),
            medal.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.7)
        ])
        
        card.addSubview(descriptionTextView)
        NSLayoutConstraint.activate([
            descriptionTextView.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: medal.bottomAnchor, constant: 10),
            descriptionTextView.bottomAnchor.constraint(equalTo: card.bottomAnchor),
            descriptionTextView.widthAnchor.constraint(equalTo: card.widthAnchor, multiplier: 0.9)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
