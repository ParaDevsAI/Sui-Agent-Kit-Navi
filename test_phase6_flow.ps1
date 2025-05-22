# PowerShell Script for Testing Navi MCP Server - Phase 6 Flow

Write-Host "---------------------------------------------------------------------"
Write-Host "Starting Navi MCP Server Test Flow (Phase 6)"
Write-Host "Ensure the MCP Server (npx ts-node src/index.ts) is RUNNING in another terminal."
Write-Host "---------------------------------------------------------------------"
Pause # Give user time to ensure server is running

$McpInspectorBaseCommand = "npx @modelcontextprotocol/inspector --cli ts-node src/index.ts"

# Define test amounts (human-readable)
$SuiDepositAmount = 1.0
$SuiWithdrawAmount = 0.2
$UsdcBorrowAmount = 0.1 # Assuming USDC is borrowable and SUI deposit is enough collateral
$UsdcRepayAmount = 0.1

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step A: Depositing SUI (Amount: $SuiDepositAmount)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method tools/call --tool-name navi_depositAsset --tool-arg assetSymbol=SUI --tool-arg amount=$SuiDepositAmount"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step B: Checking Agent Portfolio after SUI Deposit"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step C: Withdrawing SUI (Amount: $SuiWithdrawAmount)"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method tools/call --tool-name navi_withdrawAsset --tool-arg assetSymbol=SUI --tool-arg amount=$SuiWithdrawAmount --tool-arg updateOracle=true"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step D: Checking Agent Portfolio after SUI Withdrawal"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step E: Borrowing USDC (Amount: $UsdcBorrowAmount)"
Write-Host "NOTE: This assumes sufficient SUI collateral and USDC availability."
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method tools/call --tool-name navi_borrowAsset --tool-arg assetSymbol=USDC --tool-arg amount=$UsdcBorrowAmount --tool-arg updateOracle=true"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step F: Checking Agent Health Factor after Borrow"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/health_factor"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step G: Checking Agent Portfolio after Borrow"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step H: Repaying USDC (Amount: $UsdcRepayAmount)"
Write-Host "NOTE: This assumes the agent's wallet received the borrowed USDC."
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method tools/call --tool-name navi_repayDebt --tool-arg assetSymbol=USDC --tool-arg amount=$UsdcRepayAmount"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step I: Final Agent Portfolio Check"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/portfolio"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Step J: Final Agent Health Factor Check"
Write-Host "---------------------------------------------------------------------"
Invoke-Expression "$McpInspectorBaseCommand --method resources/read --uri navi://agent/health_factor"
Pause

Write-Host "`n---------------------------------------------------------------------"
Write-Host "Test Flow Complete."
Write-Host "---------------------------------------------------------------------" 