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
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Оформление заказа"

        // Do any additional setup after loading the view.
    }
    
    private func setupCinstraints() {
        VStack.addArrangedSubview(phoneNumberTF)
        VStack.addArrangedSubview(adressTF)
        VStack.addArrangedSubview(orientTF)
        VStack.addArrangedSubview(commentTF)
        
        view.addSubview(VStack)
        
        NSLayoutConstraint.activate([
            VStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            VStack.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            VStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
