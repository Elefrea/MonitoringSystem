from flask import Flask, redirect, url_for, render_template
import os

app = Flask(__name__)

@app.route("/")
def home():
    imageList = os.listdir('static/images')
    imageList = ['/images/' + image for image in imageList]
    return render_template('index.html', imageList=imageList)

if __name__ == "__main__":
    app.run(debug = True)
