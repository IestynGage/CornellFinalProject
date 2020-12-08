//
//  TabbarController.swift
//  NewsApp
//
//  Created by Iestyn Gage on 17/11/2020.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let nav1 = generateNavController(viewController: FavouriteViewController(), title: "Favourite")
        let nav2 = generateNavController(viewController: PopularArticleViewController(), title: "Popular")
        let nav3 = generateNavController(viewController: SearchArticleTableView(), title: "Search")

        viewControllers = [nav1,nav2,nav3]

    }

    fileprivate func generateNavController(viewController: UIViewController, title: String) -> UINavigationController {
        viewController.navigationItem.title = title

        let navController = UINavigationController(rootViewController: viewController)
        navController.title = title
        return navController
    }
}
