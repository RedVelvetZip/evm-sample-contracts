import { ethers } from "hardhat";
import { SimpleNesting } from "../typechain-types";
import { ContractTransaction } from "ethers";

async function main() {
  const pricePerMint = ethers.utils.parseEther("0.0001");
  const totalTokens = 5;
  const [owner] = await ethers.getSigners();

  const contractFactory = await ethers.getContractFactory("SimpleNesting");
  const parent: SimpleNesting = await contractFactory.deploy(
    "Kanaria",
    "KAN",
    1000,
    pricePerMint
  );
  const child: SimpleNesting = await contractFactory.deploy(
    "Chunky",
    "CHN",
    1000,
    pricePerMint
  );

  await parent.deployed();
  await child.deployed();
  console.log(
    `Sample contracts deployed to ${parent.address} and ${child.address}`
  );

  // Mint tokens 1 to totalTokens
  let tx = await parent.mint(owner.address, totalTokens, {
    value: pricePerMint.mul(totalTokens),
  });
  await tx.wait();
  console.log("Minted totalTokens tokens");
  let totalSupply = await parent.totalSupply();
  console.log("Total parent tokens: %s", totalSupply);

  // Mint 2 children on each parent
  let allTx: ContractTransaction[] = [];
  for (let i = 1; i <= totalTokens; i++) {
    let tx = await child.mintNesting(parent.address, 2, i, {
      value: pricePerMint.mul(2),
    });
    allTx.push(tx);
  }
  console.log("Added 2 chunkies per kanaria");
  console.log("Awaiting for all tx to finish...");
  await Promise.all(allTx.map((tx) => tx.wait()));

  totalSupply = await child.totalSupply();
  console.log("Total child tokens: %s", totalSupply);

  let parentId = await child.ownerOf(1);
  let rmrkParent = await child.rmrkOwnerOf(1);
  console.log("Chunky's id 1 owner  is ", parentId);
  console.log("Chunky's id 1 rmrk owner is ", rmrkParent);
  console.log("Parent address: ", parent.address);

  // Accept the first child for kanaria id 1:
  tx = await parent.acceptChild(1, 0);
  await tx.wait();

  // Show accepted and pending children
  console.log("Children: ", await parent.childrenOf(1));
  console.log("Pending: ", await parent.pendingChildrenOf(1));

  // Send 1st child to owner:
  tx = await parent.unnestChild(1, 0, owner.address);
  await tx.wait();

  parentId = await child.ownerOf(1);
  rmrkParent = await child.rmrkOwnerOf(1);
  console.log("Chunky's id 1 parent is ", parentId);
  console.log("Chunky's id 1 rmrk owner is ", rmrkParent);
}

// main2();
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});