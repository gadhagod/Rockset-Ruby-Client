module Rockset
    require "json"
    require "uri"
    require "net/http"

    class InvalidQuery < StandardError
    end

    def Rockset.auth(api_key, server)
        $key = api_key
        $server = "https://#{server}/v1/orgs/self"
    end

    def Rockset.query(query)
        uri = URI("#{$server}/queries")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{\"sql\": {\"query\": \"#{query}\"}}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.validate_query(query)
        uri = URI("#{$server}/queries/validations")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{\"sql\": {\"query\": \"#{query}\"}}"
            http.request(req)
        end
        if res.code == "200"
            return("Valid")
        else
            raise(InvalidQuery.new(res.body))
        end
    end

    def Rockset.add_docs(docs, collection, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections/#{collection}/docs")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{\"data\": #{docs.to_json}}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.del_docs(docs, collection, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections/#{collection}/docs")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Delete.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{\"data\": #{docs.to_json}}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.patch_docs(docs, collection, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections/#{collection}/docs")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Patch.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{\"data\": #{docs.to_json}}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.add_collection(collection_metadata, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "#{collection_metadata.to_json}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.del_collection(collection, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections/#{collection}")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Delete.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.get_collection(collection, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections/#{collection}")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Get.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.get_collection_qlambdas(collection, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/collections/#{collection}/lambdas")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Get.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.get_collections
        uri = URI("#{$server}/collections")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Get.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.get_workspace_collections(workspace="commons")
        uri = URI("#{server}/ws/#{workspace}/collections")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Get.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.get_org
        uri = URI("#{$server}")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Get.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.add_qlambda(name, query, description="", default_params=[], workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/lambdas")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{
                \"name\": \"#{name}\",
                \"description\": \"#{description}\",
                \"sql\": {
                    \"query\": \"#{query}\",
                    \"default_parameters\": #{default_params.to_json}
                }
            }"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.del_qlambda(qlambda, workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/lambdas/#{qlambda}")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Delete.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end

    def Rockset.exec_qlambda(qlambda, version, parameters=[], workspace="commons")
        uri = URI("#{$server}/ws/#{workspace}/lambdas/#{qlambda}/versions/#{version}")
        res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            req = Net::HTTP::Post.new(uri)
            req["Content-Type"] = "application/json"
            req["Authorization"] = "ApiKey #{$key}"
            req.body = "{
                \"parameters\": #{parameters.to_json}
            }"
            http.request(req)
        end
        return(JSON.parse(res.body))
    end
end