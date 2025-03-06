//
//  WritingQuizView.swift
//  Elements
//
//  Created by Staffan Liden on 2025-03-05.
//


// WritingQuizView.swift
import SwiftUI

struct WritingQuizView: View {
    @ObservedObject var elementData = ElementData()
    @State private var currentQuestionIndex = 0
    @State private var userAnswer: String = ""
    @State private var correctAnswers = 0
    @State private var quizFinished = false
    @State private var showCorrectAnswer = false
    @State private var valdSpråk = "sv"

    var body: some View {
        VStack {
            if elementData.isLoading {
                ProgressView()
            } else if let error = elementData.error {
                Text("Error: \(error.localizedDescription)")
            } else if !elementData.grundämnen.isEmpty && !quizFinished {
                
                Picker("Språk", selection: $valdSpråk) {
                    Text("Svenska").tag("sv")
                    Text("Engelska").tag("en")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)

                
                let currentQuestion = elementData.grundämnen[currentQuestionIndex]
                Text("Vad heter grundämnet med symbolen \(currentQuestion.symbol)?")
                    .font(.title2)
                    .padding()

                TextField("Skriv ditt svar...", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .disabled(showCorrectAnswer) // Disable input after submitting

                Button("Kontrollera") {
                    showCorrectAnswer = true
                    if userAnswer.lowercased() == currentQuestion.namn(påSpråk: valdSpråk).lowercased() {
                        correctAnswers += 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        showCorrectAnswer = false
                        userAnswer = ""
                        nextQuestion()
                    }
                }
                .padding()
                .background(showCorrectAnswer ? (userAnswer.lowercased() == elementData.grundämnen[currentQuestionIndex].namn(påSpråk: valdSpråk).lowercased() ? .green : .red) : .blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(showCorrectAnswer)

                 if showCorrectAnswer {
                     Text("Rätt svar: \(currentQuestion.namn(påSpråk: valdSpråk))")
                         .foregroundColor(userAnswer.lowercased() == currentQuestion.namn(påSpråk: valdSpråk).lowercased() ? .green : .red)
                         .padding()
                 }


            } else {
                Text("Du fick \(correctAnswers) av \(elementData.grundämnen.count) rätt!")
                    .font(.title)
                    .padding()

                Button("Starta om") {
                    correctAnswers = 0
                    quizFinished = false
                    currentQuestionIndex = 0
                    elementData.loadData() // Reload data to reshuffle
                }
            }
            Spacer()
        }
        .navigationTitle("Skrivquiz")
        .onAppear {
            elementData.loadData()
            elementData.grundämnen.shuffle()
        }
    }
    func nextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex >= elementData.grundämnen.count {
            quizFinished = true
        }
    }
}

#Preview {
    WritingQuizView()
}