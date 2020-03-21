//
//  DriverDetailPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 21.03.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol DriverDetailPresenterInterface: class {
    func viewDidAppear()
    func fetchDriverDetails(driverdId: Int)
}

class DriverDetailPresenter {

    unowned var view: DriverDetailViewControllerInterface
    let router: DriverDetailRouter?
    let interactor: DriverDetailInteractorInterface?

    init(interactor: DriverDetailInteractorInterface, router: DriverDetailRouter, view: DriverDetailViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DriverDetailPresenter: DriverDetailPresenterInterface {
    func fetchDriverDetails(driverdId: Int) {
        DispatchQueue.main.async {
            self.interactor?.fetchDriverDetails(driverdId: driverdId)
        }
    }
    
    func viewDidAppear() {
        
    }
}

extension DriverDetailPresenter : DriverDetailInteractorOutputProtocol {
    func driverDetailsFetchedSuccessfully(drivers: DriverDetailsModel) {
        view.prepareDriverDetails(driver: drivers)
    }
    
    func driverDetailsFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
}
