const { expect } = require("chai");
const { ethers } = require("hardhat");

let contract;
let owner;
let addr1;
let addr2;
let addrs;

beforeEach(async function () {
    const Cryptos = await ethers.getContractFactory("Cryptos");
    contract = await Cryptos.deploy();

    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();
});

describe("Cryptos contract", function () {
    it("Deployment should assign the total supply of tokens to the owner", async function () {
        const ownerBalance = await contract.balanceOf(owner.address);

        expect(await contract.totalSupply()).to.equal(ownerBalance);
    });
});

describe("Cryptos transfer", function () {
    it("Should transfer tokens between accounts", async function () {
        await contract.transfer(addr1.address, 50);
        expect(await contract.balanceOf(addr1.address)).to.equal(50);

        await contract.connect(addr1).transfer(addr2.address, 50);
        expect(await contract.balanceOf(addr2.address)).to.equal(50);
        expect(await contract.balanceOf(addr1.address)).to.equal(0);
    });
});