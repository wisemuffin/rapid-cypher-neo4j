MATCH (x)-[:DEPENDS*1..15]->(sql:SQL)-[:DEPENDS*1..20]->(n)
WHERE toLower(sql.name) contains 'tableau'
WITH sql, n, x
WHERE n:Source AND x:TDS
RETURN sql.schema, sql.table, sql.path, collect(distinct n.name), collect(distinct x.name)