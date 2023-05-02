import os
import json
from web3 import Web3
from pathlib import Path
from dotenv import load_dotenv
import streamlit as st

load_dotenv()

# Define and connect a new Web3 provider
w3 = Web3(Web3.HTTPProvider(os.getenv("WEB3_PROVIDER_URI")))

################################################################################
# Contract Helper function:
# 1. Loads the contract once using cache
# 2. Connects to the contract using the contract address and ABI
################################################################################


@st.cache(allow_output_mutation=True)
def load_contract():

    # Load Crowdsale ABI
    with open(Path('./contracts/compiled/SoxCoinCrowdsale_abi.json')) as f:
        SoxCoinCrowdsale_abi = json.load(f)

    # Set the contract address (this is the address of the deployed contract)
    contract_address = os.getenv("SMART_CONTRACT_ADDRESS")

    # Get the contract using web3
    contract = w3.eth.contract(
        address=contract_address,
        abi=SoxCoinCrowdsale_abi
    )

    return contract


# Load the contract
contract = load_contract()


################################################################################
# Purchase SoxCoin
################################################################################
accounts = w3.eth.accounts
# beneficiary = st.text_input("Enter Account Address", value=0)
weiRaised = contract.functions.weiRaised().call()
# Select amount your looking to buy

## Missing Code for weiamount, currently weiamount is = msg.sender whihc is not a public/callable.

# create Button 
st.title("SoxCoin")

# if st.button("Buy Token"):
    
#      tx_hash = contract.functions.buyTokens(beneficiary).call().transact({"from": w3.eth.accounts[0]})
#      receipt = w3.eth.waitForTransactionReceipt(tx_hash)
#      st.write(receipt)

# Create Button to View Crowdsale wei raised

if st.button("Amount raised"):
    # Call the awardCertificate function with web3
    st.write(f"Total amount Raised{weiRaised}")