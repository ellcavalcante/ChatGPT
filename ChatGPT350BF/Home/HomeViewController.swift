//
//  ViewController.swift
//  ChatGPT350BF
//
//  Created by Ellington Cavalcante on 11/05/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeScreen: HomeScreen? = HomeScreen()
    var viewModel: HomeViewModel = HomeViewModel()
    
    override func loadView() {
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreen?.configTableViewProtocols(delegate: self, dataSource: self)
        homeScreen?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addLogoToNavigationBarItem(image: UIImage(named: "BF_Logo") ?? UIImage())
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.loadCurrentMessage(indexPath: indexPath)
        switch model.typeMessage {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextTableViewCell.identifier, for: indexPath) as? OutgoingTextTableViewCell
            cell?.setupCell(message: model.message)
            return cell ?? UITableViewCell()
        case .chatGPT:
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            cell?.setupCell(message: model.message)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
}

extension HomeViewController: HomeScreenProtocol {
    func sendMessage(text: String) {
        viewModel.addMessage(message: text)
        homeScreen?.tableView.reloadData()
        homeScreen?.messageTextField.text = ""
    }
}
