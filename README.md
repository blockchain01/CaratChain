
![CaratChain](https://github.com/blockchain01/CaratChain/blob/master/img/mmexport1531602574304.jpg?raw=true "CaratChain")

# 中國最大的區塊鏈鑽石交易平台

## 簡介：

 > 通過區塊鏈溯源技術及防偽技術，打造全中國最大的區塊鏈鑽石交易C2C平台。


## 目前鑽石交易行業面臨的問題：

 > 現時鑽石交易是純B2C交易，鑽石交易沒有第三方機構直接監管、鑑定求真。
 亦無法更大程度塑造鑽石價值，及開展`鑽石借貸`、`託管`、`維修`和`鑽石抵兌`等服務。

## 解決方案：

 > - 1. `Carat Chain`用區塊鏈技術保證鑽石的認證鑑定足夠真實，不易被篡改。
 
 > - 2. 鑽石的提取、製作以及成品的全過程，圴會記錄於區塊鏈的每個節點當中。
 
 > - 3. 通過區塊鏈技術放大產品價值，開展鑽石的全方位服務體系。
 
 > - 4. 引入第三方監管機構確保商家產品的真實性、同時引入徵信數據確保用戶有足夠購買能力！

 ## 技術應用：
 
 > Carat Chain會使用以太坊區塊鏈技術達成以上方案。
 
 ## 1. Carat Chain將會發行一種全新的`雙軌`代幣`CRT`：
 
 > - CRT共有兩版本，分別為：CRT-erc-20 及 CRT-erc-721。
 
 ## 2. 新一代的區塊鏈鑽石證書：
 
 > - CRT-erc-20，將會用於上架在各大舊式虛擬代幣交易所，方便用戶購買及交易Carat Chain的虛擬代幣CRT。

 > - CRT-erc-721，利用`erc-721虛擬代幣協議`的非同質性，將每個鑽石的提取、製作以及成品的所有數據，記錄於CRT-erc-721當中。
 
 > - 每一個CRT-erc-721都是可以交易的，但每一個CRT-erc-721的內容都不相同，我們可以將其理解為`新一代的區塊鏈鑽石證書`。
 
 > - 相比舊時代的鑽石證書，CRT-erc-721將會大大降低偽造、遺失、損毀等風險。加上CRT-erc-721可以隨時交易，保存性及流通性將會大大提升。
 
 > - Carat Chain會優先發行CRT-erc-20，再加上銷毀及兌換功能，用戶可各自交易CRT-erc-20及CRT-erc-721。
 
 > - 由於虛擬代幣協議不同，CRT-erc-20跟CRT-erc-721兩者是不能互換的。

 ## 3. 新一代的鑽石交易平台，CaratChain智能合約：
 
 > - 每當商家製作鑽石產品，他可以將整個過程的每一步記錄到CaratChain智能合約當中，由於區塊鏈技術的平等性及公開性，任何人都可以跟蹤製作鑽石產品的每一步。
 
 > - CaratChain智能合約會將每一個鑽石產品加上編號，方便跟蹤。而CaratChain亦會跟各第三方監管機構合作，平台將會使用最簡單介面，直接連結到三方監管機構。用戶將可以一站式購買、驗證、交易他們的鑽石產品。
 
 > - CaratChain智能合約沒有地區限制，商家可透過CaratChain跟世界各地的客戶交易，CaratChain智能合約亦可以成為用戶的鑽石交易平台，他們將可使用CaratChain跟親友交易自己的鑽石產品。
 
 ------
 
 ## 虛擬代幣CRT發行資料：
 
 > - 1. 代幣名稱  Carat Chain
 
 > - 2. 總上限量  120000000 1.2億
 
 > - 3. 標記符號  CRT
 
 > - 4. 小數位     0
 
 
 ------
 
 ## 技術代碼：
 
 
 ### CaratChainERC-20Token.sol
 
 ```
 
 //版本聲明
pragma solidity ^0.4.24;

//外部使用受權
interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

//合約開始
contract caratchainTokenERC20 {
    
////////////////////////////////////////////////////////////////////////基本資料

//名,符號,小數,總量
    string public name;
    string public symbol;
    uint8 public decimals = 0;
    uint256 public totalSupply;

////////////////////////////////////////////////////////////////////////個人資料

//戶口
    mapping (address => uint256) public balanceOf;
  
//受權額度  
    mapping (address => mapping (address => uint256)) public allowance;


///////////////////////////////////////////////////////////////////////// event

//轉帳時通知區塊
    event Transfer(address indexed from, address indexed to, uint256 value);
    
//受權時通知區塊
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

//燒毀時通知區塊
    event Burn(address indexed from, uint256 value);



////////////////////////////////////////////////////////////////////////合約功能

//合約初始化
    function caratchainTokenERC20(
        uint256 initialSupply,//輸入初始發行量
        string tokenName,     //輸入代幣名
        string tokenSymbol    //輸入符號
        
    ) public {
        //總量=初始發行量*十進製*小數位
        totalSupply = initialSupply * 10 ** uint256(decimals); 
        //初始發代幣全數給發行者
        balanceOf[msg.sender] = totalSupply;     
        //代幣名=輸入代幣名
        name = tokenName;       
        //代幣符號=輸入符號
        symbol = tokenSymbol;                 
    }




//受權額度給其他人
    function approve(
        address _spender, //被受權者戶口
        uint256 _value    //受權額
    ) public
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;  //記錄受權額
        emit Approval(msg.sender, _spender, _value);  //受權時通知區塊
        return true;   //成功通知
    }


//在其他DAPP顯示
    function approveAndCall(
        address _spender,  //被受權者戶口
        uint256 _value,    //受權額
        bytes _extraData   //受權者留言
    ) public
        returns (bool success) {
//被受權者戶口可在其他DAPP使用
        tokenRecipient spender = tokenRecipient(_spender);
//如果有被受權
        if (approve(_spender, _value)) {
//將資料記錄在被受權者戶口(受權者'我',受權額,本合約地址,受權者留言)
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true; //成功通知
        }
    }





//轉帳
    function transfer(
        address _to,      //收帳人
        uint256 _value    //轉帳額
    ) public returns (bool success) {
//轉帳時的數據進入內部功能
        _transfer(msg.sender, _to, _value);
        return true;      //成功通知
    }


//受權額度轉帳
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
//轉帳額少於受權額度
        require(_value <= allowance[_from][msg.sender]);
//受權轉帳額度減轉帳額
        allowance[_from][msg.sender] -= _value;
//轉帳時的數據進入內部功能
        _transfer(_from, _to, _value);
        return true;     //成功通知
    }




//轉帳時的內部功能
    function _transfer(address _from, address _to, uint _value) internal {
//防止轉到地址0
    require(_to != address(0x0));
//轉帳額少於戶口現有額
        require(balanceOf[_from] >= _value);
//收帳後必須大於收帳前
        require(balanceOf[_to] + _value >= balanceOf[_to]);
// 發送者戶口+收帳戶口額量,用於比較結果
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
// 發送者戶減少發送量
        balanceOf[_from] -= _value;
// 收帳戶戶堵增加發送量
        balanceOf[_to] += _value;
// 轉帳時通知區塊    
        emit Transfer(_from, _to, _value);
//轉帳完成比較previousBalances,如不同則消耗GAS但取消所有轉帳動作
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }



//銷毀TOKEN
    function burn(uint256 _value) public returns (bool success) {
//銷毀量少於戶口現有額
        require(balanceOf[msg.sender] >= _value); 
//在我的戶口中銷毀
        balanceOf[msg.sender] -= _value;  
//在總量中減少
        totalSupply -= _value; 
//燒毀時通知區塊
        emit Burn(msg.sender, _value);
        return true;  //成功通知
    }
}

```

 ------
 
 
  ### CaratChain-Rules.sol
  
  ```
  
  //版本聲明
pragma solidity ^0.4.24;



/////////////////////////////////////////////////////////////////設定合約持有人
contract SetOwner{ 
//合約持有人地址
    address public owner;
//購買721價格 以SZABO計算,1000000SZABO=1Ether  
    uint public Price = 3000 szabo; 


  
    function SetOwner() { 
//初始發設定合約持有人  
        owner = msg.sender;
        
        
    }
}


/////////////////////////////////////////////////////////////////////////規則
contract BasicRules is SetOwner{

//驗證持有人,不是持有人則消耗GAS但取消所有動作
 modifier JustOwner() {assert(msg.sender == owner);  _;}
    
//新Owner不能是0,是0則取消所有動作
 modifier AddRrule(address _T) {require(address(0x0) != _T);  _;}
 
//新匯率必須大於0||少於0則取消所有動作
 modifier PriceRrule(uint _E) {require(0 < _E);  _;}
}



/////////////////////////////////////////////////////////////持有人修改合約資料
contract Admin is BasicRules {


//修改-購買721價格 以SZABO計算,1000000SZABO=1Ether     
function ChangePrice(uint InputPrice) 
//驗證持有人//價格必須大於0
JustOwner PriceRrule(InputPrice) public
returns (bool success){
//價格=新價格 以SZABO計算,1000000SZABO=1Ether    
Price = (InputPrice * 1 szabo);
return true; //成功通知
}
    





//修改-合約持有人 
function ChangeOwner(address NewOwner) 
//新Owner不能是0
JustOwner AddRrule(NewOwner) public
returns (bool success){
//Owner=新Owner
owner = NewOwner;
return true; //成功通知
}



    
}

  ```
 
 ------
 
   ### CaratChainERC-721Token.sol
  
  ```

pragma solidity ^0.4.24;



import "./CaratChain-Rules.sol";  


//外部使用受權
interface tokenRecipient { function receiveApproval(address _from, uint256 _Id, address _token, bytes _extraData) external; }




//本合約
contract caratchainTokenERC721 is Admin {



///////////////////////////////////////////////////////////////////////// event

//轉帳時通知區塊
    event Transfer(address indexed from, address indexed to, uint256 id);
    
//受權時通知區塊
    event Approval(address indexed _owner, address indexed _spender, uint256 id);

//燒毀時通知區塊
    event Burn(address indexed from, uint256 id);
    
////////////////////////////////////////////////////////////////////////基本資料

//名,符號,小數,總量
    string public name = "Carat Chain721";
    string public symbol = "CRT721";
    uint8 public decimals = 0;
    uint256 public totalSupply;


//公眾查詢用TokenId
      uint256 public PublicTokenId;
mapping(uint => string)    TokenIdindex;      /* 獨立網址 */
mapping(uint => uint)   TokenIdBuyPrice;      /* 購買費用 */
mapping(uint => address)       Holdings;      /* 持有者 */


//驗證代幣持有者,不是代幣持有者則取消所有動作
 modifier JustHoldings(uint _Id,address _A) {require(msg.sender == Holdings[_Id]);  _;}
 
 
////////////////////////////////////////////////////////////////////////個人資料

//戶口
    mapping (address => uint256) public balanceOf;


//受權額度  
    mapping (address => mapping (address => uint256)) public allowance;



//我的購買記錄
  mapping(address => TokenData) MyList;
  
  
  
//購買記錄的內容
   TokenData MyTokenData; 
  struct  TokenData{  
        uint            MyToken;      /* 購買/持有次數 */
mapping(uint => uint)   TokenId;       /* 此編號代表的721代幣 */
    }



 

//////////////////////////////////////////////////////////////////在其他DAPP顯示

//受權額度給其他人
    function approve(
        address _spender, //被受權者戶口
        uint256 _Id    //受權額
    ) JustHoldings(_Id,msg.sender) public
        returns (bool success) {
        allowance[msg.sender][_spender] = 1;  //記錄受權額
        emit Approval(msg.sender, _spender, _Id);  //受權時通知區塊
        return true;   //成功通知
    }


//在其他DAPP顯示
    function approveAndCall(
        address _spender,  //被受權者戶口
        uint256 _Id,    //受權額
        bytes _extraData   //受權者留言
    ) JustHoldings(_Id,msg.sender) public
        returns (bool success) {
//被受權者戶口可在其他DAPP使用
        tokenRecipient spender = tokenRecipient(_spender);
//如果有被受權
        if (approve(_spender, _Id)) {
//將資料記錄在被受權者戶口(受權者'我',_Id,本合約地址,受權者留言)
            spender.receiveApproval(msg.sender, _Id, this, _extraData);
            return true; //成功通知
        }
    }


////////////////////////////////////////////////////////////////////////合約功能




//購買721代幣
  function making721(string index) external payable{
    //入帳給owner  
    owner.transfer(msg.value);
    //驗證價格  
    require(msg.value > Price || msg.value == Price);  
    //進入內部功能-新增代幣
    NewToken(msg.sender,index,msg.value);
  }




 
//轉帳
    function transfer(
        address _to,      //收帳人
        uint256 _Id    //轉帳額
    ) JustHoldings(_Id,msg.sender) AddRrule(_to) public returns (bool success) {
//轉帳時的數據進入內部功能
        _transfer(msg.sender, _to, _Id);
        return true;      //成功通知
    }
    









//受權額度轉帳
//    function transferFrom(address _from, address _to, uint256 _Id) JustHoldings(_Id,msg.sender)
//    public returns (bool success) {
//轉帳額少於受權額度
//        require(1 <= allowance[_from][msg.sender]);
//受權轉帳額度減轉帳額
//        allowance[_from][msg.sender] -= 1;
//轉帳時的數據進入內部功能
//        _transfer(_from, _to, _Id);
//        return true;     //成功通知
//    }


//銷毀TOKEN
    function burn(uint256 _Id) JustOwner JustHoldings(_Id,msg.sender) 
    public returns (bool success) {
//銷毀量少於戶口現有額
        require(balanceOf[msg.sender] >= 1); 
//在我的戶口中銷毀
        balanceOf[msg.sender] -= 1;  
//在總量中減少
        totalSupply -= 1; 
//燒毀時通知區塊
        emit Burn(msg.sender, _Id);
        return true;  //成功通知
    }
    





 
////////////////////////////////////////////////////////////////////////內部功能

//購買721代幣內部功能
  function NewToken(address _A,string _I,uint _V) private{
    //總量+1
    totalSupply++;
    //戶口+1
    balanceOf[_A]++;
    /* 我的購買記錄+1 */
    MyList[_A].MyToken++;
    //721代幣編號+1
    PublicTokenId++;
    /* 我的購買記錄=721代幣編號=現在的總量 */
    MyList[_A].TokenId[MyList[_A].MyToken] = totalSupply;
    //獨立網址
    TokenIdindex[PublicTokenId] = _I;
    //購買費用
    TokenIdBuyPrice[PublicTokenId] = _V;
    //持有者
    Holdings[PublicTokenId] = _A;
  }
 


//轉帳時的內部功能
    function _transfer(address _from, address _to, uint _Id) internal {
//轉帳額少於戶口現有額
        require(balanceOf[_from] >= 1);
//收帳後必須大於收帳前
        require(balanceOf[_to] + 1 >= balanceOf[_to]);
// 發送者戶口+收帳戶口額量,用於比較結果
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
// 發送者戶減少發送量
        balanceOf[_from] -= 1;
// 收帳戶戶堵增加發送量
        balanceOf[_to] += 1;
//轉換代幣持有者
        Holdings[_Id] = _to;
/* _to的購買記錄+1 */
        MyList[_to].MyToken++;    
/* 我的購買記錄=721代幣編號=現在的總量 */
        MyList[_to].TokenId[MyList[_to].MyToken] = _Id;    
    
// 轉帳時通知區塊    
        emit Transfer(_from, _to, _Id);
//轉帳完成比較previousBalances,如不同則消耗GAS但取消所有轉帳動作
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }
    





////////////////////////////////////////////////////////////////////////call功能

   //查看公眾TokenId
  function TokenDetails
  //我的帳戶,721代幣的Id
  (uint InputTokenId) 
  public view returns
  (uint256 TotalSupply,uint NowTokenId,string NowTokenIndex,uint ThisTokenBuyPrice,address ThisTokenHoldings){
      return(
            totalSupply,
            InputTokenId,
            TokenIdindex[InputTokenId],
            TokenIdBuyPrice[InputTokenId],
            Holdings[InputTokenId] 
            );
  }

 


  //查看我的購買記錄
  function MyBuyRecord
  //我的帳戶,購買編號
  (address MyAddress,uint MyTokenNumber) 
  public view returns
  //我的帳戶,購買編號,721代幣的Id
  (uint256 MybalanceOf,uint NowTokenNumber,uint ThisTokenId){
  //如不輸入購買編號,則顯示最新記錄
      if (MyTokenNumber == 0){
        return(
            balanceOf[MyAddress],
            MyList[MyAddress].MyToken,
            MyList[MyAddress].TokenId[MyList[MyAddress].MyToken]
            );
      }
      return(
            balanceOf[MyAddress],
            MyTokenNumber,
            MyList[MyAddress].TokenId[MyTokenNumber]
            );
  }



}

  ```
  
  
  
