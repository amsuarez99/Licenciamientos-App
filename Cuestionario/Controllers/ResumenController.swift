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
            .font : Constants.App.Fonts.markupFont!
        ]

        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }

    func normal(_ value:String) -> NSMutableAttributedString {

        let attributes:[NSAttributedString.Key : Any] = [
            .font : Constants.App.Fonts.textFont!
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
    
    private let titulo: UITextView = {
       let textView = UITextView()
        let centerPS = NSMutableParagraphStyle()
        centerPS.alignment = .center
        let leftPS = NSMutableParagraphStyle()
        leftPS.alignment = .left
        
        var attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: centerPS,
            .font: Constants.App.Fonts.titleFont!
        ]
        let attributedText = NSMutableAttributedString(string: "¿QUÉ DICE LA LEY?", attributes: attributes)
        let stringText = DataSingleton.shared.cuestionarios[DataSingleton.shared.usuario.cuestionarioActual].getLeccion().getTexto()
        attributedText.append(NSMutableAttributedString(string: "\n\n" + stringText, attributes: [NSAttributedString.Key.font: Constants.App.Fonts.textFont!, NSAttributedString.Key.foregroundColor: Constants.App.Colors.grayTint, NSAttributedString.Key.paragraphStyle: leftPS]))
        textView.attributedText = attributedText
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let textoContainerView = UIView()
        textoContainerView.translatesAutoresizingMaskIntoConstraints = false
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
