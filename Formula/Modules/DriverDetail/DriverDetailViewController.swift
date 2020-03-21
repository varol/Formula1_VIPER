//
//  DriverDetailViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 21.03.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit
import Kingfisher

protocol DriverDetailViewControllerInterface: class {
    func prepareDriverDetails(driver: DriverDetailsModel)
}

class DriverDetailViewController: UIViewController {
    var presenter: DriverDetailPresenterInterface!
    
    var driverId: Int!

    @IBOutlet weak var driverImage: UIImageView!
    @IBOutlet weak var driverTeam: UILabel!
    @IBOutlet weak var driverAge: UILabel!
    
    override func viewDidLoad() {
        presenter.fetchDriverDetails(driverdId: driverId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter?.viewDidAppear()
    }
}

extension DriverDetailViewController: DriverDetailViewControllerInterface {
    func prepareDriverDetails(driver: DriverDetailsModel) {
        driverAge.text = "Age: \(driver.age ?? 0)"
        driverTeam.text = "Team: \(driver.team ?? "")"
        let url = URL(string: driver.image ?? "")
        driverImage.kf.setImage(with: url)
    }
}
