//
//  FireStoreManager.swift
//  Project2- Quiz Bank
//
//  Created by suhail on 09/10/23.
//
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation
import CoreData

final class DatabaseManager{
    static let shared = DatabaseManager()
    let db = Firestore.firestore()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private init(){}
    
//    func uploadAllQuestions(questions: [Question]?){
//        guard let questions = questions else { return }
//        print(questions.count)
//        for (index,question) in questions.enumerated() {
//            
//            DispatchQueue.global(qos: .userInitiated).async {
//                do {
//                    try self.db.collection("questions").document("quesstion \(index)").setData(from: question)
//                } catch let error {
//                    print("Error writing question to Firestore: \(error)")
//                }
//            }
//        }
//    }
    
    func fetchAllQuestions(completion: @escaping ([QuestionsCD])->()){
        db.collection("questions").getDocuments { (snapshot, error) in
            if  error == nil{
                guard let snapshot = snapshot else{ return }
                
                self.cacheQuestionsToLocalDB(snapshot: snapshot) { cacheSuccess in
                    if cacheSuccess{
                        guard let fetchedFromLocalDB = self.fetchCachedQuestions() else { return }
                        completion(fetchedFromLocalDB)
                    }
                }
            
            }
            
        }
    }
   
    func cacheQuestionsToLocalDB(snapshot: QuerySnapshot,completion: @escaping (Bool)->()){

        for document in snapshot.documents{
            let documentData = document.data()
            let answer = documentData["answer"] as! String
            let text = documentData["text"] as! String
            let newQuestion = QuestionsCD(context: self.context)
            newQuestion.text = text
            newQuestion.answer = answer
            do{
                try self.context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
        completion(true)
    }
    
    func fetchCachedQuestions()->[QuestionsCD]?{
        do{
            let questions = try context.fetch(QuestionsCD.fetchRequest())
           return questions
        }catch{
            print("Could not fetch questions!")
        }
        return nil
    }
}
