//
//  LeaderBoardViewController.swift
//  TurismoRacing
//
//  Created by S2 on 30.06.22.
//

import UIKit

class LeaderboardViewController: UIViewController {
    private let leaderboardView = LeaderboardView()
    private let tableView = UITableView()
    private var results = [Result]()
    private var height: CGFloat!
    var coordinator: Coordinator?
    
    override func loadView() {
        self.view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        
        if let savedResult = ResultsManager.savedResults() {
            results = savedResult.sorted(by: { $0.score > $1.score })
        }
    }
    
    // MARK: - Setup Methods
    private func setTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    // MARK: - Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    private func setupConstraints() {
        makeLayoutLeaderboardView()
        makeConstraintsTableView()
    }

    private func makeConstraintsTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.bottom.equalTo(-40)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
        }
    }
    
    private func makeLayoutLeaderboardView() {
        leaderboardView.frame = view.bounds
    }
}

// MARK: - Extensions
extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellSpacingHeight: CGFloat = 1
        return cellSpacingHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor.init(hex: 0xD25310)
        } else if indexPath.section == 1 {
            cell.backgroundColor = UIColor.init(hex: 0x99BE3B)
        } else if indexPath.section == 2 {
            cell.backgroundColor = UIColor.init(hex: 0xF6D300)
        } else {
            cell.backgroundColor = UIColor.init(hex: 0xFFB53D)
        }
        let resultModel = results[indexPath.section]
        cell.layer.cornerRadius = height / 2
        cell.countLable.text = "\(indexPath.section + 1)."
        cell.scoreLable.text = String(resultModel.score)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        height = 80
        return height
    }
}
