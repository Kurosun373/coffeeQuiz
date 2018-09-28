//
//  QuestionViewController.swift
//  coffeeQuiz
//
//  Created by 藤井悠太 on 2018/09/18.
//  Copyright © 2018年 yutahand. All rights reserved.
//

import UIKit
import AudioToolbox
//今度はquestionNo用
var _counter = 1

class QuestionViewController: UIViewController {
    
    //前の画面から(nextQuestion関数の返り値)データを受け取る
    var questionData: QuestionData!
    
    //UIを宣言
    @IBOutlet weak var questionNoLabel: UILabel!            //問題番号ラベル
    @IBOutlet weak var questionTextView: UITextView!        //問題文テキストビュー
    @IBOutlet weak var answer1Button: UIButton!             //選択肢1ボタン
    @IBOutlet weak var answer2Button: UIButton!             //選択肢2ボタン
    @IBOutlet weak var answer3Button: UIButton!             //選択肢3ボタン
    @IBOutlet weak var answer4Button: UIButton!             //選択肢4ボタン
    
    @IBOutlet weak var correctImageView: UIImageView!       //正解時イメージビュー
    @IBOutlet weak var incorrectImageView: UIImageView!     //不正解時イメージビュー

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        QuestionDataManager.sharedInstance.loadQuestion()
        //初期データ設定処理, 前画面で設定済みのquestionDataから値を取り出す
//        print("test")
//        print(questionData.questionNo)
//        nilが入ってる
//        これを解決すればOK
        questionNoLabel.text = "Q.\(String(_counter))"
        if _counter < 11 {
            _counter += 1
        }
        questionTextView.text = questionData.question
//        print(questionTextView.text)
        answer1Button.setTitle(questionData.answer1, for: UIControlState.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControlState.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControlState.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControlState.normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //選択肢1をタップ
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1             //選択した答えの番号を保存する
        goNextQuestionWithAnimation()
    }
    
    //選択肢2をタップ
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2             //選択した答えの番号を保存する
        goNextQuestionWithAnimation()
    }
    
    //選択肢3をタップ
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3             //選択した答えの番号を保存する
        goNextQuestionWithAnimation()
    }
    
    //選択肢4をタップ
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4             //選択した答えの番号を保存する
        goNextQuestionWithAnimation()
    }
    
    //次の問題にアニメーション付きですすむ
    func goNextQuestionWithAnimation() {
        //正解しているか判定する
        if questionData.isCorrect(){
            print("true")
            //正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithCorrectAnimation()
        } else {
            print("false")
            //不正解のアニメーションを再生しながら次の問題へ遷移する
            goNextQuestionWithIncorrectAnimation()
        }
    }
    
    //次の問題に正解のアニメーション付きで遷移する
    //アニメーションは2.0秒間処理されるが、鬱陶しかったら短くしてもOK
    func goNextQuestionWithCorrectAnimation() {
        //正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1025)
        
        //アニメーション
        UIView.animate(withDuration: 1.0, animations: {
            //アルファ値を1.0に変化させる(初期値はStoryboardで0.0に設定済み)
            self.correctImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()                //アニメーション完了後に次の問題に進む
        }
    }
    
    //次の問題に不正解のアニメーション付きで遷移する
    func goNextQuestionWithIncorrectAnimation() {
        //不正解を伝える音を鳴らす
        AudioServicesPlayAlertSound(1006)
        
        //アニメーション
        UIView.animate(withDuration: 1.0, animations: {
            //アルファ値を1.0に変化させる(初期値はStoryboardで0.0に設定済み)
            self.incorrectImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()               //アニメーション完了後に次の問題に進む
        }
    }
    
    //次の問題に遷移する
    func goNextQuestion() {
        //問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            //問題文がなければ結果画面へ遷移する
            //StoryboardのIdentifierに設定した値(result)を指定して
            //ViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                //Storyboardのsegueを利用しない明示的な画面遷移処理
                present(resultViewController, animated: true, completion: nil)
            }
            return
        }
        
        //問題文がある場合は次の問題へ遷移する
        //StoryboardのIdentifierに設定した値(question)を設定して
        //ViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            //StoryboardのSegueを利用しない明示的な画面遷移処理
            present(nextQuestionViewController, animated: true, completion: nil)
        }
    }
}

















