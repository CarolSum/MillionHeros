pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Playground.sol";

contract TestPlayground {
    // init balance
    uint public initialBalance = 1 ether;

    // The address of the adoption contract to be tested
    Playground playground = Playground(DeployedAddresses.Playground());

    // The id of the pet that will be used for testing
    uint expectedPetId = 8;

    //The expected owner of adopted pet is this contract
    address testContestAddress;
    Contest contest;

    // Test getContests()
    function testGetContests() public {
        Assert.equal(playground.getContests().length, 0, "初始时链上没有部署的Contest合约");
    }

    // Test addContest()
    function testAddContest() public payable {
        // "Title1", "This is a description", 30, 20, 1000, "[{title:'这是一道题目', choice: ['aaa', 'bbb', 'ccc']}]","{'0':'1'}"
        testContestAddress = playground.addContest.value(2000)
            ("Title1", "This is a description", 1545918601003, 20, 1000, "[{title:'这是一道题目', choice: ['aaa', 'bbb', 'ccc']}]","{'0':'1'}");
        contest = Contest(testContestAddress);
        Assert.equal(playground.getContests().length, 1, "部署一个智能合约之后长度为1");
        Assert.equal(playground.getContests()[0], testContestAddress, "第一个Contest合约的地址需放入数组中");
        Assert.equal(contest.isSponsor(), true, "发起用户需一致");
    }

    // Test getSponsorredContestsNum()
    function testGetSponsorredContestsNum() public payable {
        playground.addContest.value(2000)
            ("Title1", "This is a description", 1545918601003, 20, 1000, "[{title:'这是一道题目', choice: ['aaa', 'bbb', 'ccc']}]","{'0':'1'}");
        playground.addContest.value(2000)
            ("Title2", "This is a description", 1545918601003, 20, 1000, "[{title:'这是一道题目', choice: ['aaa', 'bbb', 'ccc']}]","{'0':'1'}");
        uint num = playground.getSponsorredContestsNum();
        Assert.equal(num, 3, "继续发起两个比赛后查看自己发起的比赛数量，值应为3");
    }

    // 对部署的Contest进行测试 //

    // test partcipate()
    function testPartcipate () public payable {
        contest.partcipate.value(50)();
        Assert.equal(contest.isParticipant(), true, "成功参与比赛");
    }

    // test getContestBaseInfo()
    function testGetContestBaseInfo() public {
        Assert.equal(contest.getContestContent(), "[{title:'这是一道题目', choice: ['aaa', 'bbb', 'ccc']}]", "部署Contest的内容应一致");
    }

    function testSubmit() public {
        contest.submit("this is answer");
        // Assert.equal(contest.getUserSubmisstions(), "this is answer", "获取提交结果应一致");
    }
}