//
//  InfoView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//

import UIKit

class InfoView: UIViewController {
    let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "InfoVCImage")
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    let tittle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Эко Маркет"
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 24)
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let message: UILabel = {
        let lbl = UILabel()
        lbl.text = """
Фрукты, овощи, зелень, сухофрукты а так же сделанные из натуральных ЭКО продуктов (варенье, салаты, соления, компоты и т.д.) можете заказать удобно, качественно и по доступной цене.
Готовы сотрудничать взаимовыгодно с магазинами.
Наши цены как на рынке.
Мы заинтересованы в экономии ваших денег и времени.
Стоимость доставки 150 сом и ещё добавлен для окраину города.
При отказе подтвержденного заказа более
2-х раз Клиент заносится в чёрный список!!
"""
        
    
        
        
        lbl.font = UIFont(name: "TTNormsPro-Medium", size: 16)
        lbl.textColor = .greyForBorders
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let phoneButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "phone"), for: .normal)
        btn.setTitle(" Позвонить", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    let waButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "whatsapp"), for: .normal)
        btn.setTitle(" WhatsApp", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    let instButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "instagram"), for: .normal)
        btn.setTitle(" Instagram", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.9728776813, green: 0.9728776813, blue: 0.9728776813, alpha: 1)
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    lazy var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.contentSize = CGSize(width: view.frame.width, height: 300)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
        
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .MainBackgroundColor
        
        setupConstraitns()
    }
    
    private func setupConstraitns() {
        view.addSubview(image)
        view.addSubview(tittle)
        view.addSubview(message)

        scrollView.addSubview(phoneButton)
        scrollView.addSubview(waButton)
        scrollView.addSubview(instButton)
        view.addSubview(scrollView)
        
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leftAnchor.constraint(equalTo: view.leftAnchor),
            image.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tittle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 16),
            tittle.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            tittle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: tittle.bottomAnchor, constant: 8),
            message.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 32),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        
        
        NSLayoutConstraint.activate([
            phoneButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            phoneButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            phoneButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            phoneButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            waButton.topAnchor.constraint(equalTo: phoneButton.bottomAnchor, constant: 33),
            waButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            waButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            waButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        NSLayoutConstraint.activate([
            instButton.topAnchor.constraint(equalTo: waButton.bottomAnchor, constant: 33),
            instButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),
            instButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            instButton.heightAnchor.constraint(equalToConstant: 54)
        ])

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
