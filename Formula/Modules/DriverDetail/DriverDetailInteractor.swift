//
//  DriverDetailInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 21.03.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol DriverDetailInteractorInterface: class {
    func fetchDriverDetails(driverdId: Int)
}

protocol DriverDetailInteractorOutputProtocol: class {
    func driverDetailsFetchedSuccessfully(drivers: DriverDetailsModel)
    func driverDetailsFetchingFailed(withError error: Error)
}

class DriverDetailInteractor {
    weak var output: DriverDetailInteractorOutputProtocol?
}

extension DriverDetailInteractor: DriverDetailInteractorInterface {
    func fetchDriverDetails(driverdId: Int) {
        RequestManager.shared.getDriverDetails(driverId: driverdId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let driverDetails):
                self.output?.driverDetailsFetchedSuccessfully(drivers: driverDetails)
            case .failure(let error):
                self.output?.driverDetailsFetchingFailed(withError: error)
                print("error: ", error)
            }
        }
    }
    

}
