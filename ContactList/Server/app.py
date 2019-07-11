from flask import Flask, jsonify
import json

app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify('Hello World!')

@app.route('/contacts')
def contacts():
    with open('contacts.json') as f:
        return jsonify(json.load(f))

if __name__ == '__main__':
    app.run()
