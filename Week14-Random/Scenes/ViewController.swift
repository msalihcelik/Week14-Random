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

final class ViewController: UIViewController {
    
    private let tableView = UITableViewBuilder().build()
    private var photoUrls = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        addSubViews()
        getPhotos()
    }
    
    private func getPhotos() {
        let group = DispatchGroup()
        group.enter()
        for _ in 1...5 {
            group.enter()
            Service.shared.getData(url: PhotoUrl.cat, type: CatPhoto.self) { result in
                group.leave()
                switch result {
                case .success(let response):
                    self.photoUrls.append(response.file)
                case .failure(let error):
                    print(error)
                }
            }
            
            group.enter()
            Service.shared.getData(url: PhotoUrl.dog, type: DogPhoto.self) { result in
                group.leave()
                switch result {
                case .success(let response):
                    self.photoUrls.append(response.url)
                case .failure(let error):
                    print(error)
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
