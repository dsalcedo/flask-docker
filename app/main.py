from flask import Flask, Blueprint, request, Response

app = Flask(__name__)


# Index
@app.route('/', methods=['GET'])
def app_index():
    return 'Daniel Salcedo'


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
