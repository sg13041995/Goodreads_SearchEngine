from semod import *
from flask import Flask, request
from flask_cors import CORS

cn,cs=connect(creds=read(filename="config.ini",section="mysql"))
dictionary = joblib.load("../ModelMemory/title_without_series_dictionary.joblib")
bm25_index = joblib.load("../ModelMemory/title_without_series_matrix.joblib")
tfidf_model = joblib.load("../ModelMemory/title_without_series_tfidf_bnn.joblib")


app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "http://localhost:5173"}})

@app.route('/api/allcol', methods=['GET'])
def get_books():
    # Retrieve query parameters from the request
    query_str = request.args.get('query')

    indices = bm25_top_hits(query=query_str,
                        tfidf_model=tfidf_model,
                        bm25_index=bm25_index,
                        dictionary=dictionary, 
                        n=30)
    data  = get_data_by_index(indices=indices,cs=cs)
   
    # Sample data for GET request
    return allbooks_to_json(data[0])

@app.route('/api/uniquetitle', methods=['GET'])
def get_titles():
    # Retrieve query parameters from the request
    query_str = request.args.get('query','')

    indices = bm25_top_hits(query=query_str,
                        tfidf_model=tfidf_model,
                        bm25_index=bm25_index,
                        dictionary=dictionary, 
                        n=30)
    titles  = get_titles_by_index(indices=indices,cs=cs)
    
    # Sample data for GET request
    return alltitles_to_json(titles[0])

if __name__ == '__main__':
    app.run(debug=True)