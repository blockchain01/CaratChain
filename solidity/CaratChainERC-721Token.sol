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
        emit Approval(msg.sender, _Id, _spender);  //受權時通知區塊
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
        assert(balanceOf[_from] + balanceOf[_to] == prevusBalances);
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


