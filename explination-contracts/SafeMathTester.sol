// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SafeMathTester {
    uint8 public  bigNamuber = 255; //checked   unchecked 

    function add() public  {
       unchecked{ bigNamuber = bigNamuber + 1 ;}
    }
}

