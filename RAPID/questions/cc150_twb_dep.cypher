// CC150 twb dependencies traversal
MATCH query=((twb:TWB)-[:DEPENDS*1..6]->(c))
WHERE twb.name CONTAINS 'CC150'
RETURN query

;


// CC150 twb dependencies traversal - just staging
MATCH (twb:TWB)-[:DEPENDS*1..20]->(c)
WHERE twb.name CONTAINS 'CC150'
WITH c
WHERE c:BIA_SA_STG or c:REF_SA_STG
RETURN DISTINCT c.schema, c.name