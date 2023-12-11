//
//  ViewController.swift
//  EcoMarket
//
//  Created by Камаль Атавалиев on 11.12.2023.
//
import UIKit
class MainTabBarView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        tabBar.tintColor = .AccentColor
    }

    private func generateTabBar() {
        viewControllers = [
            generateVC(viewConroller: MainView(),
                       title: "Главная",
                       image: UIImage(named: "TabBarHome")),
            generateVC(viewConroller: CartView(),
                       title: "Корзина",
                       image: UIImage(named: "TabBarCart")),
            generateVC(viewConroller: HistoryView(),
                       title: "История",
                       image: UIImage(named: "TabBarHistory")),
            generateVC(viewConroller: InfoView(),
                       title: "Инфо",
                       image: UIImage(named: "TabBarInfo"))
        ]
    }

    private func generateVC(viewConroller: UIViewController,
                            title: String,
                            image: UIImage?) -> UIViewController {
        viewConroller.tabBarItem.title = title
        viewConroller.tabBarItem.image = image
        return UINavigationController(rootViewController: viewConroller)
    }
}

