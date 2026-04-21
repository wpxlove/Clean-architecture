# Clean-architecture
ViewController 只管「畫圖」： 遇到沒圖示 (square.and.arrow.up 拼錯)、要不要換紅色背景，都在這裡改。

ViewModel 只管「狀態」： 負責把資料準備好給畫面，如果以後要加一個「是否正在載入中 (Loading)」的圈圈，就是在這邊加一個 @Published var isLoading: Bool。

UseCase 只管「規則」： 負責定義「拿取服務列表」這個行為。

Data 只管「拿資料」： 這是最厲害的地方！現在你是寫死 mockData，未來等你後端 API 寫好，你只需要換掉 Data 層的實作，改成去打真實的 API，前面的 View、ViewModel 完全不用改一行程式碼！這就是 Clean Architecture 最大的威力。
