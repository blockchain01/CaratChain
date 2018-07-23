
## 20180715 
 > 編寫 caratchain ERC-20token

## 20180716
 > ERC-20token骨幹完成,測試BUG

## 20180717
 > ERC-721token上架到imtoken測試
 
 > - 1 未能成功，imtoken1.0版本沒有此功能
 > - 2 imtoken2.0版本：可能由於地區限制，未能成功連線到imtoken網站提交資料。
 
## 20180718
 > 測試功能完成
 
 > 測試鏈地址
 
 0x53154d8b68d52e9fa000548dcd08071082e4e8ee
 
 - 1 . totalSupply      總發行量
 
 - 2 . symbol           圖示
 
 - 3 . name             名稱
 
 - 4 . allowance        查看受權額度
 
 - 5 . decimals         小數位
 
 - 6 . balanceOf        戶口
 
 - 7 . burn             銷毀自己的代幣
 
 - 8 . tranferFrom      受權額度轉帳
 
 - 9 . approve          受權額度給其他人
 
 - 10 . approveAndCall  受權其他dapp使用
 
 - 11 . transfer         轉帳
 
 - 12 . err burn         防止自己不持有時銷毀

 - 13 . err burn         防止銷毀超過自己的持有量
 
## 20180722
 > ERC-20token已經完成並已經交貨
 
 ------

## 20180723

 > 測試鏈地址
 
0xcc852f746d50f4d123489a336b30231f6e49a492

(0x123)

36.630 


 > 測試CC-Token721.sol功能


 - 1 . PurchaseRecord 我的購買記錄 K

 - 2 . owner    合約持有人 K

 - 3 . name             名稱 K
 
 - 4 . MyList   購買/持有次數 K
 
 - 5 . symbol           圖示 K
 
 - 6 . Price            購買費用 K

 - 7 . balanceOf        戶口 K

 - 8 . PublicTokenId  最新TokenId K
 
 - 8. 1 . CCindex          獨立網址 K

 - 8. 2 . BuyPrice         購買費用  K
 
 - 9 . PublicTokenList  查看公眾TokenId數據 K

 - 11 . totalSupply      總發行量 K
 
 - 12 . decimals         小數位 K


*------*


 
 - 15 . ChangeOwner      修改-合約持有人 K
 
 - 16 . ChangeOwner      非Admin-修改-合約持有人 K
 
 - 17 . ChangePrice      修改-購買721價格 K

 - 18 . ChangePrice      非Admin-修改-購買721價格 K
 
 - 19 . making721        購買721代幣 K
 
 - 20 . burn             限Admin-銷毀自己的代幣 K
 
 - 21 . err burn         限Admin-防止自己不持有時銷毀 K

 - 22 . err burn         限Admin-防止銷毀超過自己的持有量 K
  
 - 24 . transfer         轉帳 K 但只能用智能合約平台-如:MyEtherWallet.com
 
 - 24 . transfer         合約持有人收款 K
 




 - 23 . approveAndCall  受權其他dapp使用 
 
 
