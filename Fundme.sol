// أن نتيح للمستخدمين أن يودعوا في العقد
// أن نتيح لصاحب العقد أنه يسحب الإيداعات 
// فهو أن نضع حد أدنى للإيداعات 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {GetConversion} from "./GetConversion.sol" ; 


// 751,968
// 632,008 

// constant 
// immutable 
// custom errors 

error notOwner() ; 

contract FundMe {

    using GetConversion for uint256 ; 


    // 347 * 11 = 3817 = $0.008
    // 2446 * 11 = 26906 = $0.06
    uint256 public constant  MIN_VALUE_USD = 5000000000000000000 ; 
    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded ; 

    //439 
    //2574

    address public immutable i_owner ; 

    constructor (){
        i_owner = msg.sender; 
    }

    

    function fundMe() public payable  {
        // eth السماح للمستخدم بإرسال
        // eth وضع حد أدنى للـ
        require(msg.value.ethConversionRate() >= MIN_VALUE_USD , "Not Enough ETH");
        // revert  ما هو 
        // التراجع ، في جوهره ، يبطل الإجراءات السابقة ، ويعيد الغاز المتبقي المرتبط بتلك الصفقة
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value; 

    }

     

    function withdraw() public onlyOwner {
        //for loop
        // حلقة 
        // [1,2,3] => [0,0,0]
        // [0,1,2] فهرس المصفوفة 


        for(uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex ];
            addressToAmountFunded[funder] = 0 ;
        }

        funders = new address[](0);

        //transfer
        //msg.sender   address 
        //msg.sender payable
    //    payable (msg.sender).transfer(address(this).balance);

    //     //send
    //     bool success = payable (msg.sender).send(address(this).balance);
    //     require(success, "Send Failed");

        //call
        (bool successCall,) = payable (msg.sender).call{value:address(this).balance}("");
        require(successCall, "Call Failed");
    }

    modifier onlyOwner {
    //   require(msg.sender == i_owner , "you are not the owner");
    if(msg.sender != i_owner) revert notOwner() ; 
      _;
    }

     //  هل هناك طريقة لحفظ حقوق الممولين اللي بيقوموا بإرسال الإيثر مباشرة بإستخدام عنوان العقد ؟ 
     // recive() fallback()

     receive() external payable {
        fundMe();
     }

     fallback() external payable { 
        fundMe(); 
     }

    
}

// 1. Enum
// 2. Events
// 3. Try / Catch
// 4. Function Selector
// 5. abi.encode / decode
// 6. Hash with keccak256
// 7. Yul / Assembly



