// CC A11S TDS IMPACTS
MATCH query=((tds:TDS)<-[:DEPENDS]-(:TWB))
WHERE tds.name = 'CC A11S - Orders'
RETURN query

;

// CC A11S TDS IMPACTS - in a table
MATCH (tds:TDS)<-[:DEPENDS]-(twb:TWB)
WHERE tds.name = 'CC A11S - Orders'
RETURN twb.name