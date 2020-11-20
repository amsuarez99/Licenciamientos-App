//
//  HistorietaController.swift
//  Cuestionario
//
//  Created by Marcelo Suárez on 12/11/20.
//

import UIKit

class HistorietaController: UIViewController {

    var historieta: Historieta? {
        didSet {
            
            guard let unwrappedHistorieta = historieta else { return }
            imageView.image = UIImage(named:unwrappedHistorieta.getFoto())
            let attributedText = NSMutableAttributedString(string: unwrappedHistorieta.getTitulo(), attributes: [NSAttributedString.Key.font: Constants.App.Fonts.titleFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint])
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedHistorieta.getExplicacion())", attributes: [NSAttributedString.Key.font: Constants.App.Fonts.textFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.lightGrayTint]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    

    private func setupLayout() {
        let topImageContainerView = UIView()
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topImageContainerView)
    
        topImageContainerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true

        topImageContainerView.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.6).isActive = true
        imageView.widthAnchor.constraint(equalTo: topImageContainerView.widthAnchor, multiplier: 0.5).isActive = true
        
        self.view.addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

