//
//  ViewController.swift
//  Week14-Random
//
//  Created by Mehmet Salih ÇELİK on 20.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

class ViewController: UIViewController {

    private let tableView = UITableViewBuilder().build()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - SubViews
extension ViewController {

    private func addSubViews() {
        tableView.edgesToSuperview(usingSafeArea: true)
    }
}

// MARK: - TableViewDataSource Methods
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
