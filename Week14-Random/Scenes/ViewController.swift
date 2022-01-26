//
//  ViewController.swift
//  Week14-Random
//
//  Created by Mehmet Salih ÇELİK on 20.01.2022.
//

import UIKit
import MobilliumBuilders
import TinyConstraints
import Alamofire

class ViewController: UIViewController {

    private let tableView = UITableViewBuilder().build()
    var photoUrls = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addSubViews()
        getPhotos()
    }

    func getPhotos() {
        let group = DispatchGroup()

        // Parent
        group.enter()
        for _ in 1...5 {
            // Child1
            group.enter()
            AF.request(PhotoUrl.cat, method: .get).response { responseData in
                group.leave()
                guard let data = responseData.data else { return }
                do {
                    let catPhoto = try JSONDecoder().decode(CatPhoto.self, from: data)
                    self.photoUrls.append(catPhoto.file)
                } catch {
                    print("error", error)
                }
            }

            // Child2
            group.enter()
            AF.request(PhotoUrl.dog, method: .get).response { responseData in
                group.leave()
                guard let data = responseData.data else { return }
                do {
                    let dogPhoto = try JSONDecoder().decode(DogPhoto.self, from: data)
                    self.photoUrls.append(dogPhoto.url)
                } catch {
                    print("error", error)
                }
            }
        }
        group.leave()
        group.notify(queue: .main) {
            self.photoUrls.shuffle()
            self.tableView.reloadData()
        }
    }
}

// MARK: - SubViews
extension ViewController {

    private func addSubViews() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.edgesToSuperview(usingSafeArea: true)
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: CellIdentifier.myCell)
    }
}

// MARK: - TableViewDelegate & TableViewDataSource Methods
extension ViewController: UITableViewDelegate { }
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)) / 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoUrls.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.myCell, for: indexPath) as? ImageTableViewCell {
            cell.customImageView.configureKF(url: self.photoUrls[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
