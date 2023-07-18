import Web3 from "web3";


let selectedAccount;

let userContract;

export const init = async () => {
    const UserContract = require("./truffle/build/contracts/UserContract.json");
  let provider = window.ethereum;
  if (typeof provider !== "undefined") {
    //Metamask is installed
    provider
      .request({ method: "eth_requestAccounts" })
      .then((accounts) => {
        selectedAccount = accounts[0];
        console.log(`Selected account is ${selectedAccount}`);
      })
      .catch((err) => {
        console.log(err);
      });

    window.ethereum.on("accountsChanged", function (accounts) {
      selectedAccount = accounts[0];
      console.log(`Selected accounts changed to ${selectedAccount}`);
    });
  }
  const web3 = new Web3(provider);

  const networkId = await web3.eth.net.getId();

  userContract = new web3.eth.Contract(
    UserContract.abi,
    UserContract.networks[networkId].address
  );
};

export const register = (username,email,password,role) => {
  return userContract.methods
    .register(username, email, password, role)
    .send({from:selectedAccount});
};

export const login = (email,password) => {
    return userContract.methods
      .login(email, password)
      .send({from:selectedAccount});
  };


