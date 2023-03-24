.PHONY: test cleanup

test:
	docker-compose --file docker-compose.test.yml build --build-arg TARGETPLATFORM=linux/arm64 --build-arg TARGETARCH=arm64
	docker-compose --file docker-compose.test.yml run sut

cleanup:
	docker-compose --file docker-compose.test.yml stop
	docker-compose --file docker-compose.test.yml rm -f
	docker container prune -f
