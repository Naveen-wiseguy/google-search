GoogleSearchView = require './google-search-view'
GoogleSearchClient = require './google-search-client'
GoogleSearchResult=require './google-result-view'
{CompositeDisposable} = require 'atom'
request = require 'request'

module.exports = GoogleSearch =
  googleSearchView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @googleSearchView = new GoogleSearchView(state.googleSearchViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @googleSearchView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'google-search:toggle': => @toggle()
    @subscriptions.add atom.commands.add @googleSearchView.getElement(),
      'core:cancel': => @toggle()
      'core:confirm': => @process()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @googleSearchView.destroy()

  serialize: ->
    googleSearchViewState: @googleSearchView.serialize()

  toggle: ->
    console.log 'GoogleSearch was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
      #@googleSearchView.setFocus()

  process: ->
    client=new GoogleSearchClient()
    client.request(@googleSearchView.getTag(),@display)
    @toggle()

  display: (response) ->
    if response==null
      console.log("Error from search")
    else
      #Creating a view item to display the results
      @result=new GoogleSearchResult(response)
      @modalPanel = atom.workspace.addModalPanel(item: @result.getElement(), visible: true)
      # newWindow=atom.workspace.open()
      # newWindow.then((editor)->
      #     editor.insertText("Responses from Google search :\n")
      #     for x in response.items
      #       editor.insertText("#{x.title}\n")
      #       editor.insertText("#{x.link}\n")
      #       editor.insertText("#{x.snippet}\n"))
      #       )
