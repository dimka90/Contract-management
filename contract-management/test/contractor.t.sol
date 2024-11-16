//SPDX-License-identifier: MIT

pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {Procurement} from "../src/Contractor.sol";
import "forge-std/console.sol";
contract ProcurementTest is Test{

    Procurement procurement;

function setUp() external {

procurement = new Procurement();
 string memory name = "Julis";
    uint reg = 1234567;
    uint tin = 457899;
    string memory addressp = "Jos south";
    string memory docCid = "9000";
    string memory signCid = "99999";

    procurement.createContractor(name,reg, tin, addressp, docCid, signCid);
}

function  testgetName() external view {
    (string memory name, uint reg, , , , , ) = procurement.contractors(0);

    assertEq(name, "Julis", "Names should be same");
    assertEq(reg, 1234567, "reg number should be 1234567");
}
}