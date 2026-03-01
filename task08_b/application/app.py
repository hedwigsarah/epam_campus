import os
from flask import Flask
import redis

app = Flask(__name__)

# Get Redis configuration from environment variables
redis_host = os.environ.get('REDIS_URL', 'localhost')
redis_port = int(os.environ.get('REDIS_PORT', 6379))
redis_password = os.environ.get('REDIS_PWD', None)
creator = os.environ.get('CREATOR', 'Unknown')

# Initialize Redis client
redis_client = redis.Redis(
    host=redis_host,
    port=redis_port,
    password=redis_password,
    decode_responses=True
)

@app.route('/')
def hello():
    try:
        visits = redis_client.incr('visits')
    except redis.ConnectionError:
        visits = "Error connecting to Redis"
    
    return f"Hello from {creator}. Visits: {visits}"

@app.route('/health')
def health():
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
