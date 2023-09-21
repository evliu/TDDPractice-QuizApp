//
//  QuizTest.swift
//  QuizEngine
//
//  Created by Everest Liu on 9/21/23.
//

import QuizEngine
import XCTest

final class QuizTest: XCTestCase {
	private let delegate = DelegateSpy()
	private var quiz: Quiz!
	
	override func setUp() {
		super.setUp()
		
		quiz = Quiz.start(
			questions: ["Q1", "Q2"],
			delegate: delegate,
			correctAnswers: ["Q1": "A1", "Q2": "A2"]
		)
	}
	
	func test_startQuiz_answerZeroOutOfTwoCorrectly_scores0() {
		delegate.answerCallback("wrong")
		delegate.answerCallback("wrong")
		
		XCTAssertEqual(delegate.handledResult!.score, 0)
	}
	
	func test_startQuiz_answerOneOutOfTwoCorrectly_scores1() {
		delegate.answerCallback("A1")
		delegate.answerCallback("wrong")
		
		XCTAssertEqual(delegate.handledResult!.score, 1)
	}
	
	func test_startQuiz_answerTwoOutOfTwoCorrectly_scores2() {
		delegate.answerCallback("A1")
		delegate.answerCallback("A2")
		
		XCTAssertEqual(delegate.handledResult!.score, 2)
	}
	
	private class DelegateSpy: QuizDelegate {
		var handledResult: Result<String, String>? = nil
		var answerCallback: ((String) -> Void) = { _ in }
		
		func handle(question: String, answerCallback: @escaping (String) -> Void) {
			self.answerCallback = answerCallback
		}
		
		func handle(result: Result<String, String>) {
			handledResult = result
		}
	}
}
