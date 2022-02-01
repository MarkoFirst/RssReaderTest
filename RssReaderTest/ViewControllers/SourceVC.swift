//
//  SourceVC.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import TinyConstraints
import Hero
import UIKit

class SourceVC: ViewController {
    private var tableView: UITableView!
    private let presenter = NewsPresenter()
    private var newsList: [News] = []
    private var currentSource: Source!
    
    init(_ news: [News], _ source: Source) {
        self.newsList = news
        currentSource = source
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(back))
        swipe.direction = .down
        
        let headerView = UIView()
        headerView.hero.id = "cell"
        headerView.backgroundColor = Config.pinkColor
        headerView.addGestureRecognizer(swipe)
        view.addSubview(headerView)
        
        let closeBtn = UIButton(type: .close)
        closeBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        headerView.addSubview(closeBtn)
        
        let titleLabel = UILabel()
        titleLabel.hero.id = "title"
        titleLabel.text = currentSource.name
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        headerView.addSubview(titleLabel)
        
        let textField = UITextField()
        textField.placeholder = "search"
        textField.delegate = self
        headerView.addSubview(textField)

        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UINib(nibName: "NewsTVC", bundle: nil), forCellReuseIdentifier: "TVC")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        view.addSubview(tableView)
        
        headerView.topToSuperview()
        headerView.leadingToSuperview()
        headerView.trailingToSuperview()
        
        closeBtn.topToSuperview(offset: 24, usingSafeArea: true)
        closeBtn.trailingToSuperview(offset: 24)
        
        titleLabel.topToSuperview(offset: 24, usingSafeArea: true)
        titleLabel.leadingToSuperview(offset: 24)
        titleLabel.trailingToSuperview(offset: 24)
        
        textField.topToBottom(of: titleLabel, offset: 12)
        textField.leadingToSuperview(offset: 24)
        textField.trailingToSuperview(offset: 24)
        textField.bottomToSuperview(offset: -24)
        textField.height(24)
        
        tableView.topToBottom(of: headerView)
        tableView.leadingToSuperview()
        tableView.trailingToSuperview()
        tableView.bottomToSuperview()
    }
    
    @objc func back() {
        dismiss(animated: true)
    }
}

extension SourceVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVC", for: indexPath) as? NewsTVC else { return UITableViewCell() }
        
        let news = newsList[indexPath.row]
        cell.setup(news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let news = newsList[indexPath.row]
        present(WebViewVC(news.url), animated: true)
    }
}

extension SourceVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.everything(sourceId: currentSource.id ?? "", query: textField.text ?? "") { news_ in
            guard let news = news_, !news.isEmpty else { return }
            
            self.newsList = news
            self.tableView.reloadData()
        }
    }
}
