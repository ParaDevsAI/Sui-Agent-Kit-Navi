# Sui Agent Kit 🤖🌊 - Your Gateway to Automated DeFi on Navi Protocol

[![Sui Overflow 2025 Submission - Infrastructure & Tooling Track](https://img.shields.io/badge/Sui_Overflow_2025-Infra_&_Tooling-blue?style=for-the-badge)](https://overflowportal.sui.io/)

**The Sui Agent Kit was born from a passion to simplify DeFi development on the Sui blockchain and to empower builders like you for the Sui Overflow 2025 Hackathon!**

We believe that interacting with powerful DeFi protocols shouldn't be a complex ordeal. This kit is our answer: a robust, agent-friendly toolkit that abstracts the intricacies of the Navi Protocol SDK, exposing its rich functionalities as a set of intuitive "tools" through the Model-Context Protocol (MCP).

Our mission is to provide the foundational infrastructure that enables developers to rapidly prototype, build, and deploy sophisticated DeFi applications, automation scripts, and AI-powered agents on Sui, with a special focus on leveraging the deep liquidity and features of the Navi Protocol.

## Why Sui Agent Kit? The Hackathon Edge 🚀

If you're participating in the **Sui Overflow 2025 Hackathon**, the Sui Agent Kit is designed to give you a significant advantage:

*   🌟 **Dominate the Infrastructure & Tooling Track:** This kit *is* infrastructure! Showcase a powerful tool that lowers the barrier to entry for Navi Protocol integration and enables a new wave of automated DeFi applications.
*   🚀 **Accelerate Your DeFi & AI Projects:** Building for the DeFi or AI tracks? Integrate complex Navi operations (lending, borrowing, swaps, liquid staking) with just a few tool calls. Focus on your unique application logic, not SDK boilerplate.
*   🤖 **Build Smarter Agents:** The MCP-based architecture is perfect for creating intelligent agents that can manage portfolios, execute DeFi strategies, or provide automated financial services on Sui.
*   💡 **Innovate with Ease:** Quickly experiment with novel DeFi strategies by scripting interactions with Navi Protocol.
*   🛠️ **Focus on Value:** Spend less time wrestling with SDKs and more time building the features that will impress the judges.

## What is the Sui Agent Kit?

The Sui Agent Kit is a Node.js server application built with TypeScript. It acts as a bridge, translating simple MCP tool calls into direct interactions with the Navi Protocol on the Sui network.

**Core Components:**

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
    git clone <your_repository_url_here> # Replace with the actual URL to this Sui Agent Kit repo
    cd SuiAgentKit # Or your chosen repository name
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

## Use Cases & Inspiration for Hackathon Projects

*   **Automated Portfolio Rebalancer:** An agent that monitors your health factor on Navi and automatically deposits/withdraws collateral or repays/borrows assets to maintain a target health factor.
*   **Yield Farming Agent:** An agent that identifies high-yield opportunities on Navi (e.g., staking SUI for vSUI, supplying assets) and automatically moves funds to maximize returns.
*   **Arbitrage Bot:** An agent that monitors asset prices across Navi's swap aggregator and other DEXes, executing arbitrage opportunities.
*   **DeFi Dashboard with 1-Click Actions:** A web interface that uses the Sui Agent Kit in the backend to display portfolio information and allows users to perform complex Navi actions with a single click.
*   **AI-Powered Financial Advisor:** An AI agent that uses the kit to analyze market conditions and a user's portfolio, then suggests and (with permission) executes optimal DeFi strategies on Navi.
*   **Custom Tooling for Navi:** Extend the kit with more specialized tools or build new utilities around it for advanced Navi users.

## Contributing

We built the Sui Agent Kit to be a community asset! Contributions are welcome. Whether it's adding new tools, improving documentation, fixing bugs, or suggesting new features, please feel free to open an issue or submit a pull request.

Let's build the future of decentralized finance on Sui, together!

---

Good luck in the Sui Overflow 2025 Hackathon! We can't wait to see what you build with the Sui Agent Kit. 