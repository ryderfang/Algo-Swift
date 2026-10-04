//
//  Runner.swift
//  Tangram
//
//  Created by Ryder Fang on 2026/10/3.
//

@main
enum Runner {
    static func main() {
        // @gen_tests:problem_id
        let problemID = 1614

        if problemID > 0 {
            ProblemRunner.run(problemID)
        }
    }
}
