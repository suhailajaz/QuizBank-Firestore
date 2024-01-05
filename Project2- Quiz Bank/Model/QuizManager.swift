//
//  QuizManager.swift
//  Project2- Quiz Bank
//
//  Created by suhail on 07/09/23.
//

import Foundation

struct QuizManager{
    
    var questionNumber = 0
    var score = 0
    var wrong = 0
    var gameOver = false
    var questions = [QuestionsCD]()
 
   func fetchQuestion()->String{
       return questions[questionNumber].text!

    }
    
    mutating func checkAnswer(selectedAnswer: String)->Bool{
        if questions[questionNumber].answer == selectedAnswer{
            score += 1
           
            return true
        }else{
            wrong += 1
            return false
        }
    }
    
    mutating func nextQuestion(){
        if questionNumber+1 < questions.count{
            questionNumber+=1
        }else{
            gameOver = true
            questionNumber = 0
            score = 0
            wrong = 0
        }
    }
    
    func getCurrentProgress()->Float{
      return  Float(questionNumber)/Float(questions.count)
    }
    
}
