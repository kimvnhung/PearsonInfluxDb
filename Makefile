test-flux:
	docker exec -it influx_db influx query --org HungKV --file /var/opt/query/fluxql.flux --t jAqEdZkqfkDnu-vzqkPbVzpqgM3EdIeHsG2mOnNS1LSCxj3CIzcELvDifwUkEG2-DeuT3eX_U5MmXBlI5sidWw== > query/result.txt
	code -r ./query/result.txt

test-flux2:
	docker exec -it influx_db influx query --org HungKV --file /var/opt/query/test_query.flux --t jAqEdZkqfkDnu-vzqkPbVzpqgM3EdIeHsG2mOnNS1LSCxj3CIzcELvDifwUkEG2-DeuT3eX_U5MmXBlI5sidWw== > query/result1.txt
	code -r ./query/result1.txt