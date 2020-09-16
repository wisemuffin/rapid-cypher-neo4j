// Question Which TDS are impacted by cc_work_order_v
MATCH (wo:SQL), (n)
WHERE wo.table = 'cc_work_order_v'
AND wo.schema = 'cc_dde'
AND (n:SQL OR n:TDS)
MATCH (wo)<-[:DEPENDS*1..9]-(n)
WHERE n:TDS
RETURN DISTINCT n.name

;

// or give me the twbs
MATCH (wo:SQL), (n)
WHERE wo.table = 'cc_work_order_v'
AND wo.schema = 'cc_dde'
AND (n:SQL OR n:TDS OR n:TWB)
MATCH (wo)<-[:DEPENDS*1..9]-(n)
WHERE n:TWB
RETURN DISTINCT n.name