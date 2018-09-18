//
//  StartViewController.swift
//  coffeeQuiz
//
//  Created by 藤井悠太 on 2018/09/18.
//  Copyright © 2018年 yutahand. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //次の画面に戦記する前に呼び出される準備処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        //問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        
        //遷移先画面の呼び出し
        //nextViewControllerとしてQuestionViewControllerを指定してる
        guard let nextViewController = segue.destination as? QuestionViewController else {
            //取得できずに終了
            return
        }
        
        //問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else{
            //取得できずに終了
            return
        }
        
        //問題文のセット
        nextViewController.questionData = questionData
    }
    
    //タイトルに戻ってくる時に呼び出される処理
    @IBAction func goToTile(_ segue: UIStoryboardSegue){
        
    }
}
