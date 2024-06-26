//
//  ViewController.swift
//  iKid
//
//  Created by 小戈 on 2024/4/25.
//

import UIKit

class ViewController: UIViewController {
    struct Joke {
        let question: String
        let punchline: String
    }

    // Dictionary for jokes
    var jokesDictionary: [String: [Joke]] = [
        "Good": [
            Joke(question: "What do you call a bear with no teeth?", punchline: "A gummy bear!"),
            Joke(question: "What do you call a factory that makes okay products?", punchline: "A satisfactory."),
            Joke(question: "Why did the golfer bring two pairs of pants?", punchline: "In case he got a hole in one!")
        ],
        "Pun": [
            Joke(question: "I would avoid the sushi if I were you.", punchline: "It’s a little fishy."),
            Joke(question: "Why couldn't the bicycle stand up by itself?", punchline: "It was two-tired!"),
            Joke(question: "What do you call a dinosaur that is sleeping?", punchline: "A dino-snore!"),
            Joke(question: "To the guy who invented zero,", punchline: "thanks for nothing!")
        ],
        "Dad": [
            Joke(question: "What kind of bagel can travel?", punchline: "A plain bagel."),
            Joke(question: "What do you call cheese that isn't yours?", punchline: "Nacho cheese!"),
            Joke(question: "Why did the scarecrow win an award?", punchline: "Because he was outstanding in his field!"),
            Joke(question: "Why don't eggs tell jokes?", punchline: "They'd crack each other up.")
        ]
    ]

    var currentJokes: [Joke] = []
    var currentJokeIndex = 0

    let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = false
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()

    let punchlineLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()

    let revealButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reveal", for: .normal)
        return button
    }()

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        return button
    }()

    let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupJokesByCategory()
        setupLayout()
        revealButton.addTarget(self, action: #selector(revealPunchline), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextJoke), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(previousJoke), for: .touchUpInside)
        showJoke()
    }

    private func setupJokesByCategory() {
        // Determine which jokes to show based on the restoration identifier
        if let categoryJokes = jokesDictionary[self.restorationIdentifier ?? ""] {
            currentJokes = categoryJokes
        } else {
            currentJokes = jokesDictionary["GoodJokes"] ?? []
        }
    }

    private func setupLayout() {
        view.addSubview(questionLabel)
        view.addSubview(punchlineLabel)
        view.addSubview(revealButton)
        view.addSubview(backButton)
        view.addSubview(nextButton)

        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        punchlineLabel.translatesAutoresizingMaskIntoConstraints = false
        revealButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            punchlineLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            punchlineLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),

            revealButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            revealButton.topAnchor.constraint(equalTo: punchlineLabel.bottomAnchor, constant: 20),
            
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc func nextJoke() {
        currentJokeIndex = (currentJokeIndex + 1) % currentJokes.count
        showJoke()
    }

    @objc func previousJoke() {
        currentJokeIndex = (currentJokeIndex - 1 + currentJokes.count) % currentJokes.count
        showJoke()
    }

    private func showJoke() {
        let currentJoke = currentJokes[currentJokeIndex]
        questionLabel.text = currentJoke.question
        punchlineLabel.text = currentJoke.punchline
        punchlineLabel.isHidden = true
        revealButton.isEnabled = true
    }

    @objc func revealPunchline() {
        punchlineLabel.isHidden = false
        revealButton.isEnabled = false
    }
}


