from flask import Flask

app = Flask('test')

@app.route('/ping', methods=['GET'])
def ping():
    return 'PONG'

# By putting @app.route on top of the function definition, we assign the /ping address of the web service to the ping function.
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=9696)