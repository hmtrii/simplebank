postgres:
	docker run --name postgres --network my_net -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:13

createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres dropdb --username=root -f simple_bank

migrateup:
	migrate --path ./db/migration --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate --path ./db/migration --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose down

sqlc:
	sqlc generate
	
test:
	go test -v -cover ./...
	
.PHONY:postgres createdb dropdb migrateup migratedown