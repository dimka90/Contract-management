//SPDX-License-identifier: MIT

pragma solidity ^0.8.26;

contract Procurement{
 // Define roles: Contractors, Whistleblowers, and Government Agency
enum UserRole { None, Contractor, Whistleblower, Agency }
enum ProjectStatus { NotStarted, InProgress, Completed, Canceled }

event CreateContractor(string,address,uint);
event CreateProject(string projectDescription,uint projectId,address contractorName,address agencyAddress);

struct Contractor{

    string companyName;
    uint registrationNumber;
    uint taxIdenticationNumber;
    string physicalAddress;
    address owner;
    string addressImageCid;
    string companyUploadedCid;
}

struct CompletedProjects{
    uint projectId;
    string projectDescription;
    string projectImagecid;
    bool status;

}

struct Milestone{
    uint milstoneId;
    string description;
    bool completed;
    uint paymentAmount;
}

struct Project {
    uint256 projectId;
    string description;
    uint256 budget;
    uint256 currentBalance;
    address contractorAddress;
    bool completed;
}
uint256 projectId = 1;

// Data structures for data storage
mapping(uint256 => Project) public projects; 
mapping(address => uint256[]) public contractorProjects;
mapping(uint256 projectId=> Milestone[]) public projectMilestones;
Contractor[] public contractors;

function createProject(
    string memory _description,
    uint256 _budget,
    uint256 _currentBalance,
    address _contractorAddress,
    Milestone[] calldata _milestones
) external {
require(_milestones.length > 0, "Milestone is require");
projects[projectId] = Project({
projectId: projectId,
description: _description,
budget: _budget,
currentBalance:_currentBalance,
contractorAddress: _contractorAddress,
completed: false
});
// succesfully created a project
contractorProjects[_contractorAddress].push(projectId);
// Emit event when a project is created for a contractor

// creating milestone
for(uint i; i < _milestones.length; i++)
{
//mapping milestones to a projectId
projectMilestones[projectId].push(_milestones[i]);
}
emit CreateProject(
_description,
projectId,
_contractorAddress,
msg.sender
);
projectId++;

}

// contractors information

function createContractor(
   
    string memory _companyName,
    uint _registrationNumber,
    uint _taxIdenticationNumber,
    string memory _physicalAddress,
    string memory _addressImageCid,
    string memory _companyUploadedCid
) external {
 // validate the user address
    contractors.push(
        Contractor({
            companyName: _companyName,
            registrationNumber: _registrationNumber,
            taxIdenticationNumber: _taxIdenticationNumber,
            physicalAddress: _physicalAddress,
            owner:msg.sender,
            addressImageCid: _addressImageCid,
            companyUploadedCid: _companyUploadedCid
        })
    );
emit CreateContractor(_companyName, msg.sender, _registrationNumber);

}

function  getContractorsProject() external
{
    
}

function submitCompletedProject(
    uint _projectId,
    string memory _projectDescription,
    string memory  _projectImagecid  
) external{



}
// Getters functions

function getAllContractors() external view returns(Contractor[] memory) 
{
    return  contractors;
}

function getContractor(address _contractorAddress) external view  returns(Contractor memory ){
    require(_contractorAddress != address(0), "Address can't be zero");
    require(contractors.length>0, "No Contractor Onboard");
    for (uint i; i<contractors.length; i++){

        if (contractors[i].owner == _contractorAddress){
            return contractors[i];
        }

    }
    // Contractor not found
    return Contractor({
        companyName: "",
        registrationNumber: 0,
        taxIdenticationNumber: 0,
        physicalAddress: "",
        owner: address(0),
        addressImageCid: "",
        companyUploadedCid: ""
    });
}

}