aws ce get-cost-and-usage --time-period \
Start="$(( $(date +'%Y') - 1 ))-$(date +'%m')-01",\
End=$(date +'%Y-%m-%d') --granularity MONTHLY --metrics "BlendedCost" "UnblendedCost" "UsageQuantity" \
| jq '.ResultsByTime[] | {payperiod: .TimePeriod, billed: .Total.BlendedCost.Amount}' \
| jq -s 
