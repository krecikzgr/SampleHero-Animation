//
//  MainViewController.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit


class MainViewController: UIViewController {
    
    var tableView: UITableView?
    var items: [MainCellViewModel] = []
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView?.reloadData()
    }
    
    private func initialize() {
        navigationController?.delegate = self
        initTableView()
        registerCells()
        initItems()
    }
    
    private func initTableView() {
        tableView = UITableView()
        tableView?.rowHeight = UITableView.automaticDimension

        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.addSubview(tableView!)
        
        tableView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }

    private func initItems() {
        items = RandomViewModelsGenerator.getViewModels(amount: 20)
    }
    
    private func registerCells() {
        tableView?.register(cellClass: MainViewCell.self)
    }
    
    func getAvatarImage() -> AvatarView {
        guard let indexPath = self.selectedIndex,
              let cell = tableView?.cellForRow(at: indexPath) as? MainViewCell else {
            return AvatarView()
        }
        return cell.avatarView
    }
    
    func getSelectedViewModel() -> MainCellViewModel? {
        guard let indexPath = self.selectedIndex else {
            return nil
        }
        return items[indexPath.row]
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: MainViewCell.self,
                                                 forIndexPath: indexPath)
        cell.update(viewModel: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let item = items[indexPath.row]
        let detailsController = DetailsController()
        
        detailsController.titleLabel.text = item.title
        
        navigationController?.modalPresentationStyle = .custom
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension MainViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PresentAnimation(animationDuration: 1.5)
        case .pop:
            return DismissAnimation(duration: 1.5)
        default:
            return nil
        }
    }
}
