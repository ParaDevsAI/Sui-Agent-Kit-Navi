# PowerShell Script for Testing Navi MCP Server - Phase 9 Flow

Write-Host "---------------------------------------------------------------------"
Write-Host "Starting Navi MCP Server Test Flow (Phase 9)"
Write-Host "Ensure the MCP Server (npx ts-node src/index.ts) is RUNNING in another terminal."
Write-Host "Ensure your agent wallet has at least 1.5 SUI for this test."
Write-Host "This script assumes VSUI_STG or VSUI is the mapped symbol for vSUI in mappers.ts for reserve details."
Write-Host "---------------------------------------------------------------------"
Pause # Give user time to ensure server is running and review assumptions

$McpInspectorBaseCommand = "npx @modelcontextprotocol/inspector --cli ts-node src/index.ts"

# Define test amounts and symbols
$SuiStakeAmount = 1.0 # Changed from 0.1 to 1.0 SUI
$VSuiSymbolForDetails = "VSUI" # Using VSUI as the primary lookup, assuming mappers.ts will have it

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 1: Checking Initial Agent Portfolio"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 2: Getting SUI Reserve Details"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://market_info/reserve_detail/SUI"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 3: Staking SUI for vSUI (Amount: $SuiStakeAmount SUI)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method tools/call --tool-name navi_stakeSuiForVSui --tool-arg amount=$SuiStakeAmount"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 4: Checking Agent Portfolio after Staking SUI"
Write-Host "(Expect to see vSUI balance and reduced SUI balance)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 5: Getting vSUI Reserve Details (Symbol: $VSuiSymbolForDetails)"
Write-Host "(This requires $VSuiSymbolForDetails to be correctly mapped in mappers.ts)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://market_info/reserve_detail/$VSuiSymbolForDetails"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 6: Getting Agent Claimed Rewards History"
Write-Host "(This may be empty if no rewards have been claimed by the agent previously)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/rewards/history"
Pause

# Optional: Add a step here to unstake a specific amount if VSUI_STG is reliably mapped with decimals
# For now, we will proceed to unstake all vSUI for simplicity and robustness.

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 7: Unstaking ALL vSUI for SUI"
Write-Host "---------------------------------------------------------------------"
# For unstaking all, no 'amount' argument is provided to the tool
Invoke-Expression "$McpInspectorBaseCommand --method tools/call --tool-name navi_unstakeVSuiForSui"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step 8: Checking Agent Portfolio after Unstaking ALL vSUI"
Write-Host "(Expect to see SUI balance restored (less gas fees) and vSUI balance gone or zero)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Phase 9 Test Flow Complete."
Write-Host "Review the outputs of each step carefully."
Write-Host "---------------------------------------------------------------------" 