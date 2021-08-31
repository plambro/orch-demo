#native imports
import os
import string

#3rd party imports
from flask import Flask, flash, redirect, request, render_template
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = os.environ.get('UPLOAD_FOLDER')
ALLOWED_EXTENSIONS = {'txt'}


app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

def allowed_file(filename):
    if '.' in filename and filename.rsplit('.', 1)[1] in ALLOWED_EXTENSIONS:
        return True


def word_counter(filename):
    counts = {}
    with open(filename, 'r') as f:
        for line in f.readlines():
            line = line.translate(line.maketrans('', '', string.punctuation)).strip().lower()
            words = line.split(' ')
            for word in words:
                if word in counts.keys():
                    counts[word] += 1
                else:
                    counts[word] = 1
        f.close()
    return counts


@app.route('/count', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            return redirect(request.url)
        target_file = request.files['file']
        if target_file.filename == '':
            return redirect(request.url)
        if target_file and allowed_file(target_file.filename):
            filename = secure_filename(target_file.filename)
            target_file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            word_count = word_counter(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            return word_count

    return render_template('upload.html')