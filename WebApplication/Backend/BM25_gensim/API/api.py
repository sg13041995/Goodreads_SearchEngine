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
@app.route('/api/books-all', methods=['GET'])
def books_all():
    # Retrieve query parameters from the request
    query_str = request.args.get('query')

    # Strip the spaces and check the length
    # If the length is 0, return an empty list as JSON
    if len(query_str.strip()) == 0:
        return book_alldetails_tojson(data=None)
    else:
        # Get indices of top book recommendations using BM25 algorithm
        indices = bm25_top_hits(query=query_str,
                                tfidf_model=tfidf_model,
                                bm25_index=bm25_index,
                                dictionary=dictionary,
                                n=30)

        # If no indices are found, return an empty list as JSON
        if indices is None:
            return book_alldetails_tojson(data=None)
        else:
            # Retrieve book data based on the indices
            data = book_alldetails_byindex(indices=indices, cs=cs)
            return book_alldetails_tojson(data[0])




# Define an API endpoint for retrieving unique book titles based on a query
@app.route('/api/titles-all', methods=['GET'])
def titles_all():
    # Retrieve query parameters from the request
    query_str = request.args.get('query', '')

    # Strip the spaces and check the length
    # If the length is 0, return an empty list as JSON
    if len(query_str.strip()) == 0:
        return book_onlytitles_tojson(None)
    else:
        # Get indices of top book recommendations using BM25 algorithm
        indices = bm25_top_hits(query=query_str,
                                tfidf_model=tfidf_model,
                                bm25_index=bm25_index,
                                dictionary=dictionary,
                                n=30)
        # If no indices are found, return an empty list as JSON
        if indices is None:
            return book_onlytitles_tojson(data=None)
        else:
            # Retrieve book titles based on the indices
            titles = book_onlytitles_byindex(indices=indices, cs=cs)
            return book_onlytitles_tojson(titles[0])




# Define an API endpoint for retrieving unique book titles based on a query
@app.route('/api/books-search', methods=['GET'])
def books_search():
    # Retrieve query parameters from the request
    query_str = request.args.get('query', '')

    # Strip the spaces and check the length
    # If the length is 0, return an empty list as JSON
    if len(query_str.strip()) == 0:
        return book_searchdetails_tojson(None)
    else:
        # Get indices of top book recommendations using BM25 algorithm
        indices = bm25_top_hits(query=query_str,
                                tfidf_model=tfidf_model,
                                bm25_index=bm25_index,
                                dictionary=dictionary,
                                n=30)
        # If no indices are found, return an empty list as JSON
        if indices is None:
            return book_searchdetails_tojson(data=None)
        else:
            # Retrieve book titles based on the indices
            titles = book_searchdetails_byindex(indices=indices, cs=cs)
            if (len(titles[0]) >= 6):
                titles[0] = titles[0][:6]
            return book_searchdetails_tojson(titles[0])

# Run the Flask application in debug mode if the script is executed directly
if __name__ == '__main__':
    app.run(debug=True)
