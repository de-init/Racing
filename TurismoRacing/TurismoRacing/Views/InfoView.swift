//
//  InfoView.swift
//  TurismoRacing
//
//  Created by S2 on 12.08.22.
//

import UIKit

class InfoView: UIView {
    private let textView: UITextView
    private var stackButton: UIStackView!
    private var telegramButton: UIButton!
    private var githubButton: UIButton!
    private var linkedButton: UIButton!
    
    override init(frame: CGRect) {
        textView = UITextView()
        stackButton = UIStackView()
        telegramButton = UIButton()
        githubButton = UIButton()
        linkedButton = UIButton()
        
        super.init(frame: frame)
        configureView()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configureView() {
        backgroundColor = .init(hex: 0x395C6B)
    }
    
    private func setupUI() {
        makeTextView()
        makeTelegramButton()
        makeLinkedButton()
        makeGitButton()
        makeStackButtons()
    }
    private func makeTextView() {
        textView.text = Strings.info.localized
        textView.font = UIFont(name: Fonts.Montserrat.regular.fontName, size: 23)
        textView.textAlignment = .center
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        textView.adjustsFontForContentSizeCategory = true
        addSubview(textView)
    }
    private func makeStackButtons() {
        stackButton = UIStackView(arrangedSubviews: [telegramButton, linkedButton, githubButton])
        stackButton.axis = .horizontal
        stackButton.distribution = .fillEqually
        stackButton.alignment = .fill
        stackButton.spacing = 25
        addSubview(stackButton)
    }
    private func makeTelegramButton() {
        telegramButton = createButton(image: "ic_telegramButton")
        telegramButton.addTarget(self, action: #selector(telegram), for: .touchUpInside)
        addSubview(telegramButton)
    }
    private func makeLinkedButton() {
        linkedButton = createButton(image: "ic_linkedinButton")
        linkedButton.addTarget(self, action: #selector(linked), for: .touchUpInside)
        addSubview(linkedButton)
    }
    private func makeGitButton() {
        githubButton = createButton(image: "ic_githubButton")
        githubButton.addTarget(self, action: #selector(github), for: .touchUpInside)
        addSubview(githubButton)
    }
    // MARK: - Additional Methods
    private func createButton(image: String) -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: image), for: .normal)
        button.setBackgroundImage(UIImage(named: image)?.withAlpha(0.8), for: .highlighted)
        button.subviews.first?.contentMode = .scaleAspectFill
        return button
    }
    func openLink(link: String) {
        let url = URL(string: link)!
        let application = UIApplication.shared
        application.open(url)
    }
    @objc private func telegram() {
        openLink(link: Resources.Links.telegram.rawValue)
    }
    @objc private func linked() {
        openLink(link: Resources.Links.linked.rawValue)
    }
    @objc private func github() {
        openLink(link: Resources.Links.github.rawValue)
    }
    // MARK: - Layout
    override func layoutSubviews() {
        setupLayout()
    }
    private func setupLayout() {
        makeConstraintsTextView()
    }
    private func makeConstraintsTextView() {
        textView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
        }
        stackButton.snp.makeConstraints { make in
            make.bottom.equalTo(textView).offset(120)
            make.height.equalTo(70)
            make.leading.equalTo(60)
            make.trailing.equalTo(-60)
        }
    }
}
