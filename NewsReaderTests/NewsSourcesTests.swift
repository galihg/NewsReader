//
//  NewsReaderTests.swift
//  NewsReaderTests
//
//  Created by Kuncoro Galih Gemilang on 02/06/24.
//

import Nimble
import Quick

@testable import NewsReader

class NewsSourcesTests: QuickSpec {

    private var vc: NewsSourcesViewController!
    private var vm: NewsSourcesViewModel!
    private var service: MockNewsService!
    
    override func spec() {
        
        beforeEach() {
            service = MockNewsService()
        }
        
        afterEach() {
            service = nil
        }
    }
    
    
}
