select distinct
	concat('ACT',right(concat('00000',row_number() over(order by newid())),6)) 'AccountID'
	, ID 'ClientID'
	, IsActive
        , LOB
	, case when FirstDxOrder is null OR year(FirstDxOrder) >= 2022 then '0' else '1' end 'DxFlag'
	, case when FirstIrixOrder is null OR year(FirstIrixOrder) >= 2022 then '0' else '1' end 
	  + case when isnull(FirstRiskScoreNoCreditOrder,FirstRiskScoreCreditOrder) is null OR year(isnull(FirstRiskScoreNoCreditOrder,FirstRiskScoreCreditOrder)) >= 2022 then '0' else '1' end 
	  + case when FirstRxOrder is null OR year(FirstRxOrder) >= 2022 then '0' else '1' end 
	  + case when FirstDxOrder is null OR year(FirstDxOrder) >= 2022 then '0' else '1' end 
	  + case when FirstCreditOrder is null OR year(FirstCreditOrder) >= 2022 then '0' else '1' end 
		'ProductID'
	, case when YEAR(FirstIrixOrder) >= 2022 THEN NULL ELSE FirstIrixOrder END 'FirstRulesOrder'
	, case when YEAR(FirstRxOrder) >= 2022 THEN NULL ELSE FirstRxOrder END 'FirstRxOrder'
	, case when FirstIrixOrder is null OR year(FirstIrixOrder) >= 2022 then 0 else 1 end 
	  + case when isnull(FirstRiskScoreNoCreditOrder,FirstRiskScoreCreditOrder) is null OR year(isnull(FirstRiskScoreNoCreditOrder,FirstRiskScoreCreditOrder)) >= 2022 then 0 else 1 end 
	  + case when FirstRxOrder is null OR year(FirstRxOrder) >= 2022 then 0 else 1 end 
	  + case when FirstDxOrder is null OR year(FirstDxOrder) >= 2022 then 0 else 1 end 
	  + case when FirstCreditOrder is null OR year(FirstCreditOrder) >= 2022 then 0 else 1 end 
		'ProductCount'
from analyticspbi..PBI_Accounts a
join (select distinct SQL_ClientName
			, concat('CID',right(concat('0000000',dense_rank() over(order by SQL_ClientName)),6)) 'ID'
			from analyticspbi..PBI_Accounts) b on a.SQL_ClientName = b.SQL_ClientName
where a.LOB <> 'Batch Pilot'
AND YEAR(a.FirstRxOrder) <=2021