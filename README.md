# Sui Agent Kit 🤖🌊 - Your Gateway to Automated DeFi on Navi Protocol

[![Sui Overflow 2025 Submission - Infrastructure & Tooling Track](https://img.shields.io/badge/Sui_Overflow_2025-Infra_&_Tooling-blue?style=for-the-badge)](https://overflowportal.sui.io/)

<img src="/public/banner.png" />

**The Sui Agent Kit was born from a passion to simplify DeFi development on the Sui blockchain and to empower builders like you for the Sui Overflow 2025 Hackathon!**

We believe that interacting with powerful DeFi protocols shouldn't be a complex ordeal. This kit is our answer: a robust, agent-friendly toolkit that abstracts the intricacies of the Navi Protocol SDK, exposing its rich functionalities as a set of intuitive "tools" through the Model-Context Protocol (MCP).

Our mission is to provide the foundational infrastructure that enables developers to rapidly prototype, build, and deploy sophisticated DeFi applications, automation scripts, and AI-powered agents on Sui, with a special focus on leveraging the deep liquidity and features of the Navi Protocol.
## What is the Sui Agent Kit?

The Sui Agent Kit is a Node.js server application built with TypeScript. It acts as a bridge, translating simple MCP tool calls into direct interactions with the Navi Protocol on the Sui network.

## Use Cases 

*   **Automated Portfolio Rebalancer:** An agent that monitors your health factor on Navi and automatically deposits/withdraws collateral or repays/borrows assets to maintain a target health factor.
*   **Yield Farming Agent:** An agent that identifies high-yield opportunities on Navi (e.g., staking SUI for vSUI, supplying assets) and automatically moves funds to maximize returns.
*   **DeFi Dashboard with 1-Click Actions:** A web interface that uses the Sui Agent Kit in the backend to display portfolio information and allows users to perform complex Navi actions with a single click.
*   **AI-Powered Financial Advisor:** An AI agent that uses the kit to analyze market conditions and a user's portfolio, then suggests and (with permission) executes optimal DeFi strategies on Navi.
*   **Custom Tooling for Navi:** Extend the kit with more specialized tools or build new utilities around it for advanced Navi users.


##Core Components:##

*   **MCP Server (`navi-mcp-server/src/mcp_server/server.ts`):** Implements an MCP server using `@modelcontextprotocol/sdk`. It defines and registers all the tools available to interact with Navi.
*   **Navi SDK Integration (`navi-mcp-server/src/core_navi/navi_client.ts`):** Manages the connection to the Navi SDK, including wallet initialization (via mnemonic or private key from `.env`).
*   **Configuration (`navi-mcp-server/src/config.ts`):** Loads necessary environment variables (RPC URL, agent wallet credentials).
*   **Mappers (`navi-mcp-server/src/mcp_server/mappers.ts`):** Handles conversions between human-readable asset symbols/amounts and the formats required by the Navi SDK.
*   **Tool-Based API:** All interactions are exposed as MCP tools, making it easy for any MCP-compatible client (like an AI agent or the `@modelcontextprotocol/inspector` CLI) to use.

## Key Features & Capabilities

The Sui Agent Kit empowers your applications and agents to:

*   **📊 Manage Agent Portfolio:**
    *   `navi_getAgentPortfolio`: Retrieve current supply and borrow balances.
    *   `navi_getAgentHealthFactor`: Check the agent's health factor.
    *   `navi_getAgentDynamicHealthFactor`: Predict health factor after hypothetical supply/borrow changes.
*   **🌊 Interact with Lending Pools:**
    *   `navi_depositAsset`: Deposit SUI, USDC, USDT, etc., as collateral.
    *   `navi_withdrawAsset`: Withdraw deposited assets.
    *   `navi_borrowAsset`: Borrow assets against collateral.
    *   `navi_repayDebt`: Repay borrowed amounts.
*   **💱 Execute Swaps (via NAVI Aggregator):**
    *   `navi_getSwapQuote`: Get a quote for swapping one asset for another.
    *   `navi_executeSwap`: Execute the token swap.
*   💧 **Leverage Liquid Staking (vSUI):**
    *   `navi_stakeSuiForVSui`: Stake SUI to receive vSUI (VoloSui).
    *   `navi_unstakeVSuiForSui`: Unstake vSUI to receive SUI back.
*   **💰 Handle Rewards:**
    *   `navi_getAgentAvailableRewards`: Check for unclaimed rewards.
    *   `navi_claimAllAgentRewards`: Claim all available rewards.
    *   `navi_getAgentRewardsHistory`: View history of claimed rewards.
*   **📈 Access Market Data:**
    *   `navi_getPoolInfoBySymbol`: Get details for a specific asset pool (e.g., SUI pool).
    *   `navi_getAllPoolsInfo`: Get details for all available asset pools.
    *   `navi_getReserveDetail`: Get in-depth information about a specific asset reserve.
*   **✅ Basic Server Ping:**
    *   `ping`: Check if the Sui Agent Kit server is responsive.

*(Refer to the tool definitions in `navi-mcp-server/src/mcp_server/server.ts` for detailed input/output schemas for each tool).*

## Getting Started

### Prerequisites

1.  **Node.js and npm:** Ensure you have a recent version installed.
2.  **Sui Wallet:** You'll need a Sui wallet mnemonic or private key for the agent. This wallet will be used to sign transactions and interact with the Navi Protocol. Make sure it has SUI for gas fees and any assets you intend to use for testing (e.g., SUI for deposits).
3.  **Clone the Repository:**
    ```bash
    git clone https://github.com/ParaDevsAI/Sui-Agent-Kit/
    cd Sui-Agent-Kit
    ```

### Setup & Configuration

1.  **Navigate to the Server Directory:**
    ```bash
    cd navi-mcp-server
    ```
2.  **Install Dependencies:**
    ```bash
    npm install
    ```
3.  **Configure Environment Variables:**
    Create a `.env` file in the `navi-mcp-server` directory. You can copy `../.env.example` (if you create one at the root) or create it from scratch:
    ```env
    # Sui RPC URL - Mainnet, Testnet, or Devnet
    SUI_RPC_URL=https://fullnode.mainnet.sui.io:443

    # Your Agent's Wallet Mnemonic (recommended for ease of use)
    NAVI_AGENT_MNEMONIC="your twelve or twenty-four word mnemonic phrase here"

    # OR, if using a private key (Base64 encoded private key bytes - NOT the hex string)
    # Ensure this is the private key for the account derived from the mnemonic if you used mnemonic first
    # NAVI_AGENT_PRIVATE_KEY="your_base64_encoded_private_key_bytes_here"
    ```
    **Important:**
    *   Replace placeholders with your actual data.
    *   If using `NAVI_AGENT_PRIVATE_KEY`, it MUST be the Base64 encoded *bytes* of the private key.
    *   **Never commit your `.env` file with real credentials to a public repository!** The `.gitignore` file should already prevent this.

### Build the Kit

From the `navi-mcp-server` directory:

```bash
npm run build
```

This compiles the TypeScript code into JavaScript in the `dist` directory.

### Run the Sui Agent Kit Server

From the `navi-mcp-server` directory:

```bash
node dist/index.js
```

Configuring an MCP Client (e.g., for `mcp.json`)

If you are using an MCP client tool that relies on a JSON configuration file (often named `mcp.json` or similar, like the one used by `@modelcontextprotocol/inspector` if not using the `--cli` flag directly), you'll need to configure it to correctly launch and manage the Sui Agent Kit server.

Below is an example snippet of how you might configure the `navi-mcp-agent` within such a JSON file. **You will need to modify the file paths to match your local machine setup.**

```json
{
  "mcpServers": {
    "navi-mcp-agent": {
      "command": "node",
      "args": [
        "YOUR_ABSOLUTE_PATH_TO/SuiAgentKit/navi-mcp-server/dist/index.js"
      ],
      "cwd": "YOUR_ABSOLUTE_PATH_TO/SuiAgentKit/navi-mcp-server",
      "env": {
        "SUI_RPC_URL": "https://fullnode.mainnet.sui.io:443",
        "NAVI_AGENT_MNEMONIC": "your optional mnemonic if not using .env or to override .env",
        "NAVI_AGENT_PRIVATE_KEY": "your_optional_private_key_if_not_using_.env_or_to_override_.env"
      }
    }
  }
}
```
**Key parts to customize:**

*   **`"args"`**:
    *   The path `\"YOUR_ABSOLUTE_PATH_TO/SuiAgentKit/navi-mcp-server/dist/index.js\"` is crucial. Replace `YOUR_ABSOLUTE_PATH_TO` with the actual absolute path to the `SuiAgentKit` directory on your system. For example:
        *   On Windows: `\"C:\\\\Users\\\\YourUser\\\\Projects\\\\SuiAgentKit\\\\navi-mcp-server\\\\dist\\\\index.js\"` (note the double backslashes for JSON compatibility).
        *   On macOS/Linux: `\"/Users/YourUser/Projects/SuiAgentKit/navi-mcp-server/dist/index.js\"`.
        *   
*   **`\"cwd\"`** (Current Working Directory):
    *   Similarly, replace `YOUR_ABSOLUTE_PATH_TO` in `\"YOUR_ABSOLUTE_PATH_TO/SuiAgentKit/navi-mcp-server\"` with the absolute path to the `navi-mcp-server` directory.
        *   On Windows: `\"C:\\\\Users\\\\YourUser\\\\Projects\\\\SuiAgentKit\\\\navi-mcp-server\"`.
        *   On macOS/Linux: `\"/Users/YourUser/Projects/SuiAgentKit/navi-mcp-server\"`.
        *   
*   **`\"env\"`**:
    *   This section allows you to set environment variables specifically for the agent when launched by the MCP client.
    *   Values provided here can override those set in an `.env` file loaded by the `navi-mcp-server` itself, or they can be used if no `.env` file is present.
    *   Be cautious about hardcoding sensitive information like `NAVI_AGENT_PRIVATE_KEY` or `NAVI_AGENT_MNEMONIC` directly into a JSON file if this file might be shared or committed to version control. For local development and testing, it can be convenient. Using a `.env` file within the `navi-mcp-server` directory (as described in the main setup) is generally recommended for managing secrets.


This JSON configuration tells your MCP client how to start the Sui Agent Kit server (`node dist/index.js`), where to find it (`args` and `cwd`), and what environment variables to pass to it.

You should see log messages indicating the server has started and is connected to the Navi SDK. It's now ready to accept MCP tool calls!

### Interacting with the Kit (Testing & Development)

The easiest way to send tool calls to the running Sui Agent Kit is using the **MCP Inspector CLI**:

1.  **Ensure the Sui Agent Kit server is running** in one terminal.
2.  In **another terminal** (from the `navi-mcp-server` directory, or ensure `npx` can find the local `node_modules`):

    ```bash
    # Example: Ping the server
    npx @modelcontextprotocol/inspector --cli ts-node src/index.ts --method tools/call --tool-name mcp_navi-mcp-agent_ping --tool-arg random_string=hello

    # Example: Get Agent Portfolio
    npx @modelcontextprotocol/inspector --cli ts-node src/index.ts --method tools/call --tool-name navi_getAgentPortfolio

    # Example: Deposit 0.1 SUI
    npx @modelcontextprotocol/inspector --cli ts-node src/index.ts --method tools/call --tool-name navi_depositAsset --tool-arg assetSymbol=SUI --tool-arg amount=0.1
    ```

    *   **Note:** The `--cli ts-node src/index.ts` part in the inspector command tells it how to start *another instance* of your server for inspection if it weren't already running or for schema discovery. Since your server is already running and listening on stdio, the inspector can also directly pipe requests to it if configured to do so, but the provided examples generally work by having the inspector manage a child process. For direct interaction with an already running stdio server, you'd typically pipe JSON MCP requests to its stdin.
    *   Refer to the test scripts (`test_general_flow.ps1`, etc.) in the `navi-mcp-server` directory for more examples of tool calls and their arguments. These PowerShell scripts can be adapted to bash or other scripting languages.


<details>
<summary><h1> All Functions</h1></summary>

| **Function Name**                        | **Description**                                                                 |
|------------------------------------------|---------------------------------------------------------------------------------|
| `initializeNaviConnection`               | Initializes the Navi SDK connection already been established.                   |
| `sleep`                                  | Utility function that pauses execution for a specified number of milliseconds.  |
| `handleGetPoolInfoResource`              | Fetches pool info (by symbol or all) for the legacy resource interface (used internally). |
| `handleGetPoolInfoBySymbolTool`          | Gets detailed pool information for a specific asset symbol using the Navi protocol. |
| `handleGetAllPoolInfoTool`               | Gets detailed information for all available pools in the Navi protocol.         |
| `handleGetAgentPortfolioTool`            | Retrieves the agent’s current asset portfolio (supply and borrows balances).    |
| `handleGetAgentHealthFactorTool`         | Fetches the agent’s current health factor.                                      |
| `handleError`                            | Formats errors from SDK operations into a standard tool result structure.       |
| `handleNaviDepositAsset`                 | Handles depositing a specified amount of an asset into Navi for the agent.      |
| `handleNaviWithdrawAsset`                | Handles withdrawing the specified amount of an asset from Navi for the agent.   |
| `handleNaviBorrowAsset`                  | Handles borrowing a specified amount of an asset from Navi for the agent.       |
| `handleNaviRepayDebt`                    | Handles repaying a specified amount of debt given asset in Navi.                |
| `handleGetSwapQuoteTool`                 | Gets a swap quote for exchanging one asset for another via the NAVI aggregator. |
| `handleNaviExecuteSwap`                  | Executes a token swap via the NAVI aggregator, given swap and slippage parameters. |
| `handleGetAgentAvailableRewardsTool`     | Retrieves all available (unclaimed) rewards for the agent.                      |
| `handleClaimAgentRewards`                | Claims all available rewards for the agent, optionally updating oracle prices first. |
| `handleGetAgentDynamicHealthFactorTool`  | Predicts agent’s health factor after a hypothetical change in supply/borrow for a specific asset. |
| `handleGetReserveDetailTool`             | Gets detailed info about a specific asset’s reserve in the Navi protocol.       |
| `handleStakeSuiForVSui`                  | Stakes SUI (VolSui) to receive vSUI; enforces a minimum stake amount.           |
| `handleUnstakeVSuiForSui`                | Unstakes vSUI (VolSui) to receive SUI; can unstake a specific amount or all vSUI. |
| `handleGetAgentRewardsHistoryTool`       | Gets the agent’s history of claimed rewards, with optional pagination.          |

</details>

## Contributing

We built the Sui Agent Kit to be a community asset! Contributions are welcome. Whether it's adding new tools, improving documentation, fixing bugs, or suggesting new features, please feel free to open an issue or submit a pull request.

Let's build the future of decentralized finance on Sui, together!

---
