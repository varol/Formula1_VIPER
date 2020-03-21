//
//  DriverViewController.swift
//  CIViperGenerator
//
//  Created by Varol AKSOY on 21.03.2020.
//  Copyright © 2020 Varol AKSOY. All rights reserved.
//

import UIKit

protocol DriverViewControllerInterface: class {
    func reloadTableView()
    func prepareTableView()
}

class DriverViewController: UIViewController {
    var presenter: DriverPresenterInterface!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        presenter.viewDidAppear()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DriverViewController: DriverViewControllerInterface {
    func prepareTableView() {
        tableView.register(UINib(nibName: "DriverListCell",
                                 bundle: nil), forCellReuseIdentifier: "myCell")
    }
    
    func reloadTableView(){
        tableView.reloadData()
    }
}

extension DriverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! DriverListCell
        let item = presenter.getDriverItems(at: indexPath.row)
        cell.configure(item: item, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Sizes.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item  = presenter.getDriverItems(at: indexPath.row)
        self.presenter.rowTapped(driverId: item.id ?? 0)
    }
}

extension DriverViewController : DriverCellDelegate {
    func addFavoriteTapped() {
        //TO DO: Favoriye eklendiğinde ekleme işlemi
        print("add favorite")
    }
}
