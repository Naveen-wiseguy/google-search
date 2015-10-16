module.exports =
class GoogleSearchView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('google-search')

    # Create message element
    message = document.createElement('div')
    message.textContent = "Enter the search term :"
    message.classList.add('message')
    @searchtag=document.createElement('atom-text-editor')
    @searchtag.setAttribute('mini',true)
    @element.appendChild(message)
    @element.appendChild(@searchtag)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

  getTag: ->
    @searchtag.getModel().getText()

  setFocus: ->
    @searchtag.focus()
