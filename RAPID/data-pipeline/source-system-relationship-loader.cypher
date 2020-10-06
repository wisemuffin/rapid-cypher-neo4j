// CSV - staging to source
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/staging_to_source.csv' as row
//RETURN row LIMIT 10


MATCH  (source:Source {name: row.`source system`})
,(sql:SQL)
WHERE sql.schema = row.Schema
	AND sql.table = row.`Table / View`

MERGE (sql)-[rel:DEPENDS]->(source)
RETURN (sql)-[rel]->(source)