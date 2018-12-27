pragma solidity ^0.4.0;

import "./Contest.sol";

contract Playground {
    Contest contest;
    address[] public contests;
    mapping(address => address[]) partcipatedContests;
    mapping(address => address[]) sponsoredContests;
    
    
    function addContest(string mTitle, string mDesc, uint mDDL, uint mCost, uint mBonus, string mContent, string mAnswer)
        public payable returns (address) {
        address a = (new Contest).value(msg.value)(mTitle, mDesc, mDDL, mCost, mBonus, mContent, mAnswer);
        contest = Contest(a);
        contest.setSponsorAddr(msg.sender);
        contests.push(a);
        sponsoredContests[msg.sender].push(a);
        return a;
    }
    
    // 获取所有比赛合约地址, 通过前端筛选发起和参与的比赛
    function getContests() public view returns (address[]) {
        return contests;
    }
    
    function getSponsorredContestsNum() public view returns (uint) {
        return sponsoredContests[msg.sender].length;
    }
    
    function getSponsorredContestById(uint id) public view returns (address) {
        require(id < partcipatedContests[msg.sender].length && 0 <= id, "索引越界");
        return sponsoredContests[msg.sender][id];
    }
    
    function getPartcipatedContestsNum() public view returns (uint) {
        return partcipatedContests[msg.sender].length;
    }
    
    // 这里是真的迷，这种returns view函数超过4个在部署的时候就会发送transaction execution fail
    // function getParticipatedContestById(uint id) public view returns (address) {
    //     return partcipatedContests[msg.sender][id];
    // }
}
