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
    private var navBar = UIView()
    private var results = [Result]()
    private var height: CGFloat!
    var coordinator: Coordinator?
    
    override func loadView() {
        self.view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        loadScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup Methods
    private func setupNavigationBar() {
        let leftItem = CustomNavigationBarItem(imageName: "backButtonImage", itemAction: { [weak self] in
            self?.coordinator?.stepBack() })
        let rightItem = CustomNavigationBarItem(imageName: "resetButtonImage", itemAction: { self.tryReset() })
        navBar = CustomNavigationBar(leftItem: leftItem, rightItem: rightItem, titleText: Strings.leaderboard.localized)
        navBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBar)
    }

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
    
    private func loadScore() {
        if let savedResult = ResultsManager.savedResults() {
            results = savedResult.sorted(by: { $0.score > $1.score })
        }
    }
    
    private func tryReset() {
        ResultsManager.clearResults()
        results = [Result]()
        tableView.reloadData()
    }

    // MARK: - Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }
    private func setupConstraints() {
        makeLayoutLeaderboardView()
        makeConstraintsTableView()
        makeConstraintsNavBar()
    }

    private func makeConstraintsTableView() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBar).offset(60)
            make.bottom.equalTo(-40)
            make.leading.equalTo(40)
            make.trailing.equalTo(-40)
        }
    }
    
    private func makeConstraintsNavBar() {
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
            make.width.equalTo(view.bounds.width)
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
