request = require 'request'

module.exports =
class GoogleSearchClient

  constructor: ->


  request: (tag,callback) ->
    options =
      uri: "https://www.googleapis.com/customsearch/v1?key=AIzaSyCqorZ3JA6b7OoWdbvJvJbijy2RipHGe-w&cx=012493601492997370571:g3rffka0quq&q=#{tag}"
      method: 'GET'
      gzip: true
      headers:
        'User-Agent': 'Atom-Google-Search'
    options.proxy = process.env.http_proxy if process.env.http_proxy?
    request options,(error,res,body) ->
      if not error and res.statusCode is 200
        try
          response = JSON.parse(body)
        catch
          console.log "Error: Invalid JSON"
          response = null
        finally
          callback(response)
      else
        console.log "Error: #{error}", "Result: ", res
        response = null
