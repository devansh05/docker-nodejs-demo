FROM node:20-alpine as base

# STAGE 1 Builder
FROM base as builder

WORKDIR /home/node-demo

COPY package.json .
COPY tsconfig.json .
RUN npm install

COPY src ./src

RUN npm run build

# STAGE 2 Runner

FROM base as runner

WORKDIR /home/node-demo/dist

COPY --from=builder /home/node-demo/dist dist/
COPY --from=builder /home/node-demo/package*.json .

RUN npm install --omit=dev

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system -uid 1001 nodejs

USER nodejs

EXPOSE 8000
ENV PORT=8000

CMD ["npm", "run", "dev"]

# docker run -it -p 3000:3000--envfile=./.env ts-node