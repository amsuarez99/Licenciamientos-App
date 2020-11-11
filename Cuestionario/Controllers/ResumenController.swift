//
//  QuestionController.swift
//  Cuestionario
//
//  Created by user180523 on 11/4/20.
//
import UIKit

extension NSMutableAttributedString {
    var fontSize:CGFloat { return 14 }
    var boldFont:UIFont { return UIFont(name: "AvenirNext-Bold", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize) }
    var normalFont:UIFont { return UIFont(name: "AvenirNext-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)}

    func bold(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : Constants.App.Fonts.markupFont
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : Constants.App.Fonts.textFont
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    /* Other styling methods */
    func orangeHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.orange
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func blackHighlight(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : UIColor.white,
            .backgroundColor : UIColor.black

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func underlined(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue

        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
}

class ResumenController: UIViewController{

//    var tableView : UITableView
    
    private let titulo: UITextView = {
       let textView = UITextView()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        var attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: Constants.App.Fonts.titleFont
        ]
        let attributedText = NSMutableAttributedString(string: "¿QUÉ DICE LA LEY?", attributes: attributes)

        attributedText.normal("\n\n\nLa ").bold("Ley Federal del Derecho de Autor").normal(" define a una").bold(" obra ").normal("como: ").normal("Sed rhoncus tincidunt mi. In consequat a lectus suscipit tristique. Proin vestibulum tortor vel leo sagittis tempus. In hac habitasse platea dictumst.\n\n")
        attributedText.bold("Ley federal del derecho de autor: ").normal("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tellus arcu, bibendum at tincidunt quis, laoreet nec enim. Sed nunc urna, rhoncus at sollicitudin at, rhoncus eu nunc. Sed rhoncus tincidunt mi. In consequat a lectus suscipit tristique. Proin vestibulum tortor vel leo sagittis tempus. In hac habitasse platea dictumst.\n\n\n")
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .lightGray
        return textView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let textoContainerView = UIView()
        textoContainerView.translatesAutoresizingMaskIntoConstraints = false
        textoContainerView.backgroundColor = .lightGray
        textoContainerView.layer.cornerRadius = 10
        textoContainerView.clipsToBounds = true
        self.view.addSubview(textoContainerView)
        NSLayoutConstraint.activate([
            textoContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textoContainerView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
            textoContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textoContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        textoContainerView.addSubview(titulo)
        NSLayoutConstraint.activate([
            titulo.leadingAnchor.constraint(equalTo: textoContainerView.leadingAnchor, constant: 20),
            titulo.trailingAnchor.constraint(equalTo: textoContainerView.trailingAnchor, constant: -20),
            titulo.centerYAnchor.constraint(equalTo: textoContainerView.centerYAnchor),
            titulo.heightAnchor.constraint(equalTo: textoContainerView.heightAnchor, multiplier: 0.8)
        ])
    }
}
