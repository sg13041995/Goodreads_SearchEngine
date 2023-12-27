# Import necessary libraries and modules
from semod import *
from flask import Flask, request
from flask_cors import CORS

# Connect to the MySQL database using credentials from config.ini
cn, cs = connect(creds=read(filename="config.ini", section="mysql"))

# Load pre-trained models and data for book recommendations
dictionary = joblib.load("../ModelMemory/title_without_series_dictionary.joblib")
bm25_index = joblib.load("../ModelMemory/title_without_series_matrix.joblib")
tfidf_model = joblib.load("../ModelMemory/title_without_series_tfidf_bnn.joblib")

# Create a Flask application
app = Flask(__name__)
# Enable Cross-Origin Resource Sharing (CORS) for API routes
CORS(app, resources={r"/api/*": {"origins": "http://localhost:5173"}})

# Define an API endpoint for retrieving all book data based on a query
@app.route('/api/allcol', methods=['GET'])
def get_books():
    # Retrieve query parameters from the request
    query_str = request.args.get('query')

    # Strip the spaces and check the length
    # If the length is 0, return an empty list as JSON
    if len(query_str.strip()) == 0:
        return allbooks_to_json(data=None)
    else:
        # Get indices of top book recommendations using BM25 algorithm
        indices = bm25_top_hits(query=query_str,
                                tfidf_model=tfidf_model,
                                bm25_index=bm25_index,
                                dictionary=dictionary,
                                n=30)

        # If no indices are found, return an empty list as JSON
        if indices is None:
            return allbooks_to_json(data=None)
        else:
            # Retrieve book data based on the indices
            data = get_data_by_index(indices=indices, cs=cs)
            return allbooks_to_json(data[0])

# Define an API endpoint for retrieving unique book titles based on a query
@app.route('/api/uniquetitle', methods=['GET'])
def get_titles():
    # Retrieve query parameters from the request
    query_str = request.args.get('query', '')

    # Strip the spaces and check the length
    # If the length is 0, return an empty list as JSON
    if len(query_str.strip()) == 0:
        return allbooks_to_json(None)
    else:
        # Get indices of top book recommendations using BM25 algorithm
        indices = bm25_top_hits(query=query_str,
                                tfidf_model=tfidf_model,
                                bm25_index=bm25_index,
                                dictionary=dictionary,
                                n=30)
        # If no indices are found, return an empty list as JSON
        if indices is None:
            return allbooks_to_json(data=None)
        else:
            # Retrieve book titles based on the indices
            titles = get_titles_by_index(indices=indices, cs=cs)
            return alltitles_to_json(titles[0])

# Run the Flask application in debug mode if the script is executed directly
if __name__ == '__main__':
    app.run(debug=True)
