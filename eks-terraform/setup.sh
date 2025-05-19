#!/bin/bash

# Define the target directory
TARGET_DIR="/home/ec2-user/eks-terraform/sample-app"

# Create the target directory if it doesn't exist
mkdir -p $TARGET_DIR

# Navigate to the target directory
cd $TARGET_DIR

# Create app.py file
cat <<EOF > app.py
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "✅ Hello from your Dockerized Flask App running on EKS!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# Create requirements.txt file
echo "flask" > requirements.txt

# Create Dockerfile
cat <<EOF > Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
EOF

# Output success message
echo "All files (app.py, requirements.txt, Dockerfile) have been created in $TARGET_DIR"
