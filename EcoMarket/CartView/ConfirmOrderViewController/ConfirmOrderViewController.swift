//
//  ConfirmOrderViewController.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 23.12.2023.
//

import UIKit

class ConfirmOrderViewController: UIViewController {
    
    var orderedProducts: [Product] = []
    
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
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isEnabled = false
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(createOrderItemFromProduct())
        
        title = "Оформление заказа"
        setupCinstraints()
        setupButtonsTargets()

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
    
    private func setupButtonsTargets() {
        makeOrderButton.addTarget(self, action: #selector(makeOrderButtonTapped), for: .touchUpInside)
        phoneNumberTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        adressTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        orientTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        commentTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func POSTOrder() {
        let orderPost = OrderPost(products: createOrderItemFromProduct(), phoneNumber: phoneNumberTF.text!, address: adressTF.text!, referencePoint: orientTF.text!, comments: commentTF.text!)
        NetworkManager.shared.POSTOrderList(with: orderPost) { result in
            switch result {
            case .success(let success):
                print("Zaebis otpravil")
            case .failure(let failure):
                print("Blyaaaa")
            }
        }
    }
    
    private func createOrderItemFromProduct() -> [OrderItem] {
        var order: [OrderItem] = []
        for product in orderedProducts {
            order.append(OrderItem(product: product.id, quantity: product.quantity))
        }

        return order
    }
    
    @objc private func makeOrderButtonTapped() {
        POSTOrder()
    }
    
    
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if phoneNumberTF.text != "", adressTF.text != "", orientTF.text != "", commentTF.text != "" {
            makeOrderButton.isEnabled = true
            makeOrderButton.backgroundColor = .AccentColor
        } else {
            makeOrderButton.isEnabled = false
            makeOrderButton.backgroundColor = .lightGray
        }

    }

}

extension ConfirmOrderViewController: UITextFieldDelegate {
 
}
