//
//  NotEnoughtAlertViewController.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 23.12.2023.
//

import UIKit

class NotEnoughtAlertViewController: UIViewController {
    
    let image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "BagIcon")
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    
    let message: UILabel = {
        let lbl = UILabel()
        lbl.text = "Заказ может быть при покупке свыше 300 с"
        lbl.font = UIFont(name: "TTNormsPro-Bold", size: 24)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let closeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Закрыть", for: .normal)
        btn.backgroundColor = .AccentColor
        btn.layer.cornerRadius = 12
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTargetsForButtons()
        view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
    }
    
    private func setupConstraints() {
        view.addSubview(image)
        view.addSubview(message)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            image.widthAnchor.constraint(equalToConstant: 163),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 28),
            message.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 24),
            closeButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32),
            closeButton.heightAnchor.constraint(equalToConstant:  54),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupTargetsForButtons() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
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
