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
        fatalError(ConfigurationStrings.fatalErrorMessage)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 5
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        var previousLineView: UIView?
        
        for _ in 0..<5 {
            let lineView = UIView()
            arrayLines.append(lineView)
            lineView.backgroundColor = .lightGray
            lineView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(lineView)
            
            NSLayoutConstraint.activate([
                lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                lineView.heightAnchor.constraint(equalToConstant: 1.0)
            ])
             
            if let previousLineView = previousLineView {
                NSLayoutConstraint.activate([
                    lineView.topAnchor.constraint(equalTo: previousLineView.bottomAnchor, constant: lineSpacing)
                ])
            }
            previousLineView = lineView
        }
        if let previousLineView = previousLineView {
            NSLayoutConstraint.activate([
                containerView.bottomAnchor.constraint(equalTo: previousLineView.bottomAnchor, constant: lineSpacing)
            ])
        }
    }
    
    // MARK: - Public Methods
    
    func addTextInLine(parameterText: String) {
        guard emptyIndex < arrayLines.count else { return }
        
        let labelText: UILabel = UILabel()
        labelText.text = parameterText
        
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
