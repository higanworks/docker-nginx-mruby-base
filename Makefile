.PHONY: test cleanup

test:
	docker-compose --file docker-compose.test.yml build
	docker-compose --file docker-compose.test.yml run sut

cleanup:
	docker-compose --file docker-compose.test.yml stop
	docker-compose --file docker-compose.test.yml rm -f
