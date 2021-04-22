//
//  MapFilterViewController.swift
//  DoSport
//
//  Created by Sergey on 29.12.2020.
//

import UIKit

class MapFilterViewController: UITableViewController {
    
    //MARK: - Outlets
    var coordinator: MapFilterCoordinator?
    let viewModel: MapFilterViewModel

    // MARK: - Init
    init(viewModel: MapFilterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        setupTableView()
        self.navigationController?.navigationBar.barTintColor = Colors.darkBlue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: SportTypeTableViewCell = SportTypeTableViewCell(style: .default, reuseIdentifier: "firstCustomCell")
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell: CitySelectTableViewCell = CitySelectTableViewCell(style: .default, reuseIdentifier: "secondCustomCell")
            
            return cell
        }
        else if indexPath.row == 2 {
            let cell: MetroSelectTableViewCell = MetroSelectTableViewCell(style: .default, reuseIdentifier: "thirdCustomCell")

            return cell
        }
        else {
            let cell: PlaceTypeTableViewCell = PlaceTypeTableViewCell(style: .default, reuseIdentifier: "fourthCustomCell")
            return cell
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func setupTableView()  {
        self.tableView.delegate = self
        self.tableView.dataSource  = self
        tableView.backgroundColor = Colors.darkBlue
        tableView.separatorColor = Colors.lightBlue

    }
    //MARK: - SetupUI
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

