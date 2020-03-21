//
//  DriverPresenter.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 21.03.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol DriverPresenterInterface: class {
    func viewDidAppear()
    func rowTapped(driverId: Int)
    func getNumberOfRows() -> Int
    func getDriverItems(at index : Int) -> DriverItem
}

class DriverPresenter {

    unowned var view: DriverViewControllerInterface
    let router: DriverRouterInterface?
    let interactor: DriverInteractorInterface?
    
    var driverResponse = [DriverItem]()
    
    init(interactor: DriverInteractorInterface, router: DriverRouterInterface, view: DriverViewControllerInterface) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DriverPresenter : DriverPresenterInterface {
    func rowTapped(driverId: Int) {
        router?.navigateToDetailWith(driverId: driverId)
    }
    
    func getDriverItems(at index : Int) -> DriverItem {
        return driverResponse[index]
    }
    
    func getNumberOfRows() -> Int {
        return driverResponse.count
    }
    
    func viewDidAppear() {
        DispatchQueue.main.async {
            self.interactor?.fetchDrivers()
        }
    }
}

extension DriverPresenter : DriverInteractorOutputProtocol {

    func driverListFetchedSuccessfully(drivers: DriverModel) {
        guard var items = drivers.items else {return}
        items.sort{($0.point ?? 0) > ($1.point ?? 0)}
        self.driverResponse = items
        view.prepareTableView()
        view.reloadTableView()
    }
    
    func driverListFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
}
