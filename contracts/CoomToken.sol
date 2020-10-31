pragma solidity 0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CoomToken is ERC20("CoomToken", "COOM"), Ownable {
    using SafeMath for uint256;

    /// @dev Dev address
    address devaddr;

    constructor(address _devaddr) public {
        devaddr = _devaddr;
    }

    /**
    * @notice Mint _amount coom to address _to, also mints 2% to the dev_addr
    * @param _to The address that receives the tokens.
    * @param _amount The amount of Tokens to be minted.
    */
    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
        mintDev(_amount);
    }

    /**
    * @notice Sets the Dev address to a new Address
    * @param _dev_addr The new Dev address
    */
    function dev(address _devaddr) public {
        require(msg.sender == devaddr, "Coom: Set dev addr invalid signer");
        devaddr = _devaddr;
    }

    /**
    * @notice Function to mint 2% of tokens to dev address.
    * @param _amount The amount of tokens that are being minted in the calling function.
    */
    function mintDev(uint256 _amount) private {
        _mint(devaddr, _amount.div(50));
    }
}