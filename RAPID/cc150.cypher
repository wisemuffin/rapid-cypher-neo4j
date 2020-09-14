// CC150 twb
MATCH query=((twb:TWB)-[:DEPENDS*1..6]->(c))
WHERE twb.name CONTAINS 'CC150'
RETURN query