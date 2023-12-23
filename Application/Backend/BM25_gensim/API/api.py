from semod import *
from flask import Flask, request

cn,cs=connect(creds=read(filename="config.ini",section="mysql"))
dictionary = get_pkl_file(path="../ModelMemory/dictionary.pkl",mode="rb")
bm25_index = get_pkl_file(path="../ModelMemory/bm25_index.pkl",mode="rb")


app = Flask(__name__)

@app.route('/api/allcol', methods=['GET'])
def get_books():
    # Retrieve query parameters from the request
    query_str = request.args.get('query')

    indices = bm25_top_hits(query=query_str, dictionary=dictionary, bm25_index=bm25_index, n=30)
    data  = get_data_by_index(indices=indices,cs=cs)
   
    # Sample data for GET request
    return to_json(data[0])

@app.route('/api/uniquetitle', methods=['GET'])
def get_titles():
    # Retrieve query parameters from the request
    query_str = request.args.get('query')

    indices = bm25_top_hits(query=query_str, dictionary=dictionary, bm25_index=bm25_index, n=30)
    titles  = get_titles_by_index(indices=indices,cs=cs)
   
    # Sample data for GET request
    return to_list(titles[0])

if __name__ == '__main__':
    app.run(debug=True)