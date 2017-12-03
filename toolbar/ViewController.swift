//
//  ViewController.swift
//  toolbar
//
//  Created by ヨト　ジャンフランソワ on 03/12/2017.
//  Copyright © 2017 tcmobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let toolbarHeight: CGFloat = 50
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    lazy var toolbar = UIView()
    
    var data = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func setupViews() {
        toolbar.backgroundColor = .red
        view.addSubview(toolbar)
        
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: Any] = ["toolbar": toolbar, "collection": collectionView]
        let formatV = "V:|[toolbar][collection]|"
        var csts = [NSLayoutConstraint]()
        
        csts += NSLayoutConstraint.constraints(withVisualFormat: formatV, options: [], metrics: nil, views: views)
        
        csts += [NSLayoutConstraint(item: toolbar, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)]
        csts += [NSLayoutConstraint(item: toolbar, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0)]
        csts += [NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0)]
        csts += [NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0)]
        
        let toolbarHeightConstraint = NSLayoutConstraint(item: toolbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: toolbarHeight)
        csts += [toolbarHeightConstraint]
        
        NSLayoutConstraint.activate(csts)
        
        animator = BNShowHideAnimator(parentView: self.view, heightConstraint: toolbarHeightConstraint)
    }
    
    private func setupContents() {
        for i in 1..<100 {
            data.append(i)
        }
        collectionView.reloadData()
    }
    
    var animator: BNShowHideAnimator?
}

extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        animator?.showHide(scrollView: scrollView)
    }
    
}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let value = data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCell
        cell.title = "\(value)"
        cell.backgroundColor = .green
        return cell
    }
    
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - collectionView.contentInset.left - collectionView.contentInset.right
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

