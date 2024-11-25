FROM almalinux:9.4
WORKDIR /app
COPY ../requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "pub-app.py"]