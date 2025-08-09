#!/bin/sh

REPOS_0="https://github.com/PawelSolecki/PRTF.git"
REPOS_1="https://github.com/PawelSolecki/PRTF-portfolio.git"
REPOS_2="https://github.com/PawelSolecki/PRTF-user-mgmt.git"
REPOS_3="https://github.com/PawelSolecki/PRTF-gateway.git"
REPOS_4="https://github.com/PawelSolecki/PRTF-frontend.git"

DIRS_0="security"
DIRS_1="portfolio-service"
DIRS_2="user-management"
DIRS_3="gateway"
DIRS_4="frontend"

# Environment variables per repo as multiline strings
ENV_CONTENT_0='POSTGRES_DB=keycloak
POSTGRES_USER=admin
POSTGRES_PASSWORD=admin
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin'

ENV_CONTENT_1='DB_USER=admin
DB_PASSWORD=admin'

ENV_CONTENT_2='DB_PASSWORD=admin
DB_USER=admin
KC_CLIENT_SECRET=nH3kcOFiWE4icMt4LtohcxHmkm4Rmux3'

ENV_CONTENT_3=''

ENV_CONTENT_4=''

# Count of repos
COUNT=5

# default mock mode false
MOCK_MODE=0

# parse args
while [ "$#" -gt 0 ]; do
  case "$1" in
    -m|--mock) MOCK_MODE=1 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
  shift
done

i=0
while [ $i -lt $COUNT ]; do
  # indirect expansion workaround: using eval
  eval repo_url=\$REPOS_$i
  eval repo_dir=\$DIRS_$i
  eval env_content=\$ENV_CONTENT_$i

  echo "=== Cloning $repo_dir ==="
  git clone "$repo_url" "$repo_dir"

  echo "Creating .env file in $repo_dir..."
  # write env content to .env file
  printf '%s\n' "$env_content" > "$repo_dir/.env"

  if [ "$MOCK_MODE" -eq 1 ]; then
    echo "Mock mode enabled — replacing app.mock_data=false → app.mock_data=true"
    find "$repo_dir" -type f -name "docker-compose*.yml" -exec \
      sed -i 's/app.mock_data=false/app.mock_data=true/g' {} +
  fi

  echo "Starting docker-compose in $repo_dir..."
  (cd "$repo_dir" && docker-compose up -d)

  echo "=== Finished $repo_dir ==="
  i=$((i + 1))
done

echo "All repositories have been processed."

printf "\n\033[1;32m======================================\033[0m\n"
printf "\033[1;32mDemo environment is now available!\033[0m\n"
printf "Open: \033[1;34mhttp://localhost:3000\033[0m\n"
printf "Login with:\n"
printf "  \033[1;33mUser:\033[0m    demo@demo.com\n"
printf "  \033[1;33mPassword:\033[0m omed\n"
printf "\033[1;32m======================================\033[0m\n"