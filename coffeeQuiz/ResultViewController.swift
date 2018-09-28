//
//  ResultViewController.swift
//  coffeeQuiz
//
//  Created by 藤井悠太 on 2018/09/18.
//  Copyright © 2018年 yutahand. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var correctPercentLabel: UILabel!                //正解率ラベル
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //問題数を取得する
//        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        //正解数を取得する
        var correctCount: Int = 0
        
        //正解数を計算する
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect() {
                //正解数を増やす
                correctCount += 1
                
            }
        }
        
        //正解率の計算
        let correctPercent: Int = Int(correctCount) * 10
        
        //正解数率を少数第一位まで計算して画面に反映する
        correctPercentLabel.text = String(correctPercent) + "%"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

