docker compose exec stack cozy-stack instances add \
    --apps home,banks,contacts,drive,notes,passwords,photos,settings,store \
    --email "test@test.com" \
    --locale en \
    --tz "America/New_York" \
    --passphrase password \
    domain.example


docker exec -it cozy-stack cozy-stack instances add \
    --apps home,banks,contacts,drive,notes,passwords,photos,settings,store \
    --email "test@localhost:8080" \
    --locale en \
    --tz "America/New_York" \
    --passphrase password \
    localhost:8080