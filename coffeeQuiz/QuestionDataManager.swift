//
//  QuestionDataManager.swift
//  coffeeQuiz
//
//  Created by 藤井悠太 on 2018/09/18.
//  Copyright © 2018年 yutahand. All rights reserved.
//

import Foundation

//1つの問題に関する情報を格納するデータクラス
class QuestionData {

    //問題文
    var question: String
    
    //選択肢1
    var answer1: String
    //選択肢2
    var answer2: String
    //選択肢3
    var answer3: String
    //選択肢4
    var answer4: String
    
    //正解の番号
    var correctAnswerNumber: Int
    
    //ユーザが選択した選択肢の番号
    var userChoiceAnswerNumber: Int?
    
    //問題文の番号
    var questionNo: Int = 0
    //クラスが生成された時の処理
    //init関数で定義することで明確になる
    //ここまでは読み込まれてる
    init(questionSourceDataArray: [String]){
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
//       print(answer4)
    }
    
    //ユーザが選択した答えが正解かどうか判定する
    //->の後は返り値の型
    func isCorrect() -> Bool{
        //答えが一致しているかどうか判定する
        if correctAnswerNumber == userChoiceAnswerNumber{
            //正解
            return true
        }
        //不正解
            return false
    }
}

//クイズデータ全般の管理と成績を管理するクラス
class QuestionDataManager {
    //シングルトンオブジェクトを生成
    static let sharedInstance = QuestionDataManager()
    
    //問題を格納するための配列
    //[]()の型で宣言すると、同時にインスタンスを生成できるらしい
    var questionDataArray = [QuestionData]()
    
    //現在の問題のインデックス
    var nowQuestionIndex: Int = 0
    
    //初期化処理
    //分け合ってprivate(シングルトンオブジェクトと関係があるらしい)
    private init(){
        //シングルトンであることを保証するためにprivateで宣言しておく
        
    }
    
    //問題文の読み込み処理
    func loadQuestion(){
        //格納ずみの問題文があれば一旦削除しておく
        questionDataArray.removeAll()
        
        //現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        
        //csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            //csvファイルなし
            print("Not Found csv files")
            return
        }
        
        //csv読み込み
        //ここ変えた
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            
            //csvデータを1行ずつ読みこむ
            csvStringData.enumerateLines(invoking:  { (line, stop) -> () in
                //カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ", ")
//                print(questionSourceDataArray)
                //問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                //問題を追加
                self.questionDataArray.append(questionData)
                //問題番号を設定
                questionData.questionNo = self.questionDataArray.count
//                print("hey")
//                print(questionData.questionNo)
                
                })
        } catch let error {
            print("Import Error csv files: \(error)" )
            return
        }
    }
    
    //次の問題を取り出す
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }    
}
