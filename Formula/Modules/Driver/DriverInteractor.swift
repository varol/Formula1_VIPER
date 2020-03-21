//
//  DriverInteractor.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 21.03.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import Foundation

protocol DriverInteractorInterface: class {
    func fetchDrivers()
}

protocol DriverInteractorOutputProtocol: class {
    func driverListFetchedSuccessfully(drivers: DriverModel)
    func driverListFetchingFailed(withError error: Error)
}

final class DriverInteractor {
    weak var output: DriverInteractorOutputProtocol?
}

extension DriverInteractor: DriverInteractorInterface {
    func fetchDrivers() {
        RequestManager.shared.getDrivers { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let drivers):
                self.output?.driverListFetchedSuccessfully(drivers: drivers)
            case .failure(let error):
                self.output?.driverListFetchingFailed(withError: error)
                print("error: ", error)
            }
        }
    }
}
