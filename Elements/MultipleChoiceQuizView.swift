// MultipleChoiceQuizView.swift
import SwiftUI

struct MultipleChoiceQuizView: View {
    @ObservedObject var elementData = ElementData()
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
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
                Text("Vilken är symbolen för \(currentQuestion.namn(påSpråk: valdSpråk))?")
                    .font(.title2)
                    .padding()

                VStack {
                    ForEach(generateAnswers(for: currentQuestion), id: \.self) { answer in
                        Button(action: {
                            selectedAnswer = answer
                            showCorrectAnswer = true // Show result immediately
                            if answer == currentQuestion.symbol {
                                correctAnswers += 1
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Delay
                                showCorrectAnswer = false
                                selectedAnswer = nil
                                nextQuestion()
                            }
                        }) {
                            Text(answer)
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(buttonColor(for: answer))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(showCorrectAnswer) // Disable buttons after selection

                    }
                }
                .padding()

            } else {
                Text("Du fick \(correctAnswers) av \(elementData.grundämnen.count) rätt!")
                    .font(.title)
                    .padding()
                Button("Starta om"){
                    correctAnswers = 0
                    quizFinished = false
                    currentQuestionIndex = 0
                    elementData.loadData()
                }
            }
            Spacer() // Push content to top
        }
        .navigationTitle("Flervalsquiz")
        .onAppear {
            elementData.loadData() // Ensure data is loaded
            //Shuffle questions.
            elementData.grundämnen.shuffle()
        }

    }

    func generateAnswers(for element: Grundämne) -> [String] {
        var answers = [element.symbol]
        while answers.count < 4 {
            let randomSymbol = elementData.grundämnen.randomElement()!.symbol
            if !answers.contains(randomSymbol) {
                answers.append(randomSymbol)
            }
        }
        answers.shuffle() // Randomize the order of answers
        return answers
    }

    func nextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex >= elementData.grundämnen.count {
            quizFinished = true // End the quiz
        }
    }


    func buttonColor(for answer: String) -> Color {
        if showCorrectAnswer {
            if answer == elementData.grundämnen[currentQuestionIndex].symbol {
                return .green // Correct answer
            } else if selectedAnswer == answer {
                return .red // Incorrectly selected answer
            }
        }
        return .blue // Default button color
    }
}


#Preview {
    MultipleChoiceQuizView()
}
