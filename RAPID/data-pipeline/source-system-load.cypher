// CSV - staging to source
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/staging_to_source.csv' as row
//RETURN row LIMIT 10

WITH DISTINCT row.`source system` as name
MERGE (source:Source {name: name})
;