module.exports=
class GoogleResultView
  constructor: (response) ->
    @element=document.createElement('div')
    @element.classList.add('scroll-view')
    @heading=document.createElement('h1')
    @heading.textContent="Results of Google search for #{response.queries.request[0].searchTerms}"
    @element.appendChild(@heading)
    for x in response.items
      @res=document.createElement('div')
      @res.classList.add('google-result-item')
      @link=document.createElement('a')
      @link.setAttribute('href',x.link)
      @link.textContent=x.title
      @res.appendChild(@link)
      @snippet=document.createElement('div')
      @snippet.textContent=x.snippet
      @res.appendChild(@snippet)
      @element.appendChild(@res)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  getTitle: ->
    "Google search results"
