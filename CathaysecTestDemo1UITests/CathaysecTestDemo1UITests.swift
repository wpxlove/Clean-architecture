//
//  CathaysecTestDemo1UITests.swift
//  CathaysecTestDemo1
//
//  整合版本 - 已加入防 not hittable 強制點擊機制
//

import XCTest

final class CathaysecTestDemo1UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // ⚠️ [修改標記] 預設的 testExample 為空範例，目前已將其註解掉。
    // 請您確認此範例不再需要後，再由您手動刪除此區塊，避免程式碼冗餘。
    /*
    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    */

    // ⚠️ [修改標記] 將您的自訂測試整合至此，並加入 @MainActor 支援 iOS 15+ 主執行緒規範。
    @MainActor
    func testTapStockLotteryNavigatesToDetail() {
        // 1. 啟動你的 App (這時機器人會幫你打開模擬器)
        let app = XCUIApplication()
        app.launch()

        // 2. 尋找名為「股票抽籤」的文字標籤，並確認它存在
        let stockLotteryCell = app.staticTexts["股票抽籤"]
        XCTAssertTrue(stockLotteryCell.exists, "首頁應該要顯示股票抽籤的選項")
        
        // 3. 機器人伸出手指，點擊它！
        // ⚠️ [修改標記] 原本會報錯的寫法，已註解掉，請您確認後手動刪除
        // stockLotteryCell.tap()
        
        // ⚠️ [修改標記] 新增防呆點擊機制：解決 StaticText not hittable 問題
        if stockLotteryCell.isHittable {
            stockLotteryCell.tap()
        } else {
            // 強制點選該元件的正中心點 (X: 50% , Y: 50%)，無視圖層遮擋
            stockLotteryCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
        }

        // 4. 驗證是否成功跳轉到下一頁
        // 檢查 Navigation Bar 的標題是不是變成了「服務詳情」
        let detailNavBar = app.navigationBars["服務詳情"]
        XCTAssertTrue(detailNavBar.waitForExistence(timeout: 2.0), "點擊後應該要跳轉到服務詳情頁面")
        
        // 5. 檢查詳細頁面裡面，那個國泰綠色的按鈕有沒有長出來
        let startButton = app.buttons["開始使用"]
        XCTAssertTrue(startButton.exists, "詳細頁面應該要包含『開始使用』按鈕")
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
