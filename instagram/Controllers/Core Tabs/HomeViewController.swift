//
//  ViewController.swift
//  instagram
//
//  Created by 张杰 on 2020/12/16.
//

import UIKit
import SnapKit
import MBProgressHUD
import MJRefresh

class HomeViewController: UIViewController {
    var scrollView: CustomUIScrollView!
    var headerView: UIView!
    
    private var bar: CustomNavBar?
    
    var searchController = UISearchController(searchResultsController: SearchResultViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "main "
        configScrollView()
        // self.edgesForExtendedLayout = .all
        self.extendedLayoutIncludesOpaqueBars = true
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.searchController = nil
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.setNeedsLayout()
        self.navigationController!.navigationBar.layoutIfNeeded()
    }
    
    func configNav() {
        let bar = CustomNavBar()
        bar.vcDelegate = self
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "hello"
        // self.navigationController?.setValue(bar, forKey: "navigationBar")
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(imageWithColor(color: UIColor(red: 1, green: 1, blue: 1, alpha: 1)), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        searchController.definesPresentationContext = true
        searchController.delegate = self
        navigationItem.searchController = searchController
        // navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
//        searchController.searchBar.frame = CGRect(x: 0,
//                                                  y: 108,
//                                                  width: scrollView.width,
//                                                  height: 40)
    }
    
    
    func configScrollView() {
        self.scrollView = CustomUIScrollView()
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        self.headerView = UIView()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        scrollView.addSubview(headerView)
        
        print("scrollView.top \(scrollView.top)")
        headerView.frame = CGRect(x: 0, y: -128, width: scrollView.width, height: 200 + ZL_naviBarHeight)
        headerView.backgroundColor = .red
        
        scrollView.backgroundColor = .green
        scrollView.contentSize = CGSize(width: view.width, height: view.height * 2)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}


extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let reOffset = scrollView.contentOffset.y //  + ZL_naviBarHeight
        // var alpha = reOffset / ((ZLMainScreenHeight - ZL_naviBarHeight) * 0.2)
        var alpha = reOffset / 60
        print(scrollView.contentOffset.y)
        if alpha > 0 {
            alpha = 1
        } else {
            alpha += 1
        }
        // self.navigationController?.navigationBar.subviews[0].alpha = alpha
        let image = imageWithColor(color: UIColor(red: 0.227, green: 0.753, blue: 0.757, alpha: alpha))
        
        // self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        
        if scrollView.contentOffset.y < 0 {
            
        }
    }
}

extension HomeViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        let height: CGFloat = 44
        let bar = self.navigationController!.navigationBar
        bar.frame = CGRect(x: bar.frame.origin.x, y:  44, width: bar.frame.size.width, height: height)
        bar.setTitleVerticalPositionAdjustment(10, for: UIBarMetrics.default)
        for subview in bar.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 44, width: bar.frame.width, height: height)
                subview.backgroundColor = .white
            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 44, width: subview.frame.width, height: 44)
            }
            
            for subview2 in bar.subviews {
                if NSStringFromClass(subview2.classForCoder).contains("SearchBar") {
                    subview2.frame = CGRect(
                        x: subview.frame.origin.x,
                        y: 44,
                        width: bar.width,
                        height: 50.5
                    )
                    bar.bringSubviewToFront(subview2)
                    break
                }
            }
        }
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        let height = NavigationBarHeightIncrease
        let bar = self.navigationController!.navigationBar
        
        bar.frame = CGRect(x: bar.frame.origin.x, y:  0, width: bar.frame.size.width, height: height)
        
        bar.setTitleVerticalPositionAdjustment(10, for: UIBarMetrics.default)
        
        for subview in bar.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: bar.frame.width, height: height)
                subview.backgroundColor = .white
            }
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 44, width: subview.frame.width, height: 84)
            }
            
            for subview2 in bar.subviews {
                if NSStringFromClass(subview2.classForCoder).contains("SearchBar") {
                    subview2.frame = CGRect(
                        x: subview.frame.origin.x,
                        y: 84,
                        width: bar.width,
                        height: 50.5
                    )
                    bar.bringSubviewToFront(subview2)
                    break
                }
            }
        }
    }
    
}


