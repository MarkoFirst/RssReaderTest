//
//  MainVC.swift
//  RssReaderTest
//
//  Created by MF-Citrus on 01.02.2022.
//

import Foundation
import TinyConstraints
import Hero

class MainVC: ViewController {
    private let presenter = NewsPresenter()
    private var collectionView: UICollectionView!
    private var openedCell: IndexPath? = nil
    
    private var sources: [Source] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayouts()
        
        presenter.sources() { list_ in
            guard let list = list_, !list.isEmpty else { return }
            
            self.sources = list
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = openedCell, let cell = collectionView.cellForItem(at: indexPath) as? SourceCVC {
            cell.hero.id = nil
            cell.titleLabel.hero.id = nil
        }
    }
    
    private func setupLayouts() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 60) / 2, height: 74)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SourceCVC.self, forCellWithReuseIdentifier: "CVC")
        view.addSubview(collectionView)
        
        collectionView.edgesToSuperview()
    }
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as? SourceCVC else { return UICollectionViewCell() }
        let source = sources[indexPath.row]
        
        cell.setup(title: source.name ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let source = sources[indexPath.row]
        
        presenter.everything(sourceId: source.id ?? "") { news_ in
            guard let news = news_, !news.isEmpty else { return }
            guard let cell = collectionView.cellForItem(at: indexPath) as? SourceCVC else { return }
            
            self.openedCell = indexPath
            cell.hero.id = "cell"
            cell.titleLabel.hero.id = "title"
            
            let vc = SourceVC(news, source)
            vc.modalPresentationStyle = .fullScreen
            vc.heroModalAnimationType = .zoom
            vc.hero.isEnabled = true
            self.present(vc, animated: true)
        }
    }
}
