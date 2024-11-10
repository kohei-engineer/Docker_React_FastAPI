FROM node:20-alpine as build

WORKDIR /app

COPY app/package*.json .

RUN npm install

COPY app/ .

RUN npm run build

FROM python:3.13.0-slim-bookworm

COPY --from=build /app/dist /project/app

WORKDIR /project

COPY main.py .
COPY requirements.txt .

RUN apt update && apt install -y python3
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5173

CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "main:app", "--bind", "0.0.0.0:5173"]