//
//  AppFlowCoordinator.swift
//  NaviAssignment
//
//  Created by Athul Sai on 26/07/22.
//

import UIKit

protocol FlowCoordinator {
    func start()
}

class AppFlowCoordinator: FlowCoordinator {
    let appDependencyContainer: AppDependencyContainer
    let navigationController: UINavigationController = UINavigationController()

    init(appDependencyContainer: AppDependencyContainer) {
        self.appDependencyContainer = appDependencyContainer
    }

    func start() {
        goToPullRequestsVC()
    }

    func goToPullRequestsVC() {
        let pullRequestsViewController = appDependencyContainer.makePullRequestsViewController()
        navigationController.pushViewController(pullRequestsViewController, animated: false)
    }
}
