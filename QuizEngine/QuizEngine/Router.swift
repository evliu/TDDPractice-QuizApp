//
//  Router.swift
//  QuizEngine
//
//  Created by Everest Liu on 9/8/23.
//

import Foundation

public protocol Router {
	associatedtype Question: Hashable
	associatedtype Answer

	typealias AnswerCallback = (Answer) -> Void
	func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
	func routeTo(result: Result<Question, Answer>)
}
