//
//  DetailProductCollectionView.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 12.12.2023.
//

import UIKit

class DetailProductCollectionView: UIViewController {
    let segment = UISegmentedControl()
    var startTypeProduct: String!
    let searchController = UISearchController()
    var segmentedController: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavController()
        setupSearchBar()
        setupSegmentedController()
        setupConstraints()

        view.backgroundColor = .MainBackgroundColor
        print(startTypeProduct ?? "PUSTO")

        
        

        // Do any additional setup after loading the view.
    }
    
    private func setupSegmentedController() {
        let items = ["Все", "Фрукты", "Сухофрукты", "Овощи", "Зелень", "Чай кофе", "Молочные продукты"]
        segmentedController = UISegmentedControl(items: items)
        segmentedController.addTarget(self, action: #selector(add), for: .valueChanged)
        segmentedController.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    @objc func add(segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("Segment Все selected")
        case 1:
            print("Segment Фрукты selected")
        case 2:
            print("Segment Сухофрукты selected")
        case 3:
            print("Segment Овощи selected")
        case 4:
            print("Segment Зелень selected")
        case 5:
            print("Segment Чай кофе selected")
        case 6:
            print("Segment Молочные продукты selected")
        default:
            break
            
        }
    }
    private func setupSearchBar() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        searchController.searchBar.placeholder = "Fast search"
        searchController.searchBar.setImage(UIImage(named: "TabBarHome"), for: .search, state: .normal)
    }
    
    private func setupConstraints() {
        view.addSubview(segmentedController)

        NSLayoutConstraint.activate([
            segmentedController.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            segmentedController.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            segmentedController.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
    }
    
    private func setupNavController() {
        navigationItem.searchController = searchController
        let backImage = UIImage(systemName: "chevron.backward")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popnav))
        title = "Продукты"
    }
    
    @objc private func popnav() {
        self.navigationController?.popViewController(animated: true)
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
//func setNavigationBar() {
//
//    self.navigationItem.setHidesBackButton(true, animated:false)
//
//    //your custom view for back image with custom size
//    let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//    let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
//
//    if let imgBackArrow = UIImage(named: "icn_back_arrow") {
//        imageView.image = imgBackArrow
//    }
//    view.addSubview(imageView)



//Вот это можно использовать наверное для кнопок
//    let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
//    view?.addGestureRecognizer(backTap)
//
//    let leftBarButtonItem = UIBarButtonItem(customView: view ?? UIView())
//    self.navigationItem.leftBarButtonItem = leftBarButtonItem
//}
//
//@objc func backToMain() {
//    self.navigationController?.popViewController(animated: true)
//}
