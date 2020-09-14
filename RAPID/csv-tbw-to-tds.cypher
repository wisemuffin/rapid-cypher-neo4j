// CSV - TBW to TDS
LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/wisemuffin/rapid-cypher-neo4j/master/RAPID/example-data/twb_to_tds_rapid.csv' as row
//RETURN row LIMIT 10

WITH DISTINCT row.`Project Name` as `Project`, row.`Workbook Name` as Name, row.`Friendly Name ( Users)` as `Publisher`
MERGE (wb:TWB {name: Name})
	ON CREATE SET wb += {
    	Project:Project,
        Publisher: Publisher
    }

;