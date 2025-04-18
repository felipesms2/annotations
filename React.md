# Cria o projeto Vite React na pasta atual
docker run -it --rm -v ${PWD}:/app -w /app node:23-alpine3.20 sh -c "npm create vite@latest . -- --template react"

# Instala as dependências (execute na mesma pasta)
docker run -it --rm -v ${PWD}:/app -w /app node:23-alpine3.20 sh -c "npm install"

# Roda o projeto
docker run -it --rm -v ${PWD}:/app -w /app node:23-alpine3.20 sh -c "npm run dev"
