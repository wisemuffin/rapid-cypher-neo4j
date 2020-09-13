// CSV - TBW to TDS
LOAD CSV WITH HEADERS
FROM 'file:///tbw_to_tds_RAPID.csv' as row
//RETURN row

WITH DISTINCT row.Project as Project, row.Workbook as Workbook, row.`Workbook Publisher` as `Workbook Publisher`
//RETURN Project,Workbook, `Workbook Publisher` LIMIT 10
MERGE (wb:TWB {name: Workbook})
	ON CREATE SET wb += {
    	Project:Project,
        `Workbook Publisher`:`Workbook Publisher`
    }

;