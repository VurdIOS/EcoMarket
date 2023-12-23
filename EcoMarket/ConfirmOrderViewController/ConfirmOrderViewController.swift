//
//  ConfirmOrderViewController.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 23.12.2023.
//

import UIKit

class ConfirmOrderViewController: UIViewController {
    
    let phoneNumberTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Номер телефона"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let adressTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Адрес"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let orientTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Ориентир"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let commentTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Комментарии"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let VStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let totalCostLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Сумма заказа ? с"
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 20)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
        
    }()
    
    let makeOrderButton: UIButton = {
      let btn = UIButton()
        btn.setTitle("Заказать доставку", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Оформление заказа"
        setupCinstraints()

        // Do any additional setup after loading the view.
    }
    
    private func setupCinstraints() {
        VStack.addArrangedSubview(phoneNumberTF)
        VStack.addArrangedSubview(adressTF)
        VStack.addArrangedSubview(orientTF)
        VStack.addArrangedSubview(commentTF)
        
        view.addSubview(VStack)
        view.addSubview(makeOrderButton)
        view.addSubview(totalCostLabel)
        
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            VStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            VStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            VStack.heightAnchor.constraint(equalToConstant: 216)
        ])
        
        NSLayoutConstraint.activate([
            makeOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            makeOrderButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            makeOrderButton.heightAnchor.constraint(equalToConstant: 54),
            makeOrderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totalCostLabel.bottomAnchor.constraint(equalTo: makeOrderButton.topAnchor, constant: -30),
            totalCostLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            totalCostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
