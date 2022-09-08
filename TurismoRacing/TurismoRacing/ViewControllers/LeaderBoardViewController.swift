//
//  LeaderBoardViewController.swift
//  TurismoRacing
//
//  Created by S2 on 30.06.22.
//

import UIKit

class LeaderBoardViewController: UIViewController {
    private let leaderboardView = LeaderboardView()
    private let tableView = UITableView()
    private var scoreArray = [Int]()
    private var sortedArray = [Int]()
    private var height: CGFloat!
    
    override func loadView() {
        self.view = leaderboardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        loadScores()
    }
    
    // MARK: - Setup Methods
    private func setTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    // MARK: - Private Methods
    private func loadScores() {
        guard let array = Globals.userDefaults.object(forKey: "score") as? [Int] else {
            return
        }
        scoreArray = array
        sortedArray = scoreArray.compactMap{Int($0)}.sorted(by: >)
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
extension LeaderBoardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return scoreArray.count
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
        cell.layer.cornerRadius = height / 2
        cell.countLable.text = "\(indexPath.section + 1)."
        cell.countLable.textColor = .white
        cell.countLable.numberOfLines = 0
        cell.countLable.adjustsFontSizeToFitWidth = true
        cell.countLable.font = UIFont(name: Fonts.Poppins.semiBold.fontName, size: 45)
        cell.scoreLable.text = "\(sortedArray[indexPath.section])"
        cell.scoreLable.textColor = .white
        cell.scoreLable.font = UIFont(name: Fonts.Poppins.semiBold.fontName, size: 35)
        cell.scoreLable.numberOfLines = 0
        cell.scoreLable.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        height = 80
        return height
    }
}
