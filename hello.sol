// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScholarlyArticles {
    address public owner;
    mapping(uint => Article) public articles;

    struct Article {
        uint id;
        string title;
        string authors;
        string contentHash; // IPFS or similar
        address[] reviewers;
        bool published;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function submitArticle(uint _id, string memory _title, string memory _authors, string memory _contentHash) external {
        articles[_id] = Article(_id, _title, _authors, _contentHash, new address[](0), false);
    }

    function publishArticle(uint _id) external onlyOwner {
        Article storage article = articles[_id];
        require(!article.published, "Article is already published");
        article.published = true;
    }

    function reviewArticle(uint _id) external {
        Article storage article = articles[_id];
        require(!article.published, "Article is already published");
        article.reviewers.push(msg.sender);
    }
}