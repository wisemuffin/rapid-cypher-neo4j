// CC A11S TDS IMPACTS
MATCH query=((tds:TDS)<-[:DEPENDS]-(:TWB))
WHERE tds.name = 'CC A11S - Orders'
RETURN query