# Rockset Ruby Client
A Ruby client library for Rockset.

![](https://img.shields.io/gem/v/rockset)

## Installation

    gem install rockset

## Usage

    # Include library
    require "rockset"

    # Authorize instance
    Rockset.auth(api_key="TOKEN HERE", server="api.rs2.usw2.rockset.com")

    # To test everything is working, get your organization info
    puts Rockset.get_org

## Documentation

---------------

#### `query`
**Description**: Make an SQL query \
**Parameters**: 
* query: The query to be performed, required, string 

**Example**: `Rockset.query("select * from commons.famous_ppl where _id='94'")`

---------------

#### `validate_query`
**Description**: Validate an SQL query \
**Parameters**: 
* query: The query to be validated, requrired, string 

**Example**: `Rockset.validate_query("select * from commons.famous_ppl where _id='94'")`

---------------

#### `add_docs`
**Description**: Add documents to a collection \
**Parameters**:
* docs: The documents to be added, required, list containing hashes
* collection: The collection to be added documents to, requrired, string
* workspace: The workspace that holds the collection to be modified, optional, defaults to "commons", string

**Example**: `Rockset.add_docs([{name: "John Cena", _id:"94"}], collection="famous_ppl")`

---------------

#### `del_docs`
**Description**: Delete documents \
**Parameters**: 
* docs: The documents to be deleted, required, list containing hashes
* collection: The collection of documents to be removed, required, string
* workspace: The workspace that holds the collection to be modified, optional, defaults to "commons", string

**Example**: `Rockset.del_docs([{_id:"94"}], collection="famous_ppl")`

---------------

#### `patch_docs`
**Description**: Patch documents \
**Parameters**:
* docs: The documents to be patched, required, list containing hashes, hashes must have key `op` for patch operation, `path` for field path, and `value`.
* collection: The collection of documents to be patched, required, string
* workspace: The workspace that holds the collection to be modified, optional, defaults to "commons", string

**Example**: `Rockset.patch_docs([{op: "add", path: "occupation", value: "wrestler"}])`

---------------

#### `add_collection`
**Description**: Add a collection \
**Parameters**:
* collection_metadata: Metadata for collection to be added, must have key `name`, can have `description`, `sources`, `retention_secs`, `event_time_info`, `field_mappings` (Check [Rockset Docs](https://docs.rockset.com/rest-api/#createcollection) for more info)
* workspace: The workspace that holds the collection to be added, optional, defaults to "commons", string

**Example**: `Rockset.add_collection({name: "famous_ppl"})`

---------------

#### `del_collection`
**Description**: Delete a collection \
**Parameters**:
* collection: The collection to be deleted, required, string
* workspace: The workspace that holds the collection to be deleted, optional, defaults to "commons", string

**Example**: `Rockset.del_collection("famous_ppl")`

---------------

#### `get_collection`
**Description**: Get collection info \
**Parameters**: 
* collection: The collection to be got, required, string
* workspace: The workspace that holds the collection to be got, optional, defaults to "commons", string

**Example**: `Rockset.get_collection("famous_ppl")`

---------------

#### `get_collection_qlambdas`
**Description**: Get collection query lambdas \
**Parameters**:
* collection: The collection with the query lambdas to be got, required, string
* workspace: The workspace that holds the collection with the query lambdas, optional, defaults to "commons", string

**Example**: `Rockset.get_collection_qlambdas("famous_ppl")`

---------------

#### `get_collections`
**Description**: Get info on all collections \
**Example**: `Rockset.get_collections`

---------------

#### `get_collection_qlambdas`
**Description**: Get collection query lambdas \
**Parameters**:
* collection: The collection with the query lambdas to be got, required, string
* workspace: The workspace that holds the collection with the query lambdas, optional, defaults to "commons", string

**Example**: `Rockset.get_workspace_collections("famous_ppl_projects")`

---------------

#### `get_org`
**Description**: Get organization \
**Example**: `Rockset.get_org`

---------------

#### `add_qlambda`
**Description**: Add a query lambda \
**Parameters**:
* name: The name of the query lambda, required, string
* query: The query of the query lambda, required, string
* description: The description of the query lambda, optional, string
* default_params: The default parameters of the query lambda, optional, list of hashes with keys `name`, `type`, `value` \
* workspace: The workspace that holds the query lambda, optional, defaults to "commons", string

**Example**: `Rockset.add_qlambda("john_cena_search", query="select * from commons.famous_ppl where name='John Cena'")`

---------------

#### `del_qlambda`
**Description**: Delete a query lambda \
**Parameters**:
* qlambda: The name of the query lamda to be removed, string, required
* workspace: The workspace that holds the query lambda, optional, defaults to "commons", string

**Example**: `Rockset.del_qlambda("john_cena_search")`

---------------

#### `exec_qlambda`
**Description**: Execute a query lambda \
**Parameters**: 
* qlambda: The name of the query lambda to be executed, required, string
* version: The version of the query lambda to be executed, required, string
* parameters: The parameters of the query lambda, optional, list
* workspace: The workspace that holds the query lambda, optional, defaults to "commons", string

**Example**: `Rockset.exec_qlambda("john_cena_search", version="24cw39j")`

## To do
* `get_qlamda` function
* support data source integrations
* support aliases
* more query lambda options
