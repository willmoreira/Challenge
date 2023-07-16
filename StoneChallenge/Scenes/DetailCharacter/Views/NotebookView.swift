//
//  NotebookView.swift
//  StoneChallenge
//
//  Created by William on 15/07/23.
//

import UIKit

class NotebookView: UIView {
    
    // MARK: - Properties
    
    private let lineSpacing: CGFloat = 32.0
    private var arrayLines: [UIView] = []
    private var emptyIndex = 0
    private let containerView = UIView()

    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        var previousLineView: UIView?
        
        for _ in 0..<5 {
            let lineView = UIView()
            arrayLines.append(lineView)
            lineView.backgroundColor = .lightGray
            lineView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(lineView)
            
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            lineView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
            
            if let previousLineView = previousLineView {
                lineView.topAnchor.constraint(equalTo: previousLineView.bottomAnchor, constant: lineSpacing).isActive = true
            }
            previousLineView = lineView
        }
        if let previousLineView = previousLineView {
            containerView.bottomAnchor.constraint(equalTo: previousLineView.bottomAnchor, constant: lineSpacing).isActive = true
        }
    }
    
    // MARK: - Public Methods
    
    func addText(text: String) {
        guard emptyIndex < arrayLines.count else { return }
        
        let labelText: UILabel = UILabel()
        labelText.text = text
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(labelText)

        let line = arrayLines[emptyIndex]
        
        NSLayoutConstraint.activate([
            labelText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            labelText.bottomAnchor.constraint(equalTo: line.topAnchor, constant: -2)
        ])
        emptyIndex += 1
    }
}

