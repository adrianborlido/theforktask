//
//  RestaurantsViewController.swift
//  TheForkTask
//
//  Created by Adrian Borlido on 7/5/22.
//

import UIKit

class RestaurantsViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .darkGray
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.identifier)
        return tableView
    }()
    var provider: RestaurantsProviderInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "restaurants".localized
        view.backgroundColor = .darkGray
        
        navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "sort".localized, style: .plain, target: self, action: #selector(didTapSort))
        navigationItem.rightBarButtonItem?.tintColor = .forkLightGreen
        
        view.addSubview(tableView)
        constraintsInit()
        
        provider?.getRestaurants()
    }
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    @objc private func didTapSort() {
        let alert = UIAlertController(title: "sortBy".localized, message: nil, preferredStyle: .alert)
        alert.view.tintColor = .forkLightGreen
        
        alert.addAction(UIAlertAction(title: "name".localized, style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "rating".localized, style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized, style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provider?.restaurants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.identifier, for: indexPath as IndexPath) as? RestaurantTableViewCell,
              let restaurant =  provider?.restaurants?[indexPath.row] else {
                  return UITableViewCell()
              }
        let isFavorite = try? UserDefaultsManager.shared.getObject(forKey: restaurant.uuid ?? "", ofType: Bool.self)
        cell.setData(restaurant: restaurant, isFavorite: isFavorite ?? false)
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120+tableView.frame.size.width*344/612
    }
}

extension RestaurantsViewController: RestaurantsProviderDelegate {
    func getRestaurantsSucceed() {
        tableView.reloadData()
    }
    
    func getRestaurantsFailed() {
        // TODO: - Display failed state
    }
}
