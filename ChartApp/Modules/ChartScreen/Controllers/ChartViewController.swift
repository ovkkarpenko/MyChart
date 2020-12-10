//
//  ChartViewController.swift
//  ChartApp
//
//  Created by Oleksandr Karpenko on 10.12.2020.
//

import UIKit

class ChartViewController: UIViewController {
    
    private var charts: [[ChartItem]] = []
    
    private var chartIndex: Int = 0 {
        didSet {
            if chartIndex >= charts.count {
                chartIndex = 0
            }
        }
    }
    
    private lazy var chartView: MyChart = {
        let chart = MyChart()
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charts.append(generateChartItems())
        charts.append(generateChartItems())
        charts.append(generateChartItems())
        charts.append(generateChartItems())
        
        setupUI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.showNextChart()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if touches.first?.view == chartView {
            showNextChart()
        }
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    private let padding: CGFloat = 20
    
    func setupUI() {
        chartView.setItems(charts[chartIndex])
        view.addSubview(chartView)
        
        NSLayoutConstraint.activate([
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            chartView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        view.backgroundColor = .white
        chartView.draw()
    }
    
    func showNextChart() {
        chartIndex+=1
        chartView.setItems(charts[chartIndex])
        chartView.draw()
    }
    
    func generateChartItems(count: Int = Int.random(in: 5...10)) -> [ChartItem] {
        var items: [ChartItem] = []
        for _ in 0..<count {
            items.append(ChartItem(value: Int.random(in: 0...100)))
        }
        return items
    }
    
    @objc private func rotated() {
        chartView.draw()
    }
}
