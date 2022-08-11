### sqitch variables

```
echo "\l" | docker compose exec -T db psql -h localhost -U postgres | egrep "development|Name|-----"
echo

./sqitch deploy

echo "\l" | docker compose exec -T db psql -h localhost -U postgres | egrep "development|Name|-----"
echo

./sqitch revert

echo "\l" | docker compose exec -T db psql -h localhost -U postgres | egrep "development|Name|-----"
```