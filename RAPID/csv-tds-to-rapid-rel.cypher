// CSV - TDS to SQL - RELATIONSHIPS
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/tds_to_rapid_columns_removed.csv' as row
//RETURN row LIMIT 10

MATCH (tds:TDS {name: row.tds}),  (sql:SQL {name: row.schema+'.'+row.table})

MERGE (tds)-[rel:DEPENDS]->(sql)
RETURN (tds)-[rel]->(sql)