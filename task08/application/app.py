from flask import Flask
import redis
import os

app = Flask(__name__)

def get_redis_client():
    redis_url = os.environ.get('REDIS_URL', 'localhost')
    redis_port = int(os.environ.get('REDIS_PORT', 6380))
    redis_pwd = os.environ.get('REDIS_PWD', '')
    redis_ssl = os.environ.get('REDIS_SSL_MODE', 'True').lower() == 'true'
    
    return redis.Redis(
        host=redis_url,
        port=redis_port,
        password=redis_pwd,
        ssl=redis_ssl
    )

@app.route('/')
def hello():
    creator = os.environ.get('CREATOR', 'Unknown')
    try:
        r = get_redis_client()
        visits = r.incr('visits')
        return f'Hello from {creator}. Visits: {visits}'
    except Exception as e:
        return f'Hello from {creator}. Redis error: {str(e)}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)