pragma solidity ^0.4.0;

contract Contest {
    
    string title;   // 比赛标题
    bool isFinished;    // 是否已经结束
    string desc;    // 简介
    address sponsor;    // 发起者
    uint ddl;       // 截止日期
    uint cost;      // 入门费
    uint bonus;     // 奖励金
    string content;     // 题目内容
    string answer;      // 答案
    address winner;     // 胜利者

    uint private Sponsorship = 100;  // 发起竞赛的费用

    struct Submit{
        string content;
        bool isSubmitted;
        uint begin;
        uint end;
    }
    
    enum Stages {
        ContestRunning,
        ContestRevealing,
        ContestFinished
    }
    
    mapping(address => Submit) public submisstions; // 所有用户提交记录
    address[] participants;
    Stages public stage = Stages.ContestRunning;
    
    // 创建新的竞赛
    constructor(string mTitle, string mDesc, uint mDDL, uint mCost, uint mBonus, string mContent, string mAnswer) public payable {
        require(msg.value >= Sponsorship + mBonus); // 只有支付大于 Sponsorship（wei）才能发起竞赛, 同时还需要支付bonus
        require(mDDL > 0);  // 距离截止时间必须大于1天
        title = mTitle;
        isFinished = false;
        desc = mDesc;
        sponsor = msg.sender;
        ddl = mDDL;
        cost = mCost;
        bonus = mBonus;
        content = mContent;
        answer = mAnswer;
        winner = msg.sender;
    }
    
    // 用户参与该竞赛
    function partcipate() public payable timedTransitions OnlyAtStage(Stages.ContestRunning){
        require(msg.value >= cost);     // 用户应该支付大于要求的入场费
        submisstions[msg.sender] = Submit("", false, now, 0);
        participants.push(msg.sender);
    }
    
    // 用户发起提交
    function submit(string _content) public onlyAllowedParticipants timedTransitions OnlyAtStage(Stages.ContestRunning){
        require(now <= ddl);    // 必须在ddl之内才可以提交
        require(!submisstions[msg.sender].isSubmitted);     // 只允许提交一次
        submisstions[msg.sender].content = _content;
        submisstions[msg.sender].isSubmitted = true;
        submisstions[msg.sender].end = now;
    }
    
    // 获取竞赛的基本信息
    function getContestBaseInfo() public timedTransitions returns(string, bool, string, address, uint, uint, uint){
        return (title, isFinished, desc, sponsor, ddl, cost, bonus);
    }
    
    // 获取竞赛题目内容 (考虑用户有没有权限)
    function getContestContent() public onlyAllowedParticipants timedTransitions returns(string){
        return content;
    }
    
    // 判断最终赢家, ddl达到后执行
    function checkWinner() internal timedTransitions OnlyAtStage(Stages.ContestRevealing) transitionNext{
        require(!isFinished);   // 保证只执行一次
        uint minConsume = 1 << 20;
        for(uint i = 0; i < participants.length; i++){
            Submit storage s = submisstions[participants[i]];
            log("Submit: ", s);
            // 用户已提交且答案正确
            if(s.isSubmitted && compareStringsbyBytes(s.content, answer)){
                uint last = s.end - s.begin;
                log("last: ", last);
                // 更新最短耗时和赢家
                if(last < minConsume) {
                    minConsume = last;
                    winner = participants[i];
                    log("Winner: ", winner);
                }
            }
        }
        // 胜利者得到奖金
        winner.transfer(bonus);
        log("Winner: ", winner);
        isFinished = true;
    }
    
    // 获取该竞赛所有信息, 只有竞赛结束后或者是sponser才可以调用
    function getContestAllInfo() public timedTransitions onlyAllowedSponsorOrContestEnd returns(string, bool, string, address, uint, uint, uint, string, string, address) {
        return (title, isFinished, desc, sponsor, ddl, cost, bonus, content, answer, winner);
    }

    // 判断用户是否在某个用户组里
    function isParticipant(address user, address[] users) private pure returns (bool){
        for(uint i = 0; i < users.length; i++){
            if(users[i] == user) {
                return true;
            }
        }
        return false;
    }
    
    
    // modifier 只允许已参与的用户访问
    modifier onlyAllowedParticipants{
        require(isParticipant(msg.sender, participants));
        _;
    }
    
    // 只允许发起者或者结束后可访问
    modifier onlyAllowedSponsorOrContestEnd{
        require(msg.sender==sponsor || now > ddl);
        _;
    }
    
    // 只有在某个状态下才可以进行
    modifier OnlyAtStage(Stages _stage){
        require(stage == _stage);
        _;
    }
    
    // 函数执行完后向下一个状态过渡
    modifier transitionNext(){
        _;
        nextStage();
    }

    
    // 判断截止时间是否到达以决定状态变化
    modifier timedTransitions() {
        if(stage == Stages.ContestRunning && now >= ddl){
            // 到达ddl后自动执行checkWinner()
            nextStage();
            checkWinner();
        }
        if(stage == Stages.ContestRevealing && isFinished)
            nextStage();
        _;
    }

    // 字符串比较函数
    function compareStringsbyBytes(string s1, string s2) internal pure returns(bool){
        return keccak256(bytes(s1)) == keccak256(bytes(s2));
    }
    
    // 使用Log事件方便debug
    event Log(string, string, bool, uint);
    function log(string k, Submit s) internal {
        emit Log(k, s.content, s.isSubmitted, s.end-s.begin);
    }
    
    event LogInt(string, uint);
    function log(string k, uint s) internal {
        emit LogInt(k, s);
    }
    
    event LogAddress(string, address);
    function log(string k, address s) internal {
        emit LogAddress(k, s);
    }
    
    // 向下一个状态过渡，只能内部调用
    function nextStage() internal{
        stage = Stages(uint(stage) + 1);
    }
    
}
